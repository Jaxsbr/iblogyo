---
title: AWS Amplify authentication with Cognito
tags:
  - AWS
  - Amplify
  - SPA
  - Cognito
  - React
date: 2022-06-10 15:10:21
---


AWS Amplify takes away a lot of the heavy lifting around hosting and deploying single page applications (SPA). But an application is useless if we can't control user access to it.

## Overview
This post details the actions needed to:
- Create an Amplify project
- Add Cognito authentication to Amplify
- Add Users and User Groups to Cognito

Assumptions
- You have a React app (I used create-react-app)
- You have this app in a compatible Amplify version control (I used CodeCommit)


## Create an Amplify project

Start in the AWS Amplify Console and select the **Build app option**

Select the Hosting environments tab
- Select a code repository the contain your UI code
  - Connect a branch (select repo and branch)
- Configure build settings
  - Create environment (e.g. staging/prod)
  - Enable CICD (deploy on each front or backend commit)
- Specify a service role (Allows Amplify to access your other AWS resources)
  - Create a Service Role 
    - Select Amplify service
    - Select AdministratorAccess-Amplify    
- After this you can review build settings in a generated yaml file
- Save and deploy the app
- You can now click on the **Domain** URL to view your live app.

## Authentication

### Configure SPA App

Install the aws amplify dependencies
```bash
npm install aws-amplify
```

Add a UI mechanism for sign-up, sign-in and sign-out.  
Two options for doing this are:
1. [Pre-built UI components](https://docs.amplify.aws/lib/auth/getting-started/q/platform/js/#option-1-use-pre-built-ui-components) (Opting for this one)
2. [API calls](https://docs.amplify.aws/lib/auth/emailpassword/q/platform/js/)

Install components for React
``` bash
npm install aws-amplify @aws-amplify/ui-react
```

Example of my App.js file
```js
import { Amplify } from 'aws-amplify';

import { withAuthenticator } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';

import awsExports from './aws-exports';
Amplify.configure(awsExports);

function App({signOut, user}) {
  return (
    <>
      <h1>Hello {user.username}</h1>
      <button onClick={signOut}>Sign out</button>
    </>
  );
}

export default withAuthenticator(App);

```


### Configure Amplify App

Select the Backend environments tab
- Initialy you have to click "Get Started" to enable the Backend tab. This takes a few minutes
- Click Launch Studio
- Go to the Set up > Authentication tab
  - Add a login mechanism. (this is where you can specify federate login types. e.g. Google or Facebook). I chose a simple Email mechanism.
  - Specify Sign-in & sign-out URL's. 
    - This allows for multiple URLs. I specified both my local and production URL's to allow login requirements for both environments.
  - You and also setup MFA and password rulese here. I opted for all the defaults, no MFA.
  - Deploy
- Save the new authentication setup. This will start a CloudFormation deployment.
- You can view the created authentication resouces in Cognito or CloudFormation.

### Add users and groups

While still in the Amplify Studio
- Select the Manage > User management tab
- In the Users tab click Create User
  - Specify email and temporary password
- In the Groups tab click Create Group
  - Specify a group name
  - Select the new group and click Add User
  - Specify the users to add

### Disable self-service sign-up

By default users can register as user by following a Sign-up and email verification flow. For my purposes however I want a very specific list of users to have access to the app, thus I'd want to prevent the default sign-up action being possible.

Go to AWS Cognito in the console
- Select the user pool
- Under the Sign-up experience tab select Edit self-service sign-up
  - Uncheck Enable self-registration
  - Save changes

NOTE: this does not hide the "Create Account" option, merely prevents successful sign-ups. Ideal would be to hide as well.

## Resources
https://docs.amplify.aws/console/
https://docs.amplify.aws/console/auth/authentication/
https://docs.amplify.aws/console/authz/authorization/