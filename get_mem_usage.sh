#!/bin/ksh
. $HOME/bin/env.sh
hostname1=`hostname`
tempdb="/tmp"
#date1=$1
#date2=$2

date1=`date +'%m/%d/%y %H:%M'`
date2=`date +'%m_%d_%y_%H_%M'`

osname=`uname`
unit_value="NA"
#prefix="usersrveng1"
prefix="USERSRVENG1"

check_unit()
{
	Is_K=`echo $1 | grep -i K`
	Is_M=`echo $1 | grep -i M`
	Is_G=`echo $1 | grep -i G`
	if [ "x$Is_KB" != "x" -o "x$Is_K" != "x" ];then
		unit_value="KB"
	fi
	if [ "x$Is_MB" != "x" -o "x$Is_M" != "x" ];then
		unit_value="MB"
	fi
	if [ "x$Is_GB" != "x" -o "x$Is_G" != "x" ];then
		unit_value="GB"
	fi
}

case $osname in 
	Linux)
		top -bn 1 >$tempdb/cpumemory_${date2}.txt 2>$tempdb/$$.err
		echo "top -bn 1 >${tempdb}/cpumemory_${date2}.txt 2>${tempdb}/$$.err"
		if [ -s $tempdb/$$.err -a $? ==  1 ];then
			flag_to_check_success=1
		else
			flag_to_check_success=0
		fi
		
if [ -s $tempdb/cpumemory_${date2}.txt -a $flag_to_check_success -eq 0 ];then
		line_for_data=`cat $tempdb/cpumemory_${date2}.txt | grep -i Mem | awk -F":" '{print $2}'`
		Max_mem=`echo $line_for_data | awk -F"," '{print $1}' | awk '{print $1}'`
		Avail_mem=`echo $line_for_data | awk -F"," '{print $2}' | awk '{print $1}'`
		Free_mem=`echo $line_for_data | awk -F"," '{print $3}' | awk '{print $1}'`
		line_for_data_swap=`cat $tempdb/cpumemory_${date2}.txt | grep -w Swap | awk -F":" '{print $2}'`
		Swap_mem=`echo $line_for_data_swap | awk -F"," '{print $1}' | awk '{print $1}'`
		Free_swap_mem=`echo  $line_for_data_swap | awk -F"," '{print $3}' | awk '{print $1}'`
		check_unit $Max_mem
		Max_mem=${Max_mem%?}
		Max_mem1=`perl $script_dir/convert_units.pl "$unit_value" "$Max_mem"`
		check_unit $Avail_mem
		Avail_mem=${Avail_mem%?}
		Avail_mem1=`perl $script_dir/convert_units.pl "$unit_value" "$Avail_mem"`
		check_unit $Free_mem
		Free_mem=${Free_mem%?}
		Free_mem1=`perl $script_dir/convert_units.pl "$unit_value" "$Free_mem"`
		check_unit $Swap_mem
		Swap_mem=${Swap_mem%?}
		Swap_mem1=`perl $script_dir/convert_units.pl "$unit_value" "$Swap_mem"`
		check_unit $Free_swap_mem
		Free_swap_mem=${Free_swap_mem%?}
		Free_swap_mem1=`perl $script_dir/convert_units.pl "$unit_value" "$Free_swap_mem"`
		echo "$date1,$Max_mem1,$Avail_mem1,$Free_mem1,$Swap_mem1,$Free_swap_mem1"
		echo $db_dir/mem_usage/${prefix}.cpumem.summary
		echo "$date1,$Max_mem1,$Avail_mem1,$Free_mem1,$Swap_mem1,$Free_swap_mem1" >> $db_dir/mem_usage/${prefix}.cpumem.summary
else
		echo "$date1,0,0,0,0,0" >>$db_dir/mem_usage/${prefix}.cpumem.summary
fi
		;;
	IRIX64)
		top -bn >$tempdb/cpumemory_${date2}.txt 2>$tempdb/$$.err
		if [ -s $tempdb/$$.err -a $? ==  1 ];then
			flag_to_check_success=1
		else
			flag_to_check_success=0
		fi
if [ -s $tempdb/cpumemory_${date2}.txt -a $flag_to_check_success -eq 0 ];then
		line_for_data=`cat $tempdb/cpumemory_${date2}.txt | grep -i Memory | awk -F":" '{print $2}'`
		Max_mem=`echo $line_for_data | awk -F"," '{print $1}' | awk '{print $1}'`
		Avail_mem=`echo $line_for_data | awk -F"," '{print $2}' | awk '{print $1}'`
		Free_mem=`echo $line_for_data | awk -F"," '{print $3}' | awk '{print $1}'`
		Swap_mem=`echo $line_for_data | awk -F"," '{print $4}' | awk '{print $1}'`
		Free_swap_mem=`echo $line_for_data | awk -F"," '{print $5}' | awk '{print $1}'`
		check_unit $Max_mem
		Max_mem=${Max_mem%?}
		Max_mem1=`perl $script_dir/convert_units.pl "$unit_value" "$Max_mem"`
		check_unit $Avail_mem
		Avail_mem=${Avail_mem%?}
		Avail_mem1=`perl $script_dir/convert_units.pl "$unit_value" "$Avail_mem"`
		check_unit $Free_mem
		Free_mem=${Free_mem%?}
		Free_mem1=`perl $script_dir/convert_units.pl "$unit_value" "$Free_mem"`
		check_unit $Swap_mem
		Swap_mem=${Swap_mem%?}
		Swap_mem1=`perl $script_dir/convert_units.pl "$unit_value" "$Swap_mem"`
		check_unit $Free_swap_mem
		Free_swap_mem=${Free_swap_mem%?}
		Free_swap_mem1=`perl $script_dir/convert_units.pl "$unit_value" "$Free_swap_mem"`
		echo "$date1,$Max_mem1,$Avail_mem1,$Free_mem1,$Swap_mem1,$Free_swap_mem1" >>$db_dir/mem_usage/${prefix}.cpumem.summary
else
		echo "$date1,0,0,0,0,0" >>$db_dir/mem_usage/${prefix}.cpumem.summary
fi
		;;
esac
if [ -f /tmp/$$.err ];then
	rm /tmp/$$.err
fi
rm /tmp/cpumemory_${date2}.txt

#$script_dir/ftpcopy_cpumem_summary.pl $db_dir/mem_usage/${prefix}.cpumem.summary ${prefix}.cpumem.summary
