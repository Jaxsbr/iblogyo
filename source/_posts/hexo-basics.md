---
title: Hexo Basics
date: 2022-05-04 09:00:00
tags: [Hexo]
---

This blog was setup using Hexo. The following sections detail some of my learnings.

### So what is Hexo?

Hexo is a static website site generator. You create blog entries using markdown language which Hexo will convert to website content (HTML, CSS) ready to be hosted.

I followed a [tutorial series by Mike Dane](https://www.youtube.com/watch?v=Kt7u5kr_P5o&list=PLLAZ4kZ9dFpOMJR6D25ishrSedvsguVSm) to get me up and running and also utilized the [official Hexo documentation](https://hexo.io/docs/).


## Instalation

---

Add the hexo-cli tool globaly  
```
npm install -g hexo-cli
```

You can install the package instead, making the hexo commands only available within a project VS globaly anywhere.  
```
npm install hexo
```


## Getting Started

---

Creating the intial site.  
```
hexo init {name of your site}
```

Running the site.  
```
hexo server
```

## Scaffolds

---

Scaffolds folder contains template markdown files.  
These files acts as the starting file when creating new post, drafts or pages.  

You can create custom scaffolds by adding new **.md** files in the **_scaffolds** folder.

## Source

---

Source folder contains all your blog content content.  
***e.g hexo-basics.md***

## Themes

---

[Official Hexo themes](https://hexo.io/themes/)  
[How to install a theme](https://www.youtube.com/watch?v=A-muxF_6plc&list=PLLAZ4kZ9dFpOMJR6D25ishrSedvsguVSm&index=10)
- Themes folder contains a collection of styling content for the website.  
- The default theme include with Hexo is **Landscape**.  
- Themes can be customized or created from scratch.  
- Theme configs: **/_config.landscape.yml**


## config.yml

---

Configures various aspects of the site.  
**e.g.** `theme: landscape`

Set a url config to your actuall hosting site
```
url: https://yourhostingsite
```

I have a github.io space where my personal wesite lives. I want my blog to live as a sub page, with the content served from a different repository than the main site. To configure this I did the following:  
set the `url:` to https://jaxsbr.github.io/  
set the `root:` to /pkb-blog


## Posts, Drafts & Pages

---

### Post

Create a new post in the source/_posts directory. This automatically shows in your site.  
```
hexo new {post name}
```

A URL is specified for new post inthis format:
**http://baseAddress/year/mo/dy/postname**


### Draft

You can also create draft posts. These arent' show by default when launch the Hexo server.  
```
hexo new draft {draft post name}
```

To show drafts, run the server with this argument:  
```
hexo server --draft
```

Publish a draft (from _draft to _post):  
```
hexo publish {draft post name}
```

### Page

Creating a new page with Hexo, results in a new folder in the code structure.  
**/source/{your page name}**  
```
hexo new page {your page name}
```

You can access this directly, without a date format as seen with new posts above:
**http://baseAddress/MyPage**

## Generate and Deploy

We run the generate command to convert the markdown and other content to publishable website content.
```
hexo generate
hexo g
```

You can configure where the content is output to by setting the `public_dir:` property in **_config.yml** file.  
e.g. Note, I use a sub path to simulate what my directory looks like when live
```
public_dir: public/pkb-blog
```

[Deploy Documentation](https://hexo.io/docs/one-command-deployment)
Once we have website content, we can publish directly to Github.  
First I had to update the **_config.yml**
```
deploy:
  type: 'git'
  repo: 'https://github.com/Jaxsbr/pkb-blog.git'
  branch: main
```

Secondly I had to install a package the aids in git commits.
```
npm install hexo-deployer-git --save
```

To deploy we run
```
hexo deploy
```

## Time Saver

Once all of the above is setup and you only need to create content, using the following step will optimize your workflow.

1. Make you markdown change (actual blog content)
2. Run `hexo server` and preview changes
3. Run `hexo g -d` to both generate and deploy live