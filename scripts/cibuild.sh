#!/bin/bash

POST_REPOS=https://${GITHUB_TOKEN}@github.com/cotes2020/blog-posts.git
META_REPOS=https://${GITHUB_TOKEN}@github.com/cotes2020/blog-meta.git

GITHUB_DEPOLY=https://${GITHUB_TOKEN}@github.com/cotes2020/cotes2020.github.io.git
CODING_DEPOLY=https://cotes:${CODING_TOKEN}@git.dev.tencent.com/cotes/cotes.coding.me.git

DEPOLYS=(${GITHUB_DEPOLY} ${CODING_DEPOLY})

POST_CACHE=../blog-posts
META_CACHE=../blog-meta


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

  if [ -d  ${POST_CACHE} ]; then
    rm -rf ${POST_CACHE}
  fi

  if [ -d ${META_CACHE} ]; then
    rm -rf ${META_CACHE}
  fi
}


combine() {
  TEMPLATE=(
    "tabs/about.md"
    "LICENSE"
    "README.md"
    "_posts"
    "categories"
    "tags"
    "norobots")

  for i in "${!TEMPLATE[@]}"
  do
    rm -rf ${TEMPLATE[${i}]}
  done

  git clone --depth=50 ${POST_REPOS} ${POST_CACHE}
  cp -a ./* ${POST_CACHE}
  echo "[INFO] Combined posts."

  git clone --depth=1 ${META_REPOS} ${META_CACHE}
  cp -a ${META_CACHE}/* ${POST_CACHE}
  rm -rf ${META_CACHE}
  echo "[INFO] Combined meta-data."
}


build() {
  cd ${POST_CACHE}

  export TZ='Asia/Shanghai' # the lastmod detection needs this
  echo "[INFO] Current date: $(date)"
  python ./scripts/pages_generator.py

  # build Jekyll ouput to directory ./_site
  JEKYLL_ENV=production bundle exec jekyll build
}


deploy() {
  # Git settings
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis-CI"

  for i in "${!DEPOLYS[@]}"
  do
    # echo "[INFO] TRAVIS_BUILD_DIR=${TRAVIS_BUILD_DIR}"
    echo
    echo "[INFO] \$PWD=$(pwd)"

    if [ -d "../depoly_${i}" ]; then
      rm -rf ../depoly_${i}
    fi

    git clone --depth=1 ${DEPOLYS[${i}]} ../depoly_${i}

    rm -rf ../depoly_${i}/*
    cp -r _site/* ../depoly_${i}/

    cd ../depoly_${i}/
    git add -A
    git commit -m "Travis-CI automated deployment #${TRAVIS_BUILD_NUMBER} of the framework."
    git push ${DEPOLYS[${i}]} master:master

    echo "[INFO] Push to remote: ${DEPOLYS[${i}]}"
    cd -

  done
}


main() {
  init
  combine
  build
  deploy
}


main
