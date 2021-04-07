---
layout: post
title: "How to build old PHP"
categories: blog
tags: [php,linux,ubuntu,wsl]
image: /assets/img/elephant_2.jpg
cc: {url: 'https://flic.kr/p/bbfBZH', author: Laura Kay}
---

**TL;DR** You can install and configure the PHP which is old, outdated, unsupported and archived on your linux

This post is the steps I've taken in my previous [I built PHP](/i-built-php.html) post.

## My environment

- OS: Ubuntu 20.04.1 LTS (WSL2)
- Japan

OK, let's get started it.

First, Install C compiler and Make beforehand.

```bash
sudo apt install -y gcc make
```

Download your target version from [Unsupported Historical Releases](https://www.php.net/releases/).

I will use PHP 7.2.32 (tar.gz) as an example.

```bash
curl -Lso php-7.2.32.tar.gz https://www.php.net/distributions/php-7.2.32.tar.gz
```

Unzip the source code to `/usr/local/src`.

```bash
tar xfz php-7.2.32.tar.gz -C /usr/local/src/
```

Go to the unzipped directory.

```bash
cd /usr/local/src/php-7.2.32
```

Generate Makefile.
PHP has so many options, so you should look up and optimize your settings, but you could try this options at first.
Don’t worry. the options you used will be recorded on the Makefile, so you can check them later. That's very useful, isn't it?

```bash
sudo ./configure \
    --prefix=/usr/local/php-7.2.32 \
    --with-apxs2=/usr/bin/apxs \
    --with-mysql=mysqlnd \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --enable-mbstring \
    --with-openssl
```

I think you would encounter some errors, but you could manage those.

I will describe the errors I faced and the steps I took to resolve them.

> the errors
> ```
> 1. Perl is not installed
> 2. apxs was not found. Try to pass the path using --with-apxs2=/path/to/apxs
> 3. Apache was not built using --enable-so (the apxs usage page is displayed)
> ```
> fixed them
> ```bash
> sudo apt install -y perl
> ```
> ```bash
> which apxs
> => Replace --with-apxs2 option to the output. (/usr/bin/apxs)
> ```
> ```bash
> sudo apt install -y apache2-dev
> ```

> the error
> ```
> configure: error: libxml2 not found. Please check your libxml2 installation.
> ```
> fixed it
> ```bash
> sudo apt install -y libxml2-dev
> ```

> the error
> ```
> configure: error: Cannot find OpenSSL's <evp.h>
> ```
> fixed it
> ```bash
> sudo apt install -y libssl-dev
> ```

> the error
> ```
> configure: error: Cannot find OpenSSL's libraries
> ```
> fixed it
> ```bash
> sudo apt install -y pkg-config
> ```

Build PHP using the Makefile you generated above.

```bash
make
```

Test the PHP just in case.

```bash
make test
```

Install PHP.

```bash
make install
```

> If you encounter an error when you install PHP according to the above, install apache and install PHP again. 
> ```
> apxs:Error: Config file /etc/apache2/mods-available not found.
> make: *** [Makefile:153: install-sapi] Error 1
> ```
> ```bash
> sudo apt upgrade -y apache2
> ```

I want to use several versions of PHP depending on the situation, so set up the symbolic link.

First, check where the PHP. It is in the location you specified when you ran the configure script.
The following is `/usr/local/php-7.2.32`.

```
sudo ./configure --prefix=/usr/local/php-7.2.32
```

And check the PHP version just in case.

```bash
/usr/local/php-7.2.32/bin/php -v
```

Generate the symbolic link.

```bash
sudo update-alternatives --install /usr/bin/php php /usr/local/php-7.2.32/bin/php 72
```

Switch your PHP

```bash
update-alternatives --config php
```

That's all. From now on, you can install another version following the above instructions.

If you have found some mistakes and unknown points, I'd be happy to me know [tweeting at me](https://twitter.com/intent/tweet?text=%40_takanawa_).