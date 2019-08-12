#!/bin/bash
#
# Build jekyll site and store site files in ./_site
# © 2019 Cotes Chung
# Published under MIT License

BASEURL=""
BUILD_DIR=`pwd`

help() {
   echo "Usage: bash ./build.sh [--option <value>]"
   echo "Options:"
   echo "   --baseurl <url>    The site relative url that start with slash, e.g. '/project'"
}

set -eu

if [[ -d ../.chirpy-cache ]]; then
   rm -rf ../.chirpy-cache
fi

mkdir ../.chirpy-cache
cp -r *   ../.chirpy-cache
cp -r .git ../.chirpy-cache

if [[ -d .container ]]; then
   rm -rf .container
fi

mv ../.chirpy-cache .container
cd .container

echo "$ cd $(pwd)"
python _scripts/tools/init_all.py

while [[ $# -gt 0 ]]
do
  opt="$1"
  case $opt in
    --baseurl)
    BASEURL="$2"
    shift # past argument
    shift # past value
    ;;
    *)
    # unknown option
    help
    exit 1
    ;;
  esac
done

CMD="JEKYLL_ENV=production bundle exec jekyll b -d $BUILD_DIR/_site"

if [[ -n $BASEURL ]]; then
  CMD+=" --baseurl $BASEURL"
fi

echo "\$ $CMD"
eval $CMD

echo "$(date) - Build success, the Site files placed in _site."

cd ..
rm -rf .container
