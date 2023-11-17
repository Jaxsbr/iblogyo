---
title: Boxyvault - Lambda function origins
date: 2023-10-16 07:32:47
tags:
    - Boxyvault
    - AWS
    - S3
    - Github Actions
    - Code Build
    - Code Deploy
    - Lambda function
    - IAM Role
    - CI/CD
---

This week I started planning how I will structure and deploy Lambda functions. The concern for me is that it should be easy to modify and maintain both the Lambda's code and infrastructure.

Thus far I've been using bash scripts to invoke the AWS CLI in order to create my infrastructure, but I'm quite curios to see if I can also get into some CI/CD tools, e.g. Github Actions or AWS's code build tools. My two requirements are:

- The CI/CD process or pipelines is also declared as code, nothing manually configured
- Secrets or tokens are secure an has a well documented approach for setting up.

This is important to me because I don't know if Boxyvault will be a Saas or a open source project, but both would benefit from having everything defined as code due to the flexibility and speed it will provide.

What follows is the loose structure I'm following for laying out the Lambda's code and infrastructure:

## Code Structure

```bash
# The source code for each function resides in a function specific directory
boxyvault-infra/lambda/getfiles
boxyvault-infra/lambda/uploadFile
boxyvault-infra/lambda/createTag

# Deploy script and infra template resides in the lambda root directory
# The template will describe both Lambda invocation roles and function resources
boxyvault-infra/lambda/deploy.sh
boxyvault-infra/lambda/template.yml
```

## Deploy

Deploying a Lambda function requires the following steps:

- Zip up the function code
- Push the zip file to AWS S3 and capture necessary resources Id's that links to the S3 object
- Link the S3 Id to the infrastructure template
- Deploy the Cloudformation resource via the AWS CLI

## CI/CD Tools

I've not yet decide on what tool I'd like to use but have two preferences:

- Github Actions
- AWS Code Build/Deploy

Why would I need this, could I not just run the individual deploy scripts?
My main reason for considering CI/CD tools are:

- Reliable deployments (pressing a button is less error prone than running a script with arguments)
- Provides a way to orchestrate multiple deploy scripts
- Allows me a unique upskilling opportunity that aligns with my day job

## So what is next?

The next task I want to work on is to get a simple Lambda function working and returning dummy data. Once I have this, I can build out the Lambda resource and IAM roles template file. Finally I need to make a deploy script that uses `awscli` to provision the Lambda functions and their roles. Additionally all the steps listed in [Deploy](#deploy) needs to be implemented.

## Conclusion

- Lambda function code is separated by function name, deployment and infrastructure files reside in the root `lambda` directory.
- I'm considering the introduction of CI/CD tooling into the project but need to look at pros and cons of my options.
- My next post will detail progress I've made on a dummy data Lambda function.

[Previous - Boxyvault Project Planning](https://jaxsbr.github.io/pkb-blog/2023/10/13/boxyvault-project-planning/) - [Next - The first lambda function](https://jaxsbr.github.io/pkb-blog/2023/11/10/boxyvault-the-first-lambda-function/)
