---
title: Amazon API Gateway - Throttling
tags:
  - AWS
  - Amazon API Gateway
  - Throttling
  - Rate limiting
date: 2022-07-08 15:28:49
---


## Intro
API Gateway provides me with great coordination and routing capabilities, but without the neccessary checks it can also put a big dent in my pocket. 💲💲💲  

I often prototype ideas that don't check the "production ready" criteria. This means that I can put something together quickly and have it meet my needs, but at the same time be vulnerable to accidental/intentional over-use.  

The post constains details on how throttling works and how to configure it, even for smaller projects. 😉

## Request submission measurement

A "token bucket algorithm" is used to measure request submision rate.

> API Gateway doesn't enforce a quota on concurrent connections. The maximum number of concurrent connections is determined by the rate of new connections per second and maximum connection duration of two hours. For example, with the default quota of 500 new connections per second, if clients connect at the maximum rate over two hours, API Gateway can serve up to 3,600,000 concurrent connections.

## Request measurement types

There are two types of usage clasification used to messure API requests, namely, steady-state and burst request.

#### Steady State

A request per second (RPS) measure accross all API's within an AWS account, per Region. This is what can be considered normal request rate traffic for your API endpoints. Also refered to as the **token**.

#### Burst

A maximum concurrent request rate accross all API’s within an AWS account, per Region. Typically and unexpected amount of request in a given period of time. Also refered to as the **bucket**.

## Throttling options

API Gateway provides these options for configuring throttling:
- Account-level: All routes and stages use the same throttling limit
- Stage-level: All routes in the statge uses the same throttling limit
- Route-level: Only the individual route uses the configured throttling limit

NOTE: the default route throttling limits can't exceed the account-level rate limits, we have to configure explicitly to do so.

## Limitation and quotas

There is a cap of what limits can be set per account per region. This can however be adjusted via by reaching out to AWS Support Center.

## So what does the API caller see when throttled?

They get back a `429 Too Many Requests` error response

## References
- [Throttle API requests for better throughput](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-request-throttling.html)
- [Throttling request to your HTTP API](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-throttling.html)
- [Amazon API Gateway quotas and important notes](https://docs.aws.amazon.com/apigateway/latest/developerguide/limits.html)
- [Request higher request quota - AWS Support Center](https://console.aws.amazon.com/support/home#/)
- [CloudFormation ThrottleSettings](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-apigateway-usageplan-throttlesettings.html)
- [AWS API Gateway Throttling – Setup and Walkthrough](https://beabetterdev.com/2021/10/01/aws-api-gateway-request-throttling/)
