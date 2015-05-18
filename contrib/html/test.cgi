#!/usr/bin/perl
# test.cgi by Bill Weinman [http://bw.org/]
# Copyright 1995-2008 The BearHeart Group, LLC
# Free Software: Use and distribution under the same terms as perl.

use strict;
use warnings;
use CGI;

print foreach (
    "Content-Type: text/plain\n\n",
    "BW Test version 5.0\n",
    "Copyright 1995-2008 The BearHeart Group, LLC\n\n",
    "Versions:\n=================\n",
    "perl: $]\n",
    "CGI: $CGI::VERSION\n"
);

my $q = CGI::Vars();
print "\nCGI Values:\n=================\n";
foreach my $k ( sort keys %$q ) {
    print "$k [$q->{$k}]\n";
}

print "\nEnvironment Variables:\n=================\n";
foreach my $k ( sort keys %ENV ) {
    print "$k [$ENV{$k}]\n";
}
