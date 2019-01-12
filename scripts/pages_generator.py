#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Author: Cotes Chung
Date: 23 Feb 2018

Generates html page for every single category and tag of posts.

This script MUST BE run before deployment locally or on remote.

'''

import os
import glob
import shutil
import sys

from ruamel.yaml import YAML
from utils.frontmatter_getter import get_yaml


DRAFTS_PATH = '_drafts'
POSTS_PATHS = ['_posts']

CATEGORIES_PATH = 'categories'
CATEGORY_LAYOUT = 'category'

TAG_PATH = 'tags'
TAG_LAYOUT = 'tag'

OPTS = ['--draft']


def get_categories():
    all_categories = []
    yaml = YAML()

    for path in POSTS_PATHS:
        for file in glob.glob(os.path.join(path, '*.md')):
            meta = yaml.load(get_yaml(file)[0])

            if 'category' in meta:
                if type(meta['category']) == list:
                    err_msg = (
                        "[Error] File {} 'category' type"
                        " can not be LIST!").format(file)
                    raise Exception(err_msg)
                else:
                    if meta['category'] not in all_categories:
                        all_categories.append(meta['category'])

            else:
                if 'categories' in meta:
                    if type(meta['categories']) == str:
                        error_msg = (
                            "[Error] File {} 'categories' type"
                            " can not be STR!").format(file)
                        raise Exception(error_msg)

                    for ctg in meta['categories']:
                        if ctg not in all_categories:
                            all_categories.append(ctg)

                else:
                    err_msg = (
                        "[Error] File:{} at least "
                        "have one category.").format(file)
                    print(err_msg)

    return all_categories


def generate_category_pages():
    categories = get_categories()
    if os.path.exists(CATEGORIES_PATH):
        shutil.rmtree(CATEGORIES_PATH)

    os.makedirs(CATEGORIES_PATH)

    for category in categories:
        new_page = CATEGORIES_PATH + '/' + category.lower() + '.html'
        with open(new_page, 'w+') as html:
            html.write("---\n")
            html.write("layout: {}\n".format(CATEGORY_LAYOUT))
            html.write("title: {}\n".format(category.encode('utf-8')))
            html.write("category: {}\n".format(category.encode('utf-8')))
            html.write("---")
            print("[INFO] Created page: " + new_page.lower())
    print("[NOTICE] Succeed! {} category-pages created.\n"
          .format(len(categories)))

    # subprocess.call(["git", "add", CATEGORIES_PATH])
    # subprocess.call(["git", "commit", "-m",
    #                 "[Automation] Update page to Categories."])


def get_all_tags():
    all_tags = []
    yaml = YAML()

    for path in POSTS_PATHS:
        for file in glob.glob(os.path.join(path, '*.md')):
            meta = yaml.load(get_yaml(file)[0])

            if 'tags' in meta:
                for tag in meta['tags']:
                    if tag not in all_tags:
                        all_tags.append(tag)
            else:
                raise Exception("Cannot found 'tags' in \
                  post '{}' !".format(file))

    return all_tags


def generate_tag_pages():
    all_tags = get_all_tags()
    if os.path.exists(TAG_PATH):
        shutil.rmtree(TAG_PATH)

    os.makedirs(TAG_PATH)

    for tag in all_tags:
        tag_page = TAG_PATH + '/' + tag.lower() + '.html'
        with open(tag_page, 'w+') as html:
            html.write("---\n")
            html.write("layout: {}\n".format(TAG_LAYOUT))
            html.write("title: {}\n".format(tag.encode('utf-8')))
            html.write("tag: {}\n".format(tag.encode('utf-8')))
            html.write("---")
            print("[INFO] Created page: " + tag_page.lower())
    print("[NOTICE] Succeed! {} tag-pages created.\n".format(len(all_tags)))


def main():
    if len(sys.argv) > 1:
        if sys.argv[1] == '--drafts':
            POSTS_PATHS.insert(0, DRAFTS_PATH)
        else:
            print "Oops! Unknown argument: "
            for err_argv in sys.argv[1:]:
                print "\'err_argv\'"

            print "Do you mean: --drafts ?"
            return

    generate_category_pages()
    generate_tag_pages()


main()
