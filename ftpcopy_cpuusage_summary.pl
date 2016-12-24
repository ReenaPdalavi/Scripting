#!/usr/bin/perl5

use Net::FTP;

    $ftp = Net::FTP->new("172.28.2.6", Debug => 0)
      or die "Cannot connect to machine : $@";

    $ftp->login("userxfer",'usercopy123#')
      or die "Cannot login ", $ftp->message;

    $ftp->cwd("/home/userxfer/serverstat/db/cpu_usage")
      or die "Cannot change working directory ", $ftp->message;

    $ftp->put("$ARGV[0]")
      or die "put failed ", $ftp->message;

    $ftp->quit;