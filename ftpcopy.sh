#!/bin/ksh

file=$1
ftp -v 172.28.2.6 <<!
bi
ha
cd /home/userxfer/serverstat/db/licenseinfo
put $file 
! 