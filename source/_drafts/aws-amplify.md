---
title: AWS Amplify for building SPA apps with serverless backends
tags: [AWS, Amplify, SPA, Serverless]
---

## Intro
I recently built a simple game using MonoGame and C#. This game is a MVP and as such I'm not sure if it's good enough to put on Steam yet. I decided to collect some feedback from some trusted reviewers.

I decide to make a single page application (SPA) that could be used to collect this feedback. AWS Amplify stood out as and option as it provides some of the things I'll required namely:

- User authentication
- Configuration of a serverless backend
- Deployment and hosting

## What can a user do in this App?
- Users from my "reviewers list" must be able to sign-up (create an account)
- Users must be able to login
- Download the zipped up game code
- Complete a survey about the game
- View game installation and gameplay instructions


### Action log
- AWS console > AWS Amplify > Develop App
- App name: balloon-pop-game-feedback-collector
* Long init process (+- 3 mins)
- AWS CodeCommit > New repo > clone to local > create react app > push
- Hosting environments > AWS CodeCommit > select new repo and branch
- Configure build settings > Create new environment > specify environment (prod)
- Create new service role > AdminAccess-Amplify > use default name(amplifyconsole-backend-role) (add many roles, e.g. lambda, cognito)
- Build and test settings > confirm output directory
- Save, build, deploy and verify

