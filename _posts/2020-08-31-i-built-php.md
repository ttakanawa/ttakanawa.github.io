---
layout: post
title: "I built PHP"
categories: blog
tags: [php]
image: /assets/img/elephant.jpg
cc: {url: 'https://flic.kr/p/7UKXRd', author: JamesRoseUK}
---

## TL;DR

- This is my first time to build programming language in spite of web/software engineer.
- There are some reasons which I built PHP, but most important reason for me is that I thought the professional may use proper tools including programming language.
- I learned about what installation in computers is through building PHP. (a bit)
- I realized to appreciate the package managers such as homebrew , apt and so on.

## Why I built PHP

I'm a web engineer but had not built any programming language source code, so I thought this time to build PHP would be valuable experience. That is the reason for my building PHP.
But maybe you should install from some repositories like ppa for not waster your time lol.

I built it on Ubuntu 20.04.1 LTS of WSL2 (Windows Subsystem for Linux), and the reason is that I was to build a development environment on WSL this time for trial since the surrounding engineers have starting to switch their development terminals from Mac to Windows. 
In addition, PHP 7.0 package had been removed from (because the version is outdated), so I built PHP to deal with these unexpected cases.

Here is [supported php versions](https://www.php.net/supported-versions.php).

## OK, so why don't you use apt-get instead apt

Yes, that's definitely correct, but I don’t understand the difference apt and apt-get and have seen someone says apt-get is deprecated from some ubunutu version.
And because this blog post's theme is the building PHP I had wanted to do ever, there is no reason why I install using apt-get.😗

## There are repositories like PPA that have more reliable PHP than your own builds, are there? 

PPA is stands for Personal Package Archive.

Yes, there are, but I think the engineer who use that you don't know who and how build are not professional in a sense.
Because extremely, why do you think it PHP? It might be something different from php. Might be python.
In this case, You should finally be able to recognize it as PHP by checking the source code for the matter.

Although the reality is that PHP installed from the repository is more reliable than the one you built yourself.🥺
(but be aware that sometimes the PHP installed from someone's repository do not support multibyte, it is a very important problem cuz I am japanese)

But for now, because this blog post's theme is the building PHP I had wanted to do ever, there is no reason why I install from PPA.

## Thoughts on building PHP

It's good experience, I can now say "Yeah, I have built programming languages such as PHP.", and think I can build other programming languages.

I also got a better understanding of what "installation" means on a computer.
I used to install an app via GUI without thinking about it, but if you know what the installing is and how it is installed, you will be able to cope with the trouble.

And I realized the package managers such as homebrew, apt and so on are so useful. For example, homebrew optimized the packages(formulas) by enabling some modules. 
That configuration is useful for many users including multibyte users, and most users can use installed PHP without thinking about it.
PHP has so many configure options, and it is difficult to judge what is proper for your environment, so the like homebrew is a very useful tool. 

## Future Goals

I would like to study computer science and others every day and increase the things I can do.
I'll be a little more specific and describe what I want to do in the future.

- To set up the secure infrastructure and to operate a website.
- To make compiler.
- To make programming language.
- To make OS.
- To get vision correction surgery like ICL.
- To live in a great house.
