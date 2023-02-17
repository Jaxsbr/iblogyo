---
title: 'How to Specify an AWS Profile in .NET SDK for DynamoDB'
tags:
    - AWS
    - Credentials
    - DynamoDb
    - .NET 
    - SDK
date: 2023-02-17 15:04:39
---

# Intro

Working with Amazon Web Services (AWS) DynamoDB in .NET applications can be a breeze with the AWS SDK for .NET. However, when working with multiple AWS accounts or users, it can become cumbersome to keep track of the different sets of AWS credentials. This is where AWS profiles come in handy.

In this article, we will explore how to specify an AWS profile while working with the .NET SDK for AWS DynamoDB. By using an AWS profile, you can simplify the process of managing multiple AWS accounts and ensure that your application uses the correct set of AWS credentials.

Then we'll provide a step-by-step guide on how to set up an AWS profile, install and configure the AWS SDK for .NET, and use the AWS profile with the .NET SDK for DynamoDB. By the end of this article, you'll have a better understanding of how to simplify your AWS credential management while working with DynamoDB in your .NET applications.

# Setting up the AWS Profile

## Prerequisites
- AWS CLI installed; see [these instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) for help
- AWS access and security keys generated; see [these instructions](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) for help

## Steps

To set up your AWS profile, follow these steps:

1. Open your command prompt or terminal window.
2. Run the `aws configure` command. This will prompt you for your AWS access key ID, secret access key, default region, and default output format preferences. Enter the values as prompted.
3. After you have provided the necessary information, AWS CLI will save the settings as the default profile in two files: `.aws/config` and `.aws/credentials`.
4. To set up an additional profile, run the `aws configure` command again, but this time include the `--profile MyProfileName` option. Replace `MyProfileName` with a name for your new profile.
5. Provide the necessary information for your new profile, such as access key ID, secret access key, region, and output format preferences, when prompted.
6. AWS CLI will save the settings for your new profile in the `.aws/config` and `.aws/credentials` files.

That's it! You now have multiple AWS profiles that you can use with the .NET SDK for DynamoDB.

# Installing and Configuring the AWS SDK for .NET

## Installing

To install the `AWSSDK.DynamoDBv2` package:

1. In Visual Studio's Solution Explorer for your project, right-click to show the context menu, and choose "Manage NuGet Packages".
2. In the NuGet Package Manager, search for the `AWSSDK.DynamoDBv2` package and select the latest version to install.

Your project will now have the necessary SDK packages installed for connecting to DynamoDB.

## Configuring

To use the default credentials with the `AmazonDynamoDBClient` object, you can simply instantiate the object without any parameters:

```csharp
AmazonDynamoDBClient client = new AmazonDynamoDBClient(); 
```

If you need to specify additional configuration options for your AmazonDynamoDBClient, you can create an instance of AmazonDynamoDBConfig and pass it to the constructor. For example, to set the AWS region to us-west-2, you can use the following code:

```csharp
AmazonDynamoDBConfig clientConfig = new AmazonDynamoDBConfig { RegionEndpoint = RegionEndpoint.USWest2 };
AmazonDynamoDBClient client = new AmazonDynamoDBClient(clientConfig);
```

# Using the AWS Profile with the .NET SDK for DynamoDB

## Configure an AWS profile

If you want to use a different AWS account than the one configured as default, you can use the profile you created in Section 2. To do this, you can specify the profile name and retrieve associated profile credentials. This code creates a `CredentialProfileStoreChain` object, which loads the credentials associated with a named profile from the AWS credentials file (~/.aws/credentials). If found, the credentials are passed to the `AmazonDynamoDBClient` object.

```csharp
var credentialProfileStoreChain = new CredentialProfileStoreChain();
if (credentialProfileStoreChain.TryGetAWSCredentials("MyProfileName", out var awsCredentials))
{
    AmazonDynamoDBConfig clientConfig = new AmazonDynamoDBConfig { RegionEndpoint = RegionEndpoint.USWest2 };
    AmazonDynamoDBClient client =  new AmazonDynamoDBClient(awsCredentials, clientConfig);
}
```

Note that you still need to specify the AWS region where your table is located, as shown in the code above.

## Advantages of using AWS profiles with the SDK

Using an AWS profile with the SDK has several advantages over hardcoding access and secret keys directly in your code. For one, it's more secure: instead of embedding your credentials in plain text within your code, you store them in a separate file that's encrypted and protected. This makes it more difficult for attackers to gain access to your AWS account.

Another advantage is that it simplifies the process of switching between AWS accounts or using different credentials for different applications. By creating multiple profiles with different access and secret keys, you can easily switch between them without having to modify your code or credentials each time.

Overall, using an AWS profile with the SDK improves security, simplifies the management of multiple AWS accounts, and makes it easier to maintain and modify your code.

# Conclusion

## Summary
In this blog post, we covered the steps for setting up and using AWS profiles with the .NET SDK for DynamoDB. We began by introducing the concept of AWS profiles and the benefits of using them, including increased security and ease of use. We then provided a step-by-step guide for setting up an AWS profile, including prerequisites such as installing the AWS CLI and generating access and security keys.

Next, we covered how to install and configure the AWS SDK for .NET and how to use the default profile. Finally, we explained how to use an AWS profile with the .NET SDK for DynamoDB, including an example code snippet and the advantages of using profiles for flexibility and ease of management.

By following the instructions and best practices outlined in this blog post, you should be able to set up and use AWS profiles with the .NET SDK for DynamoDB more effectively and securely, giving you greater peace of mind and allowing you to focus on building great applications.

## Resources

AWS CLI installation  
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html  

Access and Secret access keys  
https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys  

AWS Credentials Configuration  
https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/CodeSamples.DotNet.html#CodeSamples.DotNet.Credentials  

CredentialsProfileStoreChain and Alternatives  
https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/creds-locate.html