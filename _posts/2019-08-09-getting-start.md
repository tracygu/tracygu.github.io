---
title: "Getting Start"
date: 2019-08-09 20:55:00 +0800
categories: [Blogging, Tutorial]
tags: [usage]
comments: false
---

## Configuration

Go to the repository root and check the following files in `_data`:

* meta.yml
* profile.yml
* settins.yml

Change the value of fields to your own.

##  Install the Jekyll Plugins

Please execute the following command in the root of the repository.

```bash
bundle install
```

`bundle` will install all dependent Jekyll Plugins declared in `Gemfile` that stored in the root automatically.

##  Complete your site

Run the following script after the posts changes are commited:

```bash
python _scripts/tools/init_all.py
```
> **Note**: This step is required before EACH build or run of your site.

The script `init_all.py` (depends on [ruamel.yaml](https://pypi.org/project/ruamel.yaml/)) will create HTML pages for all Categories and Tags, and update the Last Modified Date of posts.



##  Run Locally

```bash
bundle exec jekyll serve
```

Open your brower and visit `http://127.0.0.1:4000`.

##  Publish to GitHub Pages

For security reasons, **GitHub Pages** runs on `safe` mode, which means the third-party Jekyll plugins (e.g. `jekyll-timeago`) doesn't work, so we have to build locally rather than on GitHub.

There are two basic types of GitHub Pages sites, so you can choose one of them.

###  User and Organization Pages sites


Step 1. Build your site:

```bash
JEKYLL_ENV=production bundle exec jekyll build
```
The build results will be stored in `_site` of your repository.

Step 2. Go to GitHub and create a new repository named `<username>.github.io`.

Step 3. Copy the build results mentioned in **Step 1** to the new repository.

Step 4. On GitHub, enable Pages service for the new repository.

Step 5. Visit `https://<username>.github.io` and enjoy.

###  Project Pages sites

If you want to put the source code and build results within one repository, the **Project Pages sites** is for you.

> **Note**: Do NOT rename your repository to `<username>.github.io` !

Step 1. Build project locally and store output to `docs` in the root of repository:

```bash
JEKYLL_ENV=production bundle exec jekyll build -d docs
```

Step 2. Git commit and push the changes of `docs` to GitHub.

Step 3. Go to GitHub and [set up with your project
](https://help.github.com/en/articles/configuring-a-publishing-source-for-github-pages#publishing-your-github-pages-site-from-a-docs-folder-on-your-master-branch).

Step 4. Now your site is published at `https://<username>.github.io/<project>/`


