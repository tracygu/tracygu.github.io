---
title: Getting Started
date: 2019-08-09 20:55:00 +0800
categories: [Blogging, Tutorial]
tags: [usage]
---


## Basic Environment

First of all, follow the [Jekyll Docs](https://jekyllrb.com/docs/installation/)  to complete the basic environment (Ruby, RubyGem, Bundler and Jekyll)  installation.

In addition, the [python](https://www.python.org/downloads/) and [ruamel.yaml](https://pypi.org/project/ruamel.yaml/) are also required.

## Configuration

Customize the variables in file `_config.yml` as needed.

## Atom Feed

The Atom feed url of your site will be:

```
<site_url>/feed.xml
```

The `site_url` was defined by variabel **url** in `_config.yml`.

## Install Jekyll Plugins

In the root direcoty of the project, run the following command:

```terminal
$ bundle install
```

`bundle` will install all dependent Jekyll Plugins declared in `Gemfile` that stored in the root automatically.

##  Run Locally

You may want to preview the site before publishing. Run the script in the root directory:

```terminal
$ bash run.sh
```

>**Note**: Because the *Recent Update* required the latest git-log date of posts, make sure the changes of `_posts` have been committed before running this command. 

Open the brower and visit [http://127.0.0.1:4000](http://127.0.0.1:4000) 

##  Deploying to GitHub Pages

For security reasons, GitHub Pages runs on `safe` mode, which means the third-party Jekyll plugins or custom scripts will not work, thus **we have to build locally rather than on GitHub Pages**.

There are two basic types of GitHub Pages sites, therefore you can choose one of them to finish the publishing.

###  User and Organization Pages sites

1) On GitHub website, create a new blank repository named `<username>.github.io`.

2) Build your site by:

```console
$ cd /path/to/jekyll-theme-chirpy/
$ bash build.sh -d /path/to/<username>.github.io/
```

The build results will be stored in the root directory of `<username>.github.io`. Do forget to push the changes of `<username>.github.io` to GitHub.

3) Go to GitHub website and enable GitHub Pages service for the new repository `<username>.github.io`.

4) Visit `https://<username>.github.io` and enjoy.


###  Project Pages sites

1) Suppose you create a new repository `myblog` (Do not name it `<username>.github.io`). Build the site with base url `/myblog`:

```console
$ cd /path/to/jekyll-theme-chirpy/
$ bash build.sh -d /path/to/myblog/ -b /myblog
```

> **Tips**: Setting the variable `baseurl` in `_config.yml` can revoke the parameter option `-b /myblog` above.

2) Push site files in repository `myblog` by Git to the remote `master` branch.

3) Go to GitHub website and enable GitHub Pages servies for repository `myblog`.

4) Now your site is published at `https://<username>.github.io/myblog/`


## See Also

* [Write a new post]({{ site.baseurl }}/posts/write-a-new-post/)
* [Text and Typography]({{ site.baseurl }}/posts/text-and-typography/)
* [Customize the Favicon]({{ site.baseurl }}/posts/customize-the-favicon/)
