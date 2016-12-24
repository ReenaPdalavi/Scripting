#!/usr/bin/perl
$flag_to_convert=$ARGV[0];
$value=$ARGV[1];
#print "valus is $flag_to_convert $value";

if ( $flag_to_convert eq "KB" )
{
	 my $value_to_return=$value/1000000;
	 print "$value_to_return";
}
else
{
	
	if ( $flag_to_convert eq "MB" )
	{
		 my $value_to_return=$value/1000;
		 print "$value_to_return";
	}
	else
	{
		if ( $flag_to_convert eq "GB" )
		{
			 my $value_to_return=$value/1;
		 	print "$value_to_return";
		}	
		else
		{
			if ( $flag_to_convert eq "NA" )
			{
				
		 		print "0";
			}	
		}
	}	
}




