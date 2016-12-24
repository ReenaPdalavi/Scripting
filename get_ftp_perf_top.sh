#!/bin/ksh
. /home/userslmt/serverstat_sql/script/env.sh

if [ $# == 2 ];then
server=$2
time_out=$1
date1=`date +'%m/%d/%y %H:%M'`
date2=`date +'%m_%d_%y_%H_%M'`

	#rsh $server "cd /user/dpdsys/dpd/bin/script &&  ./get_ftp_perf.sh '$date1'  '$date2'" 
	is_ssh=`cat $bin_dir/ssh_machines.txt |grep ^$2`

	if [ "x" != "x$is_ssh" ];then	
		$bin_dir/set_ssh_timeout.sh $time_out $server  $script_dir/get_ftp_perf.sh  "'$date1'" "'$date2'"
	else
		$bin_dir/set_rsh_timeout.sh $time_out $server  $script_dir/get_ftp_perf.sh  "'$date1'" "'$date2'"
	fi
else

	echo "Usage: $0 <time_out> <server name> <command/Script name> <argument list for command or script>"
fi
