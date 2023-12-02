---
title: Boxyvault - Github migration
date: 2023-12-03 07:00:00
tags:
    - Boxyvault
    - AWS CodeCommit
    - Github
    - Actions
    - CI/CD
    - CloudFormation
    - bash
    - IaC
    - GHA
---

## Intro

This week I will be focusing on an unexpected task, migrating Boxyvault's code repositories from AWS CodeCommit to a private Github repository. This was unexpected as I had initially planned to proceed with connecting my first AWS Lambda with either real data in DynamoDB or wiring it up to an APIGateway endpoint.

This log will describe why I've made this decision and talk about the benefits I expect to gain from it. Additionally I'm noting down all interesting discoveries and know-how's while I perform the actual technical bits so other can learn from it and I have something to refer to in the future when I forget.

## Background

Boxyvault is slowly growing in both front-end and infrastructure code, both repositories are hosted in AWS CodeCommit at the moment. Originally I placed the code with AWS due to a lack of knowledge. You see I'm a big fan of Github and started my software engineering career using it frequently, but I never put anything valuable or sensitive in there. At the time any free tier account had to be public, thus for projects I wanted to be private I used AWS CodeCommit which allowed private repositories on the free tier account.

Many years later, I've changed my professional role from software engineer to infrastructure engineer and landed in a team that owens Github as a product for the company I work at. This means the team is skilled at doing complicated things with Github and Github actions (GHA). Quite recently in this team I was made aware that Github has changed their free tier accounts to allow private repositories.
Hooray!

This is great news, but it's a lot of effort to migrate your repositories. Changing local git credentials, ensuring commits messages are retained, updating documentation and other engrained habits that require alteration. So there really needs to be a big enough trade off for me to actually do this migrations.

## Current State

All of Boxyvault's infrastructure is represented by AWS CloudFormation template files. Each template file has its own deployment script that looks up an AWS profile from my local computer and deploys the respective resources. To run these deployment scripts I execute then in a `bash` terminal and wait for an status output. Additionally I look at the AWS console to verify the script and resource template deployed as expected.

Another consideration is interdependencies between resources and the sequence in which they are provisioned. e.g. `S3` buckets need to exist before a Lambda function's code can be uploaded there and referenced in it's own resource template. At the moment I am mindful of the resource deployment order, but as Boxyvault grows I will inevitably become unable to remember all the specific hierarchies and sequential steps.

## Desired State

My vision for Boxyvault is get it up an running from scratch in a few minutes. Meaning that an engineer who clones the code can launch an instance of Boxyvault and start making changes soon after. I believe this will be made possible by configuring all infrastructure as code (IaC) and developing resources in a lightweight and decoupled manner.

The current structure of Boxyvault's infrastructure already facilitates this goals to some degree, but can be made more robust and less prune to human error. This brings us to the WHY, why I want to go through the effort of migrating my repositories from AWS CodeCommit to Github. Github provides a free tier CI/CD mechanism named Github actions (GHA) that integrates directly with your code repository. Workflows are defined that orchestrate complex DevOps processes and can be actioned from a web browser. The workflow, infrastructure and application code is secure as Github utilizes best practices such as multi factor authentication.

## Migration Phases

The migration will have two phases responsible for specific goals:

### Lift and shift

This is the actual transfer of code from AWS CodeCommit to Github. In this phase I need to ensure that all `git` information such as commit history is persisted and that my local credential are configured correctly. Initially I will keep the code repositories in AWS CodeCommit as a fallback, but will consider archiving them to prevent accidental commits to the wrong origin.

### Rework existing deployments

With the Github repositories in place I will create GHA workflows to represent the existing deployments. e.g. Identity, Lambda and S3. The current deploy scripts utilize my AWS profiles in order to provision AWS resources. During this phase I'll likely create dedicated AWS IAM roles for GHA deployments while following best security practices.

## Conclusion

I realized the need to do some foundational work that will start Boxyvault's CI/CD journey on good footing. An excellent learning experience is also in the cards for me with both Github repository management and GHA being domains I can sink my teeth into. Ultimately getting to a point where I can reliable build and deploy my infrastructure (for free 😁) is the benefit I'm after, as I believe this will help fast track Boxyvault's development

[previous - The first Lambda function](https://jaxsbr.github.io/pkb-blog/2023/11/10/boxyvault-the-first-lambda-function/) - Stay tuned for next post
