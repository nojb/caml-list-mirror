#!/usr/bin/perl -w
# Copyright (C) 2016-2018 all contributors <meta@public-inbox.org>
# License: AGPL-3.0+ <https://www.gnu.org/licenses/agpl-3.0.txt>

use strict;
use warnings;
use Email::MIME;
$Email::MIME::ContentType::STRICT_PARAMS = 0; # user input is imperfect
use PublicInbox::Git;
use PublicInbox::Import;
use File::Basename;

my $usage = "usage: $0\n";
#chomp(my $git_dir = `git rev-parse --git-dir`);
my $git_dir = 'caml-list.git';
my $git = PublicInbox::Git->new($git_dir);
#my $dir = shift or die $usage;
my $name = 'caml-list';
my $email = 'caml-list@inria.fr';
my $caml_list_archive = 'caml-list-archive';
my $msg = '';

binmode STDIN;

sub import_file {
    my ($im, $file) = @_;
    my $base = basename($file);
    print "$base\n";
    my $contents = `cat $file`;
    $msg = Email::MIME->new($contents);
    $im->add($msg) or print " (duplicate)\n";
}

sub import_dir {
    my ($dir) = @_;
    my $im = PublicInbox::Import->new($git, $name, $email);
    print "$dir\n";
    my @files = glob("$dir/*");
    @files = sort { basename($a) <=> basename($b) } @files;
    foreach my $file (@files) {
        import_file($im, $file);
    };
    print "\n";
    $im->done if $im;
}

foreach my $dir1 ( glob("$caml_list_archive/caml-list_*-*") ) {
    import_dir($dir1)
}
