---
title: data-access-patterns
tags:
---

## Data Fields

- UserId (Cognito Id)
- Name (files name)
- UploadDate (iso 8601)
- Tags (array of strings)
- Id (S3 resource id)
- Meta (array with file metadata, size, type)
- Thumbnail (icons for data files, thumb nails for images and videos)

## The access pattern is as follows

- User uploads a file
- User adds tag(s) to the file
- User searches for files by tag, file name
- Users landing page load recent files uploads
- Users landing page load top X files by tag if configured

## Two tables

Not sure if I should have 2 tables (tags, files)
This seems to go into SQL world which I'd don't want to work with.

Problem:
How can I allow a user to manage tags?
Should I allow them to manage tags....Why, what benefit does this give?
If I don't allow management, how do we auto suggest tags when they search for files?
