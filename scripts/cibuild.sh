#!/bin/bash

POST_REPOS=https://${GITHUB_TOKEN}@github.com/cotes2020/blog-posts.git
META_REPOS=https://${GITHUB_TOKEN}@github.com/cotes2020/blog-meta.git

GITHUB_DEPOLY=https://${GITHUB_TOKEN}@github.com/cotes2020/cotes2020.github.io.git
CODING_DEPOLY=https://cotes:${CODING_TOKEN}@git.dev.tencent.com/cotes/cotes.coding.me.git


init() {
  # skip if build is triggered by pull request
  if [ $TRAVIS_PULL_REQUEST == "true" ]; then
    echo "this is PR, exiting"
    exit 0
  fi

  # enable error reporting to the console
  set -e

  if [ -d "_site" ]; then
    rm -rf _site
  fi
}

combine() {
  # Combine repositories
  git clone --depth=1 ${POST_REPOS} ./blog-posts
  cp -r ./blog-posts/* ./
  rm -rf ./blog-posts
  echo "[INFO] Combined posts."

  git clone --depth=1 ${META_REPOS} ./blog-meta
  cp -r ./blog-meta/* ./
  rm -rf ./blog-meta
  echo "[INFO] Combined meta-data."
}


build() {
  ## Check lasmod of posts and the Category, Tag pages.
  export TZ='Asia/Shanghai' # the lastmod detection needs this
  echo "date: $(date)"
  python ./scripts/pages_generator.py

  # build Jekyll ouput to directory ./_site
  JEKYLL_ENV=production bundle exec jekyll build
}


deploy() {
  ## Git settings
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis-CI"

  DEPOLYS=(${GITHUB_DEPOLY} ${CODING_DEPOLY})

  for i in "${!DEPOLYS[@]}"
  do
    echo "TRAVIS_BUILD_DIR=${TRAVIS_BUILD_DIR}"
    cd ${TRAVIS_BUILD_DIR}

    if [ -d "../repos_${i}" ]; then
      rm -rf ../repos_${i}
    fi

    git clone --depth=1 ${DEPOLYS[${i}]} ../repos_${i}

    rm -rf ../repos_${i}/* && cp -a _site/* ../repos_${i}/
    cd ../repos_${i}/

    git add -A
    git commit -m "Travis-CI automated deployment #${TRAVIS_BUILD_NUMBER}."
    git push ${DEPOLYS[${i}]} master:master

    echo "Push to ${DEPOLYS[${i}]}"
  done
}

main() {
  init
  combine
  build
  deploy
}

main
