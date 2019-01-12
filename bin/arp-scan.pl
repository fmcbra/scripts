#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename qw(basename);

# Script filename
use constant SCRIPT_NAME => basename($0);

# Sample output:
# $ arp-scan 10.2.0.0/24
# Interface: eth0, datalink type: EN10MB (Ethernet)
# Starting arp-scan 1.9.5 with 256 hosts (https://github.com/royhills/arp-scan)
# 10.2.0.1        xx:xx:xx:xx:xx:xx       (Unknown)

## {{{ datetime()
sub datetime
{
  my @m = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
  my @d = qw(Sun Mon Tue Wed Thu Fri Sat Sun);

  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime;
  my %dt = (
    year  => $year,
    day   => $d[$wday],
    date  => $mday,
    month => $m[$mon],
    sec   => $sec,
    min   => $min,
    hour  => $hour,
  );

  $dt{'dstr'} = sprintf "%s %02d %s", $d[$wday], $mday, $m[$mon];
  $dt{'tstr'} = sprintf "%02d:%02d:%02d", $hour, $min, $sec;

  return %dt;
}
## }}}

## {{{ main()
sub main
{
  # FIXME: check arguments passed to arp-scan to make sure they are actually IP
  # address(es) or network addresses in CIDR format.
  my $args = '';
  foreach my $arg (@ARGV)
  {
    $args = "$args $arg";
  }

  open(my $fh, "arp-scan $args |") or die $!;

  while (my $line = <$fh>)
  {
    chomp $line;
    next unless $line =~ /^([0-9\.]+)\s+([0-9a-f:]+)\s+(.*)$/;

    my ($ip, $mac, $desc) = ($1, $2, $3);
    next if $desc =~ /DUP/;

    my %now = &datetime;
    printf "[%s %s] Found host %s with MAC address %s\n",
      $now{'dstr'}, $now{'tstr'}, $ip, $mac;
  }
}
## }}}

if (scalar @ARGV < 1)
{
  printf "Usage: %s <network...>\n", SCRIPT_NAME;
  exit 1;
}

&main;

##
# vim: ts=2 sw=2 et fdm=marker :
##
