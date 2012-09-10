#!/usr/bin/env python

import argparse
import os

from fabric.api import local, lcd


def git_diff(targets):
    local("git diff {}".format(targets))


def git_status():
    local("git status")


def git_add(targets):
    local("git add {}".format(targets))


def git_commit(targets, message=None):
    if message:
        local("git commit {0} -m {1}".format(targets, message))
    else:
        local("git commit {}".format(targets))


def git_push():
    local("git push git@github.com:knakayama/dotfiles.git")


def deploy(targets, message=None):
    git_add(targets)
    git_commit(targets, message)
    git_push()
