#!/bin/bash
#
# Run jekyll site at http://127.0.0.1:4000
# © 2019 Cotes Chung
# Published under MIT License


set -eu

if [[ -d ../.chirpy-cache ]]; then
   rm -rf ../.chirpy-cache
fi

mkdir ../.chirpy-cache
cp -r * ../.chirpy-cache
cp -r .git  ../.chirpy-cache

if [[ -d .container ]]; then
   rm -rf .container
fi

mv ../.chirpy-cache .container
cd .container

python _scripts/tools/init_all.py

trap cleanup INT

function cleanup() {
   cd ../
   rm -rf .container
}

bundle exec jekyll s
