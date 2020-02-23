#!/usr/bin/perl

my ($infile, $symname) = @ARGV;
open(my $infh, "<", $infile) or die("error: could not open $infile for reading");
my @intext;
my $inlen = 0;
while (<$infh>) {
    $inlen += length;

    s/\0/\\0/g;
    s/"/\\"/g;
    s/\t/\\t/g;
    s/\r/\\r/g;
    s/\n/\\n/g;
    s/[\x01-\x1f\x7f-\xff]/'\\x'.hex(ord('$1'))/eg;
    push @intext,$_;
}
close($infh);

print "// Generated by text2c.pl. Do not edit directly.\n\n";
print "const char ${symname}[] =\n";
print map { "\t\"" . $_ . "\"\n" } @intext;
print ";\n\n";
print "const int ${symname}_size = $inlen;\n";