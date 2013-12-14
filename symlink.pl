#!/usr/bin/env perl
use strict;
use warnings;

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

package File::SymLink;
use FindBin;
use File::Basename 'basename';
use File::Copy 'move';
use File::Spec 'catfile';
use Time::Piece 'localtime';

sub new {
    my $class = shift;
    my $self = {
        excludes => [qw/.git .gitignore .gitmodules README.rst tmux_scripts symlink.pl/],
        src_base_path => $FindBin::Bin,
        #dst_base_path => $ENV{HOME}
        dst_base_path => "$ENV{HOME}/test"
    };

    bless $self, $class;
}

sub is_exclude {
    my ($self, $file_or_dir) = @_;

    foreach my $exclude (@{$self->{excludes}}) {
        return 1 if $file_or_dir =~ /$exclude/;
    }

    return 0;
}

sub create_targets {
    my $self = shift;
    my @targets = ();

    opendir my $dh, $self->{src_base_path}
            or die "Can't open $self->{src_base_path}: $!";

    while (my $file_or_dir = readdir $dh) {
        next if $file_or_dir eq '.' || $file_or_dir eq '..';
        push @targets, $file_or_dir unless $self->is_exclude($file_or_dir);
    }
    closedir $dh;

    return @targets;
}

sub create_symlinks {
    my $self = shift;
    my $force = shift || '';
    my @targets = $self->create_targets();
    my $time = localtime->new->strftime('%Y%m%d%H%M%S');

    foreach my $target (@targets) {
        my $src = File::Spec->catfile($self->{src_base_path}, $target);
        my $dst = File::Spec->catfile($self->{dst_base_path}, $target);
        my $dst_backup = '';
        if (-e $dst) {
            if ($force) {
                printf "%s: %s\n", 'remove', $dst;
                unlink($dst) or die "Can't remove $dst; $!";
            }
            else {
                $dst_backup = $dst . '_' . $time;
                printf "%s: %s -> %s\n", 'move', $dst, $dst_backup;
                move($dst, $dst_backup) or die "Can't backup $dst: $!";
            }
        }
        printf "%s: %s -> %s\n", 'symlink', $src, $dst;
        symlink($src, $dst) or die "Can't create symlink: $!";
    }
}

sub remove_symlinks {
    my $self = shift;
    my @targets = $self->create_targets();
    my $time = localtime->new->strftime('%Y%m%d%H%M%S');

    foreach my $target (@targets) {
        my $dst = File::Spec->catfile($self->{dst_base_path}, $target);
        my $dst_backup = '';
        if (-e $dst) {
            printf "%s: %s\n", 'remove', $dst;
            unlink($dst) or die "Can't remove $dst; $!";
        }
    }
}

package main;
use Getopt::Long qw/:config no_ignore_case gnu_compat/;
use Pod::Usage 'pod2usage';

main();exit;

sub main {
    my $force = '';
    my $opt_parser = Getopt::Long::Parser->new(
        config => [qw/posix_default no_ignore_case auto_help/]
    );
    $opt_parser->getoptions(
        'c|create' => \my $create,
        'r|remove' => \my $remove,
        'f|force'  => \$force
    ) or pod2usage(1);

    my $symlink_obj = File::SymLink->new();
    if ($create) {
        $symlink_obj->create_symlinks($force);
    }
    elsif ($remove) {
        $symlink_obj->remove_symlinks();
    }
}

