---
title: ChatGPT C# Integration
date: 2023-05-01 17:20:56
tags:
    - AI
    - ChatGPT
    - Integration    
---

## Overview

Just like many others I've been very excited about using ChatGPT.  
Here is a simple example of how you can integrate your own project with ChatGPT.  

Alternatively you can checkout this simple [proof reader](https://github.com/Jaxsbr/EasyProof) I made using ChatGPT.  

## Pre Requisites

You need to setup a billing account.  
https://platform.openai.com/account/billing/payment-methods

You need to create an API key.  
https://platform.openai.com/account/api-keys

Store your API Key securely.  
Note, I store it at the machine level but you could do this at process or user level.
e.g. Windows PC
``` Powershell
[System.Environment]::SetEnvironmentVariable('MY_OPEN_AI_API_KEY', 'your-sdk-api-key-value', 'Machine')
```

## SDK

I opted to use a SDK to integrate with ChatGPT's API.  

Here is their [list](https://platform.openai.com/docs/libraries) of official SDK's.  

I opted for a C# library, [Betalgo/OpenAi](https://github.com/betalgo/openai) by Betalgo.  

## Sample Code

``` C#
using OpenAI.GPT3;
using OpenAI.GPT3.Managers;
using OpenAI.GPT3.ObjectModels.RequestModels;
using OpenAI.GPT3.ObjectModels;

var apiKey = Environment.GetEnvironmentVariable(
    "MY_OPEN_AI_API_KEY", EnvironmentVariableTarget.Machine);

var openAIService = new OpenAIService(
    new OpenAiOptions() { ApiKey = apiKey });

var request = new CompletionCreateRequest
{
    Prompt = "Give me a list of books on AI",
    Model = Models.TextDavinciV3,
    MaxTokens = 1000,
};

var result = await _openAIService.Completions.CreateCompletion(request);

Console.WriteLine(result.Choices.FirstOrDefault().Text);
```