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

### Option 1: Build locally (Recommend)

For security reasons, GitHub Pages runs on `safe` mode, which means the third-party Jekyll plugins or custom scripts will not work, thus **we have to build locally rather than on GitHub Pages**.

**1**. On GitHub website, create a new blank repository named `<username>.github.io`.

**2**. Build your site by:

```console
$ bash build.sh -d /path/to/<username>.github.io/
```

The build results will be stored in the root directory of `<username>.github.io` and don't forget to push the changes of `<username>.github.io` to branch `master` on GitHub.

**3**. Go to GitHub website and enable GitHub Pages service for the new repository `<username>.github.io`.

**4**. Visit `https://<username>.github.io` and enjoy.


### Option 2: Build by GitHub Pages

**Warning**: By deploying your site in this way, you will lose feature `Last Modifed Date`, which means the posts' latest modified date and the **Recent Update** list in the right pannel will never display.

**1**. Rename your repository as `<username>.github.io`.

**2**. Commit the changes of your repository before running the initialization script:

```console
$ bash init.sh
```

It will make an automatic initialization for the *Categories*/*Tags* pages for posts.

**3**. Push the changes to `origin/master` then go to GitHub website and enable GitHub Pages service for the repository `<username>.github.io`.

**4**. Visit `https://<username>.github.io` and enjoy.

## See Also

* [Write a new post]({{ site.baseurl }}/posts/write-a-new-post/)
* [Text and Typography]({{ site.baseurl }}/posts/text-and-typography/)
* [Customize the Favicon]({{ site.baseurl }}/posts/customize-the-favicon/)
