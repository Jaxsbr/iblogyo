---
title: Integrate with AWS Comprehend SDK in C#
date: 2023-05-06 06:57:37
tags:
    - AWS
    - Comprehend
    - AI
    - C#
    - Integration
---

# Overview

AWS Comprehend is an easy to use cloud service that allows you to comprehend text by labeling each word with a language type such as `verb`, `noun`, `proper noun` and others. A probability rating is also assigned allowing you to detemine how sure AWS Comprehend was about it's clasification.

In the post I will demonstrate how to use AWS Comprehend to take plain text and find specific word matches and bind them with executable commands. The commands I use here assumes we want to generate code repositories/projects.

## Example Usage

**Given Text:** Create a new website named Eventz  
**Task Output:** Generate a new React git repo and name it Eventz  

- **Create** a verb that indicates the need to make something from scratch.
- **new** an adverb that indicates the something that needs to be made from scratch.
- **website** a noun that indicates that front-end programming technology is to be used.
- **Eventz** a proper noun that represents the "something's" identity or name.

NOTE: This is a very basic example and will only work for a couple of very specific text phrases. For more accuracy we'd need to utilize other techniques such as Large Language Models (LLM) to determine if the word is similar to something VS just a direct match.
e.g. website/front-end/page could all be considered accurate as web specific project.

## Example Repo

You can checkout [this](https://github.com/Jaxsbr/AWSComprehendExample) example repo where I invoke the dotnet cli to manage projects based on a text phrase. It uses AWS Comprehend to extract meaning and matches it up with pre defined dotnet cli commands.

## Basic Use

### AWS Comprehend SDK

Install via package manager console.
`Install-Package AWSSDK.Comprehend -Version 3.7.104.10`

Or add directly to your `csproj` file
```xml
  <ItemGroup>
    <PackageReference Include="AWSSDK.Comprehend" Version="3.7.104.10" />
  </ItemGroup>
```

### Configuration

```C#
using Amazon;
using Amazon.Comprehend;
using Amazon.Comprehend.Model;
using System.Diagnostics;

AWSConfigs.AWSProfileName = "your-aws-profile";
var comprehendClient = new AmazonComprehendClient();
```

### Things our system cares about

```C#
var verbs = new string[] { "create", "delete" };
var projectTypes = new string[] { "desktop", "website" }
var actions = new List<List<string>>
{
    { "create", "desktop", CreateDesktop },
    { "create", "website", CreateWebsite },
    { "delete", "desktop", DeleteDesktop },
    { "delete", "website", DeleteWebsite }
};

public void CreateDesktop (string projectName) 
{ 
    // Some code that creates a desktop application code repository 
}

// ....
// CreateWebsite(string projectName) 
// DeleteDesktop(string projectName) 
// DeleteWebsite(string projectName) 

```

### Comprehention Detect Syntax (clasify)

```C#
var detectedSyntaxRequest = new DetectSyntaxRequest
{
    LanguageCode = SyntaxLanguageCode.En,
    Text = "create a new website named Eventz"
};
var detectedSyntaxResponse = await comprehendClient.DetectSyntaxAsync(detectedSyntaxRequest);
```

### Process the detected syntaxt repsonse

At this point we have a categorized version of our original text. By processing the words and their assigned `Part Of Speech Tag Type` we determine if there are words that match parts our system cares about. Once we find a match, we store those words as specific variables that we'll use later to build executable commands.

```C#
// The thing that needs to be done. e.g. Creating/Deleting
string projectAction = "";

// The type of thing. e.g. Desktop/Website code repository type
string projectType = "";

// Finally the the name of the thing. e.g. Eventz
string projectName = "";

foreach (var syntaxToken in detectedSyntaxResponse.SyntaxTokens)
{
    var partOfSpeechTag = syntaxToken.PartOfSpeech.Tag;

    if (partOfSpeechTag == PartOfSpeechTagType.VERB && verbs.Contains(partOfSpeechTag.ToLower()))
    {
        projectAction = syntaxToken.Text;        
    }

    if (partOfSpeechTag == PartOfSpeechTagType.NOUN && projectTypes.Contains(partOfSpeechTag.ToLower()))
    {
        projectType = syntaxToken.Text;        
    }

    // Proper nouns contain are determined to have high probability of being a name
    if (partOfSpeechTag == PartOfSpeechTagType.PROPN)
    {
        // Preserve casing
        projectName = syntaxToken.Text;
    }
}
```

### Bind comprehentions the executable commands

```C#
var action = actions.Where(x => x.Contains(projectAction) && x.Contains(projectType));

// The third item (0 based = 2) in each action list represents the action to execute.
var actionCommand = action[2];

// Execute the action command that will create or delete a desktop or website by name
action(projectName);

```