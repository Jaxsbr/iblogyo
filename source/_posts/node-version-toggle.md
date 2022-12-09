---
title: Toggle nodejs versions
tags:
  - nodejs
  - nvm
date: 2022-06-10 11:55:36
---


There has been a number times when I tried new frameworks or templates that depend on specific version of nodejs. When this happens I'm faced with skipping on the idea or messing around with my install version of nodejs, and inavertantly causing issue for some of my other projects.

## A simple solution

[nvm](https://github.com/nvm-sh/nvm) - Node Version Manager

Allows easy installations and toggling of nodejs versions


## Linux Install nvm
``` bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

## Windows Install nvm
Find the [latest release](https://github.com/coreybutler/nvm-windows/releases) from the NVM Github page  
Download the `nvm-setup.exe` and run it on you local computer. 

## Install nodejs version
``` bash
nvm install 12
nvm install 14
```

## Toggle current nodejs version
``` bash
nvm use 14
```