---
title: "Python Mastery - General: Introduction to PyCharm"
date: 2023-05-24 06:42:35
tags:
    - Python
    - PyCharm
    - IDE
---

## Overview

We'll quickly setup and test the PyCharm integrated development environment (IDE) made by JetBrains. PyCharm is the most popular code editor for Python.

## Prerequisite: Installing Python

To use PyCharm, you need to have Python installed. If you haven't installed Python yet you can find info on the official [Getting Started](https://www.python.org/about/gettingstarted/) page.

This post does not explain details about installing software on different types of opperating systems.

## Install PyCharm

1. Head over to the [PyCharm page](https://www.jetbrains.com/pycharm) and click download.
2. Select the operating system you'd like to install PyCharm on.
3. Two editions are available for download.
    - Professional which is commercial
    - Community which is free and open source.
4. Download and install the **Community** edition on your computer.

## Basic usage

Once you launch the IDE, accept any default configurations. You should be presented with an option to create or open a project.

Choose **New Project**  
Specify a output path and project name. e.g. `C:\Hello-World` and create.  

You will see some basic files and folders created automatically. Below your `Hello-World` folder add a new Python file. e.g. `app.py`

Now add some sample code to `app.py`:
```python
print("Hello World")
```

In PyCharm you will see a green play button. This is the **Run** button and it allows us to execute our Python code.
After you click this we should see the `Hello World` message being output in the window (*Terminal Window*) below. 

## Resources

Mosh does great job at taking you through this process:  
[Python for Beginners - Learn Python in 1 Hour](https://youtu.be/kqtD5dpn9C8?t=129)