#!/bin/ksh

hostname=$(uname)

#create userslmt user
create_user_linux()
{
# Script to add a user to Linux system
if [ $(id -u) -eq 0 ]; then
	username="userslmt"
	password="userslmt"
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p $pass $username
		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
	fi
else
	echo "Only root may add a user to the system"
	exit 2
fi
}

create_user_aix()
{
cat /etc/passwd | grep userslmt
if [ $? -eq 0 ]; then
	echo "username exists"
	exit 1
else
	mkuser userslmt
	echo userslmt:userslmt | chpasswd
	echo userslmt:userslmt | chpasswd
fi
}

#create folder structure with this user

create_dir()
{
mkdir -p /home/userslmt/serverstat_sql/sql_db
mkdir -p /home/userslmt/serverstat_sql/sql_bin
cd /home/userslmt/serverstat_sql/sql_db
mkdir self_cron up_time cpu_usage mem_usage ftp_perf
cd /home/userslmt/
chown -R userslmt *
}

#put files in respective locations


#create cron jobs
