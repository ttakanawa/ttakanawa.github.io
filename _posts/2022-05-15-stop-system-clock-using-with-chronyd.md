---
layout: post
title: "Stop system clock using with chronyd"
categories: blog
tags:
---

Firstly, check the status if the chronyd is started.

*Note: depending on the environment, you can use "service" instead of "systemctl"*

```
systemctl chronyd status
```

Stop the chronyd that is the daemon to sync the system clock.
```
systemctl chronyd stop
```

Set the time on the system clock to specified time.
```
date -s "04/26 16:24 2022"
date --set="04/26 16:24 2022"  # same with above
```

When you want to sync the system clock, run the command below.
```
systemctl chronyd start
```

And check the status just in case.
```
systemctl chronyd status
```
