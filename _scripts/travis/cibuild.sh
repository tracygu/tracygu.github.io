#!/bin/bash
# The Travis CI build work flow.
# © 2018-2019 Cotes Chung
# MIT License

USERNAME=cotes2020
PROJECT=chirpy

POSTS_REPO=https://${GH_TOKEN}@github.com/${USERNAME}/blog-posts.git
META_REPO=https://${GH_TOKEN}@github.com/${USERNAME}/blog-meta.git

BLOG_REPO=https://${GH_TOKEN}@github.com/${USERNAME}/$USERNAME.github.io.git
DEMO_REPO=https://${GH_TOKEN}@github.com/${USERNAME}/$PROJECT-demo.git

PROJ_LOCAL=$(pwd)   # equls to $TRAVIS_BUILD_DIR/$USERNAME/$PROJECT
POSTS_LOCAL=../blog-posts
META_LOCAL=../blog-meta
DEPLOY_CACHE=../deploy


clear() {
  if [[ -d $1 ]]; then
    rm -rf $1
  fi
}


init() {
  # skip if build is triggered by pull request
  if [[ $TRAVIS_PULL_REQUEST == "true" ]]; then
    echo "this is PR, exiting"
    exit 0
  fi

  # enable error reporting to the console
  set -e

  clear "_site"

  rm -f ./README.md   # $PROJ_LOCAL/README.md

  # Git settings
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis-CI"

  git clone ${POSTS_REPO} ${POSTS_LOCAL}
  git clone ${META_REPO} ${META_LOCAL} --depth=1
}


combine() {
  cd $PROJ_LOCAL

  TEMPLATE=(
    "tabs/about.md"
    "LICENSE"
    "_posts"
    "categories"
    "tags"
    "assets/data"
    "assets/img")

  for i in "${!TEMPLATE[@]}"
  do
    rm -rf ${TEMPLATE[${i}]}
  done

  cp -a ./* ${POSTS_LOCAL}
  echo "[INFO] $(date) - Combined posts."

  cp -a ${META_LOCAL}/* ${POSTS_LOCAL}
  echo "[INFO] $(date) - Combined meta-data."
}


build() {

  build_cmd="bundle exec jekyll build"

  if [[ $1 == $POSTS_LOCAL ]]; then
    combine
    build_cmd="JEKYLL_ENV=production $build_cmd"
  fi

  cd $1
  echo "\$ cd $(pwd)"

  python _scripts/tools/init_all.py

  echo "\$ $build_cmd"
  eval $build_cmd

  echo "[INFO] $(date) - Build a site in $(pwd)"
}


deploy() {
  # $1=build_proj, $2=deploy_repo

  build $1

  clear $DEPLOY_CACHE

  msg="Travis-CI automated deployment #${TRAVIS_BUILD_NUMBER}"

  git clone $2 $DEPLOY_CACHE --depth=1

  if [[ $2 == $DEMO_REPO ]]; then
    cp $DEPLOY_CACHE/CNAME _site
    msg+="."
  else # deploy the Blog
    msg+=" from the Framework."
  fi

  rm -rf $DEPLOY_CACHE/*
  cp -r _site/* $DEPLOY_CACHE

  cd $DEPLOY_CACHE

  opt=""
  count=`git log --pretty=oneline |wc -l`

  if [[ $count > 0 ]]; then
    git update-ref -d HEAD # Overried the last commit message.
    opt="-f"
  fi

  git add -A
  git commit -m "$msg" -q
  git push $2 master:master $opt
}


main() {
  init
  deploy $PROJ_LOCAL $DEMO_REPO
  deploy $POSTS_LOCAL $BLOG_REPO
}


main
