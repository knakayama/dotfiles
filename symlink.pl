#!/usr/bin/env perl

=head1 NAME

symlink.pl

=head1 SYNOPSIS

Usage:
    % symlink.pl [-c|--create] [-r|--remove] [-f|--force] [-h|--help]

Options:
    -c|--create
        create symlinks

    -r|--remove
        remove symlinks

    -f|--force
        no backup

    -h|--help
        print this message

=head1 DESCRIPTION

create/remove symbolic links

=cut

use strict;
use warnings;

use FindBin;
use File::Basename 'basename';
use File::Copy 'move';
use File::Spec 'catfile';
use Time::Piece 'localtime';
use Getopt::Long qw/:config no_ignore_case gnu_compat/;
use Pod::Usage 'pod2usage';

GetOptions(
    \my %opts, qw/
    create
    remove
    force
    help
    /) or pod2usage(1);


my @EXCLUDES = qw/.git .gitignore .gitmodules README.rst tmux_scripts symlink.pl/;
my $SRC_BASE_PATH = $FindBin::Bin;
#my $DEST_BASE_PATH = $ENV{HOME};
my $DEST_BASE_PATH = "$ENV{HOME}/test";

sub is_exclude {
    my $file_or_dir = shift;

    foreach my $exclude (@EXCLUDES) {
        return 1 if $file_or_dir =~ /$exclude/;
    }

    return 0;
}

sub create_targets {
    my @targets = ();

    opendir my $dh, $SRC_BASE_PATH
            or die "Can't open $SRC_BASE_PATH: $!";

    while (my $file_or_dir = readdir $dh) {
        next if $file_or_dir eq '.' || $file_or_dir eq '..';
        push @targets, $file_or_dir unless is_exclude $file_or_dir;
    }
    closedir $dh;

    return @targets;
}

sub create_symlinks {
    my @targets = create_targets();
    my $time = localtime->new->strftime('%Y%m%d%H%M%S');

    foreach my $target (@targets) {
        my $src = File::Spec->catfile($SRC_BASE_PATH, $target);
        my $dest = File::Spec->catfile($DEST_BASE_PATH, $target);
        my $dest_backup = '';
        if (-e $dest) {
            if (defined $opts{force}) {
                printf "%s: %s\n", 'remove', $dest;
                unlink($dest) or die "Can't remove $dest; $!";
            }
            else {
                $dest_backup = $dest . '_' . $time;
                printf "%s: %s -> %s\n", 'move', $dest, $dest_backup;
                move($dest, $dest_backup) or die "Can't backup $dest: $!";
            }
        }
        printf "%s: %s -> %s\n", 'symlink', $src, $dest;
        symlink($src, $dest) or die "Can't create symlink: $!";
    }
}

sub remove_symlinks {
    my @targets = create_targets();
    my $time = localtime->new->strftime('%Y%m%d%H%M%S');

    foreach my $target (@targets) {
        my $dest = File::Spec->catfile($DEST_BASE_PATH, $target);
        my $dest_backup = '';
        if (-e $dest) {
            if (defined $opts{force}) {
                printf "%s: %s\n", 'remove', $dest;
                unlink($dest) or die "Can't remove $dest; $!";
            }
            else {
                $dest_backup = $dest . '_' . $time;
                printf "%s: %s -> %s\n", 'move', $dest, $dest_backup;
                move($dest, $dest_backup) or die "Can't backup $dest: $!";
            }
        }
    }
}

if ($opts{create}) {
    create_symlinks();
}
elsif ($opts{remove}) {
    remove_symlinks();
}
elsif ($opts{help}) {
    pod2usage(0);
}

