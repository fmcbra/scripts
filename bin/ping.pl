#!/usr/bin/env perl

use strict;
use warnings;

# Good output:
#   $ ping 192.168.1.3
#   PING 192.168.1.3 (192.168.1.3) 56(84) bytes of data.
#   64 bytes from 192.168.1.3: icmp_seq=1 ttl=64 time=752 ms
#
# Bad output:
#
#   $ ping 192.168.1.3
#   PING 192.168.1.3 (192.168.1.3) 56(84) bytes of data.
#   From 192.168.1.2 icmp_seq=1 Destination Host Unreachable

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
  my $host = $ARGV[0];

  for (;;)
  {
    open(my $fh, "ping -W3 $host |") or die $!;

    my $ip = undef;
    my $prev_line;
    my $i = 0;

    while (my $line = <$fh>)
    {
      chomp $line;
      my %now = &datetime;
      my $st = 'DOWN';

      if ($line =~ /^PING [^ ]+ ([^ ]+)/)
      {
        $ip = $1;
        next;
      }

      ++$i;

      if ($line =~ /^\d+ bytes from ([^ ]+): /)
      {
        $st = 'UP'
      }
      elsif ($line =~ /^From [^ ]+ icmp_seq=\d+ (.*)$/)
      {
        $st = "$st ($1)";
      }

      $line = sprintf "[%s %s] Host %s is %s",
        $now{'dstr'},
        $now{'tstr'},
        $host,
        $st;

      print "$line\n" unless (defined $prev_line && $line eq $prev_line);
      $prev_line = $line;
    }
  }
}
## }}}

if (scalar @ARGV != 1)
{
  print "Usage: ping.pl <addr>\n";
  exit 1;
}

&main;

##
# vim: ts=2 sw=2 et fdm=marker :
##
