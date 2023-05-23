---
title: "Python Mastery - General: Introduction to Python IDLE"
date: 2023-05-20 20:04:54
tags:
- Python
- IDLE
- IDE
- Windows
---

## Overview

We'll explore Python IDLE, an integrated development environment (IDE) that comes bundled with Python. Python IDLE provides a convenient way to write, edit, and execute Python code.

## Prerequisite: Installing Python

To use Python IDLE on your Windows machine, you need to have Python installed. If you haven't installed Python yet you can find info on the official [Getting Started](https://www.python.org/about/gettingstarted/) page.

## Finding Python IDLE

1. Press the Windows key on your keyboard or click the Start button.
2. Type "IDLE" in the search bar.
3. Select "IDLE (Python X.Y)" from the search results, where "X.Y" represents the version number of Python installed on your machine.

## Creating and Running the Code Snippet

1. Open a new file in Python IDLE by selecting "File" -> "New File" from the menu or pressing Ctrl+N.
2. Copy and paste the following code snippet into the new file:
```python
import random

# Generate a random number between 1 and 20
secret_number = random.randint(1, 20)

# Initialize the number of attempts
attempts = 0

print("Welcome to Guess the Number!")

while True:
    # Prompt the user to guess the number
    guess = int(input("Guess a number between 1 and 20: "))
    
    # Increment the number of attempts
    attempts += 1
    
    # Compare the guess with the secret number
    if guess < secret_number:
        print("Too low!")
    elif guess > secret_number:
        print("Too high!")
    else:
        print(f"Congratulations! You guessed the number in {attempts} attempts.")
        break

```
3. Save the file with a .py extension (e.g., guess_the_number.py) by selecting "File" -> "Save" from the menu or pressing Ctrl+S.
4. Run the code by selecting "Run" -> "Run Module" from the menu or pressing F5.

The Python shell in IDLE will then display the output of the program and prompt you for input as necessary.