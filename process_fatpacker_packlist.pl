#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use File::Spec;

my @ignored_package = qw{ 
    Canary/Stability
    Carp 
    common/sense
    Cpanel/JSON/XS 
    Cwd
    Data/Dumper 
    Encode/Locale 
    HTTP/Date 
    HTTP/Message 
    IO/Socket/SSL
    JSON/XS 
    List/Util
    Net/SSLeay
    Storable
    Types/Serialiser
    URI 
    };

my %handled_packages = map { ($_ => 1) } qw{
    HTTP/Tiny
    JSON/MaybeXS
    JSON/PP
    Memoize
    Module/CoreList
    Module/Metadata
    CPAN/DistnameInfo
    version
    };

my $filename = shift @ARGV;
open my $fh, "<", $filename or die "can not open $filename";
my @output;

while (my $line = <$fh>) {
    chomp $line;
    my ($module) = $line =~ m!/auto/([\w/]+)/\.packlist$!;
    warn "Could not process line |$line|"
        unless $module;
    next if grep { $_ eq $module } @ignored_package;
    die "I do not know what to do with the |$module| module"
        unless delete $handled_packages{$module};
    push @output, $line;
}
close $fh;

if (%handled_packages) {
    die "did not see the following modules: " . join(', ', keys %handled_packages);
}

open  $fh, ">", $filename or die "can not open $filename to write";
print $fh join("\n", @output), "\n";
close $fh;
