#!/usr/bin/env python

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


def create_symlinks():
    with lcd(os.path.expanduser("~/dotfiles")):
        exclude_files = [".gitmodules", ".gitignore", "README.rst"]
        for f_name in os.listdir(os.getcwd()):
            if f_name not in exclude_files:
                os.symlink(os.path.abspath(f_name),
                        os.path.join(os.path.expanduser("~"), f_name))


def create_symlink():
    pass


def delete_symlinks():
    pass


def delete_symlink():
    pass
