---
title: Boxyvault - Project Planning and Milestones
date: 2023-10-13 15:45:41
tags:
- Boxyvault
- Notion
- Milestones
- Tasks
- Project Planning
- Task Management
---

## Intro

In this post I'll talk about how I manage my personal projects and the initial milestones I'd like to reach while building [Boxyvault](https://jaxsbr.github.io/pkb-blog/2023/10/13/boxyvault-file-management/)

## Why project planning is needed?

Well, it's not needed, however as a software engineer working in the corporate environment I've seen the impact of not planning software project appropriately.

There are two thing I've seen happen when project planning is not executed well.

### Scope creep

Without proper boundaries or minimum viable product (MVP) definitions, a project can quickly gain new features.
These new features make sense during the projects initial phases but increase the likelyhood of resulting in the project not reaching deadlines, dissapointing users and failing due to withdrawl of stakeholder support.

Project planning should cap the features that are intended to be developed and clearly describe what will and won't be considered for Beta versions.

### Inefficient Development

When either the project planning tooling is lacking or the use of proper task management is not enforcement, chaos can ensue. In scenarios like this engineers use their own approaches to tracking progress and reporting back to stakeholders. Without a form of standardization information gets lost, duplicated or corrupted ultimiatly resulting in poor delivery performance.

Project planning should define how progress is tracked and reported on. This provides visibility success and potential blockers. This visibility is instrumental in allowing agile behavior during the projects development.

## My personal planning

Since I'm working on a personal project some of typical project planning requirement are less important as I report to myselft. However, being organised and having visibility of what to work on when is still highly valueble.

### How

I use the [Notion](https://www.notion.so/desktop) app to plan my projects. A simple page per project, Milestones and Tasks embeded databases helps create actionable task management.

Notion is great for this as it allow rich text editing, embeded URL links and uploading of files. The embeded database system is flexible and allows you to manage any type of data.

### Milestones

So what milestones do I have for Boxyvault?

- User Authentication (federated login to a Boxyvault front-end)
- CRUD Tags (tags are custom meta data you attached to a file)
- Upload And Tag Files
- View And Delete Uploaded Files
- Preview File Content (images and videos to show in the browser)

### Tasks

How do Tasks tie into Milestones?

Milestones are generally complex functionality that require many individual parts to be built, integrated and tested. Tasks, represent these individual steps to reach the Milestone.

Tasks are linked to their respective Milestones making it simple to see how the task is contributing to the bigger picture. In Notion it's also easy to utilize "Backlinks" to have tasks refer to one another when there is a need for making a dependency visible.

In my Tasks database I have a column called "Status" and this provides a mechanism for seeing what is pending, in-progress or completed.

Another great feature of Notion and the database system is that each record has an underlying Page representative. This means that if I need to add more context to a task, I can expand it's page and populate it with any amount of text, links, images and syntax highligted code snippets.

## Next

Stay tuned for the next post.
