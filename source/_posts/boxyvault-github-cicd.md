---
title: Boxyvault Github CI/CD
date: 2023-12-22 06:41:48
tags:
- Boxyvault
- Github
- Actions
- OIDC
- IdP
- AWS
- CI/CD
- DevOps
- Build
- Deploy
- IaC
- Cloud
- CloudFormation
---

## Intro

In this post I'll talk about Boxyvault's code migration to Github and Open Id Connect (OIDC) learnings that enables build and deployment process implementation with Github actions (GHA).

## Repository Migration

In my [previous post](https://jaxsbr.github.io/pkb-blog/2023/12/03/boxyvault-github-migration/) I described why I'm planning to migrate Boxyvault's code repositories from AWS CodeCommit to Github. I've now officially completed this step. 😁  
Initially I thought this would involve some complexity but it was straight forward, especially since I discovered that Github provides an import mechanism that does all the heavy lifting for you.

When creating a repository in Github, typically you provide some details such as `repository name`, `description`, inclusion of `.gitigore` etc. On the particular [page](https://github.com/new) I discovered an `import` [link](https://github.com/new/import) and decided to try it out. Here you have to specify the clone URL where the `source` repository resides, in my case AWS CodeCommit. Followed by the desired repository name as well as specifying if you want a `private` or `public` repository. Once all the details are provided you can hit the `Begin import` button which will prompt you for login details pertaining to you `source` repository. After completing these steps the import finished without issue.

## Build & Deploy Migration

Up until this round of work, I've relied on a local build and deploy processes for deploying Boxyvault's cloud infrastructure to AWS. Typically by running a `bash` script that uses my local AWS profile to execute CloudFormation templates.

Going forward, I'd like to improve on these process in the following ways:

- Reduce manual errors related to the human element
- Catch mistakes in my infrastructure code automatically (linting)
- Orchestrate complex dependency chains without having to remember sequence or caveats
- Deploy infrastructure changes automatically on code changes

The driving force behind migrating to Github was due to being able to use Github actions to accomplish all the above mentioned goals.

## Is it safe to create AWS resources from GHA?

Short answer, it can be! It is up to us to follow Github and AWS best practices to ensure things are safe and don't compromise our credentials or cloud accounts.

In order to communicate with AWS from GHA, we need to authorize the GHA workflow sessions and thus allow them to use AWS services. Github describes two methods that can be used to securely configure AWS access:

- Store AWS secret id and key in Github secrets
- Use an AWS OIDC connection to provide short lived access tokens

The majority of online recommendations state that the latter option is recommended due to these benefits:

- Tokens are short lived
- No need to rotate long lived security keys

I opted to follow this option and documented what I did to get my first GHA workflow interacting with AWS.

## How do we establish an OIDC connection between GHA and AWS?

When the GHA runs, it will execute an assume role step. This step passes information to an AWS OIDC identity provider (IdP) for validation. If validation passes the GHA workflow session gains the same permission as the IAM role. This role has been associated with the particular OIDC connection. Then the GHA workflow can proceed with running various AWS commands. Once the workflow completes, this connection and associated authorization tokens are discarded due to the ephemeral nature of the GHA runners.

Here is a high level of required tasks:

- Create and OIDC IdP
- Create a role policy
- Create a role and OIDC association
- Attach the role policy to the role

### Create an IAM OIDC IdP

In AWS we create an OIDC identity provider (IdP) that is configured to allow connections from Github's public OIDC URL domain. i.e. `https://token.actions.githubusercontent.com`.  

Github has a special identifier called a `thumbprint` that we also need to provide. i.e. as of writing: `6938fd4d98bab03faadb97b34396831e3780aea1`

### Create an IAM role policy

We create a policy that outlines a set of execution permissions, all the things we want our GHA workflow to be authorized to do. e.g. Creating or listing a CloudFormation stack. For now this policy is not associated with anything, but we'll get to that soon.

### Create an IAM role and OIDC association

Now we create an IAM role that will be assumed by the GHA workflow. We associate this role with the OIDC IdP we created in the previous step. This is done by declaring `trusted entities` for the role.

The trusted entities allow the `sts:AssumeRoleWithWebIdentity` service and scopes access to specific Github organizations.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::AWS_ACCOUNT_PLACEHOLDER:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:sub": "repo:GITHUB_ORG_PLACEHOLDER/boxyvault-infra:ref:refs/heads/main",
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
```

### Attach the role policy to the role

Lastly we attach the [role policy](#create-an-iam-role-policy) to the new role, after which the role can be 1) assumed via OIDC in a GHA workflow and 2) perform various actions against AWS services.

## Automation

Initially I did all of these steps manually while following a guide (linked below - [references](#references)). But seeing that my goal for Boxyvault is to make it easy to setup, I knew this needed some automation.

I imagine this step to be one of the first things a Boxyvault admin/installer would have to do and thus some of it might be more manual. e.g. running a bash script. However, I wanted make sure it was way less complicated than following a detail configuration guide while performing steps on the AWS console. Therefore I wrote a bash script that will provision the role, permission policy and OIDC resources.

### New section - oidc

I created a new directory in the `boxyvault-infra` repository. This directory will contain both scripts and policy templates.

### Policy Templates

Initially I had a simple policy file that declared permissions, however I realized that other users would have to manually update this to reflect their AWS regions, account id and preferred resources names. Instead I'd like to capture all these details when the script is run an then automatically update the various policy files.

To do this, I created a `template-policy` file that has specific placeholder values. With some shell magic I copy the template files content, replace the content placeholder values with actual values and write out the update content to an "actual" policy file. The script then uses this newly create policy file while provisioning the required resources.

### Stucture

- oidc
  - configure.sh
  - infra-deployment-policy.json
  - oidc-policies-template.json
  - oidc-policies.json (git ignored)

### Documentation

Because this is a very important step, so important that Boxyvault will not be provision-able if it's not done first, I have to document the setup for future me and other users. I wrote up some draft details in a readme.md but soon realized that this is one of many similar complex scenarios and that a single readme file would not suffice. To address this need, I've added a new milestone for Boxyvault's development in my task tracking process, aka, Notion. This entails creating a space or system where I can capture the gotchas and how-to's as well as the details of how some of the complex things work.

I've seen people use separate Github repositories to act as a central documentation area that can link multiple components and repositories together in one space and think this might be a simple solution. Saying that, I will checkout some other options when I get there.

## References

https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/
https://docs.github.com/en/rest/actions/oidc?apiVersion=2022-11-28
https://scalesec.com/blog/oidc-for-github-actions-on-aws/

## Conclusion

Boxyvault is now operating out of Github, both repository management as well as with it CI/CD processes. As of now, the existing manual deployment steps I used previously need to all be migrated to new github action workflows. I have a working POC that uses OIDC to grant access to AWS and will use this example to build out all the build and deploy steps.

I'm excited to have these new capabilities and believe this will serve Boxyvault and it's users very well.

[Previous - Boxyvault Github migration](https://jaxsbr.github.io/pkb-blog/2023/12/03/boxyvault-github-migration/) | Stay tuned for next post
