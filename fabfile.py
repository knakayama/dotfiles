#!/usr/bin/env python

from fabric.api import local, cd


def git_diff(targets):
    local("git diff {}".format(targets))


def git_status():
    local("git status")


def git_add(targets):
    local("git add {}".format(targets))


def git_commit(targets):
    local("git commit {}".format(targets))


def git_push():
    local("git push git@github.com:knakayama/dotfiles.git")


def deploy(targets):
    git_add(targets)
    git_commit(targets)
    git_push()

