---
layout: post
title: "Do not use double quotations on your PROMPT"
tags: [zsh,bash, shell scripting language, git]
image: /assets/img/terminal_zsh.jpg
cc: {url: 'https://flic.kr/p/gy8nEU', author: gamebouille}
---

tldr is this tweet below.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">like this. <a href="https://t.co/PAnzshoafV">https://t.co/PAnzshoafV</a> <a href="https://t.co/hnxcHDAAIP">pic.twitter.com/hnxcHDAAIP</a></p>&mdash; Tomonori Takanawa (@_takanawa_) <a href="https://twitter.com/_takanawa_/status/1359924142439452674?ref_src=twsrc%5Etfw">February 11, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>  

First of all, I knew the difference of single quotations and double quotations on shell scripting language (especially bash and zsh), the former wouldn't expand the variables yet the latter would, but I'm not sure function with them work on PROMPT.
So I will write the point what happen when you use double quotes on you PROMPT just in case such as the tweet would be deleted.
2021-02-12-do-not-use-double-quotations-on-your-prompt
First, I encountered the bug which the zsh prompt won't display the git status correctly, for example, the case I'm not on git project when zsh launched is zsh don't display git status (branch name and so on) whether I `cd to-git-project-directory`, but other case which I'm on git project when zsh launched, it goes on displaying the branch name even if `cd other-directory-not-git-project`.

This bug cause is double quotations I put them on my zsh PROMPT. When you use double quotations on zsh PROMPT, zsh expand its content only at zsh launched, so this will lead to a bug relevant displaying git status.

So you should use single quotes on PROMPT. Sadly I struggled this problem for a few hours. Thank you. 

![The diff of the commit which single quotes and double quotes](assets/img/2021-02-12-do-not-use-double-quotations-on-your-prompt/screen_shot_1.png)
The diff commit is [c9499d09](https://github.com/ttakanawa/dotfiles/commit/c9499d0935b0ba7edf4a5c02f3ef54b037d69c7c?branch=c9499d0935b0ba7edf4a5c02f3ef54b037d69c7c&diff=unified) which is my github repository I store my dotfiles.
