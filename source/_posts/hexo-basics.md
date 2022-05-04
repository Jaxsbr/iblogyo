# Hexo Basics
Hexo is a static site generator.

[Mike Dane - Hexo Tutorial Series](https://www.youtube.com/watch?v=Kt7u5kr_P5o&list=PLLAZ4kZ9dFpOMJR6D25ishrSedvsguVSm)

## Instalation

---

[installation](https://youtu.be/ARted4RniaU)  
[doc](https://hexo.io/docs/)

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

[site creation, 0 - 3:30](https://www.youtube.com/watch?v=0m2HnATkHOk)

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

Source folder contains all your content.  
***e.g blog posts***

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
url: https://jaxsbr.github.io/pkb-blog/
```

I'm yet to determine how to set the config to work both locally and deployed.  
Here's my temporary solution.  

Local
```
#root: ./
```
Deployed
```
root: ./
```

## Posts, Drafts & Pages

---

### Post

Create a new post in the source/_posts directory. This automatically shows in your site.  
`hexo new {post name}`  

A URL is specified for new post inthis format:
**http://baseAddress/year/mo/dy/postname**


### Draft

You can also create draft posts. These arent' show by default when launch the Hexo server.  
`hexo new draft {draft post name}`

To show drafts, run the server with this argument:  
`hexo server --draft`

Publish a draft (from _draft to _post):  
`hexo publish {draft post name}`

### Page

Creating a new page with Hexo, results in a new folder in the code structure.  
**/source/{your page name}**  
`hexo new page {your page name}`

You also have to directly access the URL (no data format):
**http://baseAddress/MyPage**

## Generate && Deploy

We run the generate command to convert the markdown and other content to publishable website content.
```
hexo generate
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