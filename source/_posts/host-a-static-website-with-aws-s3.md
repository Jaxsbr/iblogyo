---
title: Host to host a static website with AWS S3
date: 2022-05-19 06:16:57
tags: 
    [AWS, S3, CloudFormation, Bash, Script, Static Website Hosting]
---

I recently hosted a static website on AWS S3. This is pretty straight forward if you already have an AWS account and user/role configured with Adminstrator priviledges. You basically create a S3 bucket, make is public and upload your website content directly from the AWS console. 

I had to tweak a couple of things on my journey and ended up re-doing some of the setup. Because of this I decided to see how to automate the infrastructure and also the content deployment process for when my static site needed updating.

# Plan of Action

Here are the things we need to do:
- Install the AWS CLI and configure your AWS credentials. (your local PC)
- Create an infrastructure file that defines a publicly accessible S3 bucket.
- Create an infrastructure deployment script.
- Create a content deployment script


## AWS CLI and config

You can install the AWS CLI from [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).  
Ensure you have your AWS config and credentials setup like this.

**.aws/config**
```
[profile your-aws-profile]
region = us-east-1
output = json
```

**.aws/credentials**
```
[your-aws-profile]
aws_access_key_id = {your access key id}
aws_secret_access_key = {your access key}
```

## Infrastructure File

``` yaml
AWSTemplateFormatVersion: 2010-09-09

Parameters:
  BucketName:
    Type: String
    Description: Bucket Name
    Default: MyS3BucketWebsite

Resources:
  MyS3Bucket:
    Type: AWS::S3::Bucket
    Description: Bestest bucket eva
    Properties: 
      AccessControl: PublicRead
      BucketName: !Ref BucketName
      WebsiteConfiguration:
        IndexDocument: index.html
        ErrorDocument: error.html
  
  MyS3BucketPolicy:
    Type: AWS::S3::BucketPolicy
    Properties:
      Bucket: !Ref MyS3Bucket
      PolicyDocument:
        Statement:
          -
            Action:
              - s3:GetObject
            Effect: Allow
            Resource:
              - !Sub arn:aws:s3:::${MyS3Bucket}              
            Principal:
              AWS:
                - '*'
```
**NOTE: You are have to upload an `index.html` and `error.html` file in order for the site work properly.**

## Infrastructure Deployment Script

We will use CloudFormation to create the S3 bucket by executing a bash script. Typically you only do this once and can opt to just create your bucket in the AWS console instead. I like doing this scripting route for the following reasons:
- It gives me an easy way to re create my bucket if something ever goes wrong. e.g. hackers or me
- Serves as a template for new projects. Easy to copy, paste and modify.

I created a `deployInfra.sh` script that allows me to conditionally **create** or **update** the bucket.
The CloudFormation CLI command looks like this:
```
    aws cloudformation "$1" \
    --stack-name MyS3BucketWebsiteStack \
    --template-body file://./app.yaml \
    --profile your-aws-profile \
    --region us-east-1
```
The `$1` is an agument that is passed and can be either `create-stack` or `update-stack`.

<details>    
    <summary style="font-size:16px">
        See full script
    </summary>

``` bash
_defaultColor=$(tput sgr0)
_infoColor=$(tput setaf 3)
_updateCommand="update-stack"
_createCommand="create-stack"

function printInfo {
    printf "${_infoColor}$1${_defaultColor}"
}

function printInfoLine {
    printInfo "$1 \n"
}

function executeStackCommand {
    printInfoLine "Stack Command '$1' Starting..."
    aws cloudformation "$1" \
    --stack-name MyS3BucketWebsiteStack \
    --template-body file://./app.yaml \
    --profile your-aws-profile \
    --region us-east-1
}

printInfoLine "UI Deploy Script Starting..."

printInfoLine "Specify if you want to update or create this stack (update/create)"
read stackCommand

if [ "$stackCommand" == 'create' ]; then
    executeStackCommand $_createCommand
fi

if [ "$stackCommand" == "update" ]; then
    executeStackCommand $_updateCommand
fi

if [ "$stackCommand" != "update" ] && [ "$stackCommand" != "create" ]; then
    printInfoLine "Nothing selected, Goodbey!"
    exit 1
fi
```
</details>

## Content Deployment

S3 CLI comes with a really nifty command, `sync`. This does all the heavy lifting for you by synchronizing a source content with your S3 bucket.
- Configure the website content as the source (on your pc)
- Configure the S3 bucket to sync to.

```
aws s3 sync '/website-source-directory' 's3://MyS3BucketWebsite' \
--acl public-read \
--profile your-aws-profile \
--region us-east-1
```

I created a `deployContent.sh` script that executes the `sync` action.

<details>
    <summary style="font-size:16px">
        See full script
    </summary>

``` bash
_defaultColor=$(tput sgr0)
_infoColor=$(tput setaf 3)

function printInfo {
    printf "${_infoColor}$1${_defaultColor}"
}

function printInfoLine {
    printInfo "$1 \n"
}

printInfoLine "Sync S3 buck starting..."

aws s3 sync '/website-source-directory' 's3://MyS3BucketWebsite' \
--acl public-read \
--profile your-aws-profile \
--region us-east-1

printInfoLine "Sync S3 buck completed..."
```
</details>
