---
title: boxyvault-lambda-infra
date: 2023-10-16 07:32:47
tags:
---

This week I started planning how I will structure and deploy Lambda functions. The concern for me is that it should be easy to modify and maintain both the Lambda's code and infrastructure.

Thus far I've been using bash scripts to invoke the AWS CLI in order to create my infrastructure, but I'm quite curios to see if I can also get into some CI/CD tools, e.g. Github Actions or AWS's code build tools. My two requirements are:

- The CI/CD process or pipelines is also declared as code, nothing manually configured
- Secrets or tokens are secure an has a well documentend approach for setting up.

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
- Push the zip file to AWS S3 and capture neccessary resources Id's
- Link the S3 Id to the infrastructure template
- Deploy the Cloudformation resource via the AWS CLI
