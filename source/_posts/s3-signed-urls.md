---
title: Sharing S3 files securely with Signed Urls
tags:
  - AWS
  - Cognito
  - Signed Url
  - Python
  - Boto3
  - S3
  - AWS Lambda
  - API Gateway
  - DynamoDB
date: 2022-07-01 06:49:39
---


## Background

I built a single page application (SPA) that allows users to get download access to a game I'm developing in my spare time. After downloading and playing the game, users can also can fill in a survey to provide any feedback or suggestions.
This post details how I'm securing the download link so that only authorized users have access.

### Component flow

1. The app can be logged into via AWS Cognito. This authorizes the user session and allows secure calls to Amazon APIGateway.
1. A RESTfull Amazon API Gateway is used to invoke AWS Lambda functions that retrieve and store any data needed by the app.  
2. Survey and other data is stored in and Amazon DynamoDb table.
3. Game download files are stored in an Amazon S3 bucket.

### S3 Signed Urls

The solution is to secure the download by generating a signed url based on the users current auth session. Once they log out, their session expires and the the Url no longer works. From the different methods of generating signed urls, using a **SDK** fits my use case the best as it allows the ability to programatically create a Url when the app loads information.
[Generating a presigned URL to share an object](https://docs.aws.amazon.com/AmazonS3/latest/userguide/ShareObjectPreSignedURL.html)

> By default, all S3 objects are private. Only the object owner has permission to access them. However, the object owner can optionally share objects with others by creating a presigned URL, using their own security credentials, to grant time-limited permission to download the objects.  

## But how?

I decided to create a new Lambda function that can access my S3 bucket and generate a signed Url. The AWS how-to guide lists four SDK options:
- Java
- .NET
- PHP
- Python

### Python Lambda

I've never done any Python before, but the sample looked the most straight forward and thus I opted to use it.  
Here's what I ended up with:
```Python
import json
import boto3

def lambda_handler(event, context):
    
    url = boto3.client('s3').generate_presigned_url(
    ClientMethod='get_object', 
    Params={'Bucket': 'my-bucket-name', 'Key': 'game-dist-build-version'},
    ExpiresIn=86400)
    
    return {
        'statusCode': 200,
        'body': url,
        'headers': {
            'Access-Control-Allow-Origin': '*',
        }
    }
```

#### Boto3

What is it? It's a Python SDK used to access AWS services.
[Boto3 documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)

> You use the AWS SDK for Python (Boto3) to create, configure, and manage AWS services, such as Amazon Elastic Compute Cloud (Amazon EC2) and Amazon Simple Storage Service (Amazon S3). The SDK provides an object-oriented API as well as low-level access to AWS services

`boto3.client('s3').generate_presigned_url`
Here we request the S3 'module' and execute the `generate_presigned_url` functionality.


#### Parameters

- **Bucket**: The name of the S3 bucket that contains the build artifacts for my game.
- **Key**: The specific version of the game I'm granting access to.
- **ExpiresIn**: How long the Url remains valid for. 86400 seconds translates to one day.

### Other steps

- Create a new GET endpoint in the API Gateway. e.g. https://your-api-host/your-environemnt/artifacts/artifact-version
- Connect the new endpoint to the Python Lambda.
- Configure the Python Lambda's execution role to have read access to the S3 bucket.
- Consume the new GET endpoint in the SPA.