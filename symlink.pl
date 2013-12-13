#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use File::Basename;

my @EXCLUDES = qw/.git .gitignore .gitmodules README.rst tmux_scripts symlink.pl/;
my $BASE_PATH = "$FindBin::Bin";

sub usage {
    print << "EOT"

Usage:
$0 [-c|--create] [-r|--remove] [-f|--force] [-h|--help]

Options:
-c|--create create symlinks
-r|--remove remove symlinks
-f|--force  no backup
-h|--help   print this message

EOT
}

sub create_symlink {
    foreach my $target (glob("./*")) {
        print "target: $target\n";
    }
}

sub remove_symlink {
}

create_symlink

