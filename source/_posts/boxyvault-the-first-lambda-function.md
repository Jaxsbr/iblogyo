---
title: Boxyvault - The first Lambda function
date: 2023-11-10 22:31:13
tags:
- AWS
- Lambda
- API Gateway
- CloudFormation
- DynamoDb
- Paging
- S3
- bash
- zip
---


## Overview

This entry delves into what I discovered while implementing the first Lambda function for Boxyvault. A couple of interesting and unexpected things appeared that is worth sharing such as needing to provision AWS S3 buckets before being able to deploy Lambda functions. Also my findings of improving logging code in Python.

- [The first Lambda function](the-first-lambda-function)
- [How do we handle filter arguments](#how-do-we-handle-filter-arguments)
- [Paging DynamoDb results in Lambda](#paging-dynamodb-results-in-lambda)
- [Infrastructure requirements](#infrastructure-requirements)
- [Lessons Learned](#lessons-learned)
- [Conclusion](#conclusion)

## The first Lambda function

What will the first Lambda function do? The objective is to retrieve file records that correspond to actual files stored in AWS S3.
However, we are not able to do this at the moment as much of the required components such as data storage do not exist yet. In order to make progress without these parts I'll develop some of the foundation pieces such as the Lambda function code, infrastructure, permissions and mock return data. Other parts like the AWS DynamoDb and relevant data schema will be implemented at a later stage.

The function will eventually return data from DynamoDb and optionally reduce the result set if a filter query is provided. Three potential fields I foresee being used for filtering is `tag`, `name` and `upload-date`. But for the sake of progress I will not implement filtering of the mock data.

`Tag` one of many text strings associate with a file, e.g. `un processed`, `holiday rotorua 2023`  

`Name` the name of the file being uploaded.  

`UploadDate` is the date when the file was uploaded. Useful for showing recent default content on a dashboard.

## How do we handle filter arguments

I will be invoking these Lambda functions via and API Gateway RESTful request.
This means we'll utilize typical mechanisms such as query parameters to deliver the filter arguments to the Lambda function. e.g.

```bash
GET /files?limit={limit}&start-key={start-key}&tag={tag}
```

All Lambda functions consist of an entry point usually referred to as it's `handler` function. Within this handler we are able to extract details about the calling operation, referred as the `context` and in this case it would contain the query parameters provided by the invoking endpoint URL.

In this way each Lambda function invocation will have the necessary argument values to filter which file record are to be returned.

## Paging DynamoDb results in Lambda

I anticipate that every Boxyvault user will upload many more files than one web page can display. I want to address this with data paging instead of infinite scrolling due to the simplicity of it's implementation. Additionally the amount of data on the web page will remain low and hopefully contribute to fast loading and overall snappy UI.

I will utilize two query parameters to orchestrate result paging.

- `limit` is the maximum number of records to return.
- `startKey` is the key of the item where the query should start. This is used for pagination.

## Infrastructure requirements

My chosen approach for deploying Lambda functions is to use `awscli` and `CloudFormation`. Given I've deployed other AWS resources like this previously I assumed that I'd need a simple CloudFormation template with my Lambda function declaration. But soon after looking into the Lambda service required properties, I realized there was a bit more work to do.

Lambda functions consist of three parts:

- IAM role that grants the function invocation access (can be invoked)
- Resource declaration that creates the function in AWS
- Code that the function runs when invoked

The first two is simple and can be declared in the CloudFormation template, the code section however is more involved. To link code to the Lambda function resource in the CloudFormation template, we first need to zip up the code which is done in a deployment script. Then we need to upload the zip file to an AWS `S3` bucket. The file can then be referenced in the Lambda function's properties within the CloudFormation template.

But wait, there's more. We need to provision an `S3` bucket before we can deploy a file.
Thus I've included a new `s3` section to the `Boxyvault-Infra` repository which contains both a CloudFormation template declaring the S3 bucket details as well as a deploy script that initiates the provisioning process. The deployment will typically be run before the Lambda function deployment process as a pre requisite.

## Lessons Learned

### Expected Lambda handler format in CloudFormation

When developing the CloudFormation for a Lambda function you have to provide a value for the `handler` property. This value is to be formatted and consists of two parts separated by a dot `.`:

- The handler file name. e.g. `my_handler.py`
- The handler function name. e.g. `my_handler_function`

Handler = `my_handler.my_handler_function`

### Directory structure required to invoke Lambda functions

The Lambda function's code file containing it's `handler` function needs to be located in the root directory

### IAM Role and Policy circular dependency

When declaring the `lambda:InvokeFunction` policy as a policy in the Lambda function execution role you may encounter a circular dependency error. The solution is to create a standalone policy and link it to the Lambda role instead.

## Conclusion

In our journey to add the first Boxyvault Lambda function, we've uncovered some insights. The need for provisioning AWS S3 buckets as a Lambda pre requisite has resulted in a new infrastructure section in the `Boxyvault-Infra` repository.

Prioritizing foundation pieces, Lambda code, infrastructure and mock data has set the stage for phased implementation. Filter arguments, handled via API Gateway RESTful requests, ensure we have flexibility within the handler function while extracting context details.

We've started thinking about data overload, a paging strategy using the `limit` and `startKey` parameters to ensure a responsive and smooth user experience.

As I continue building Boxyvault, I hope these foundational insights will lead to a scalable and efficient system.

[previous - Lambda function infrastructure](https://jaxsbr.github.io/pkb-blog/2023/10/16/boxyvault-lambda-infra/) - Stay tuned for next post

## Code Preview 😁

I'm adding this basic Lambda function code here for those interested in a simple starting point.

```python
import json
import logging

logging.getLogger().setLevel(logging.INFO)

data = [
    {
        "name": 'file One.pdf',
        "uploadDate": '2023-09-22T00:00:00Z',
        "tags": ['Holiday', 'Moving', 'Durban']
    },
    {
        "name": 'file Two.jpg',
        "uploadDate": '2023-09-21T00:00:00Z',
        "tags": ['Umhlanga', 'Airport', 'Beach']
    }
]


def get_all_files():
    return data


def handle_get_request(path):
    if path == '/files':
        result = json.dumps(get_all_files())
        logging.info(f'files returned: {result}')
        return get_valid_http_response(result)
        
    return get_invalid_http_response(404, 'Not Found')


def get_valid_http_response(response_data):
    return {
        'statusCode': 200,
        'body': response_data,
        'headers': {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Allow-Methods': '*',
            'Content-Type': 'application/json'
        }
    }

def get_invalid_http_response(code, message):
    return {
        'statusCode': code,
        'body': json.dumps(message)
    }


def lambda_handler(event, context):
    http_method = event['httpMethod']
    path = event['path']

    if http_method == 'GET':
        return handle_get_request(path)
    else:
        return get_invalid_http_response(405, 'Method Not Allowed')
```
