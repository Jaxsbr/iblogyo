---
title: Downloading S3 files with AWS Cognito Identity Pools
tags: 
    - AWS
    - Cognito
    - Identity Pools
    - JavaScript
    - nodejs
    - S3
---

## Goals
- Configure a Cognito Identity pool
- Retrieve credentials
- Request a S3 file download as authorized user

## Resources
- https://solomonmark.medium.com/uploading-downloading-and-deleting-files-in-amazon-s3-using-amazon-cognito-and-nodejs-5d9ffbd6c729
- https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/getting-started-browser.html
- https://github.com/aws/aws-sdk-js/releases
- https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/CognitoIdentityCredentials.html
- https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/CognitoIdentity.html
- https://nodejs.org/en/knowledge/advanced/streams/how-to-use-fs-create-read-stream/
- https://aws.amazon.com/blogs/developer/generate-presigned-url-modular-aws-sdk-javascript/

## Draft Steps
- Click on "Federated Identities" >> Create new identity pool
  - identity Pool Name: `Balloon Pop Game Downloader Identity Pool`
  - Un Check `Enable access to unauthenticated identities` (We only want authorized access)
  - Un Check `Allow Basic (Classic) Flow` (Enhanced authentication flow is recommended)
  - Authentication Provider: Cognito
    - User Pool ID: Get this from an existing Cognito User Pool.
        TBD - Link to AMPLIFY post
    - App client id: Get this from an existing Cognito User Pool under the App integration tab > App clients and analytics section
  - Save
  - View Details
  - Two roles a shown, One for authenticated and one for unauthenticated.
    - Add the following policy for the authenticated role
    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "mobileanalytics:PutEvents",
                    "cognito-sync:*",
                    "cognito-identity:*"
                ],
                "Resource": [
                    "*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:GetObject"
                ],
                "Resource":[
                    "arn:aws:s3:::yourbucketName/specificFolderName/*"
                ]
            }
        ]
    }
    ```
    - Add the following policy for the unauthenticated role
    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Deny",
                "Action": [
                    "*"
                ],
                "Resource": [
                    "*"
                ]
            }
        ]
    }
    ```
    - Click Allow, this will create the new roles.
    - On the "Sample code" side tab content page
      - Select your platform (JavaScript for me)
      - The generates some code for getting your credentials.
      ```JavaScript
        // Initialize the Amazon Cognito credentials provider
        AWS.config.region = 'us-southeast-2'; // Region
        AWS.config.credentials = new AWS.CognitoIdentityCredentials({
            IdentityPoolId: 'ap-east-1:{yourIdentityPoolId}',
        });
      ```
      - NOTE: Don't reveal the Identity Pool Id anywhere!!
- Now the Identity pool is configured to allow authorized users to download S3 files.
- Install the aws-sdk
```bash
   npm install aws-sdk
```


## Alternative - Signed URL
- Create a new lambda (python has an SDK for generating pre signed s3 urls)
- Update the lambda execution role to have access to the buckte object (getObject)
- Deploy and test the generated signed URL
- Create a new API gateway endpoint and link it with the Lambda
- Configure CORS and deploy the API endpoint
- Populate the href on the UI with the pre signed url