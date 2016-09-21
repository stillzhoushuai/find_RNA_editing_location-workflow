#!usr/bin/perl -w
$string= $ARGV[0];
$run=$ARGV[1];
$dir1="$string/filter_duplicate";
opendir (DIR ,$dir1) or die "cannot open the directory";
@dir1=readdir(DIR);
foreach $file(@dir1){
if ($file=~/^sort_duplicate_chr/){
@array1=split/_/,$file;
$chrname=$array1[2];
$filename1=$file;#sort_duplicate_chr17_473.txt
$wfilename="fast_duplicate_$chrname\_$run.list";#fast_duplicate_chr9.list
$filename2="result_terminate\_$chrname\_$run.txt";#/home/lungcancer/ERR164473/filter_terminate/ERR164473_result_terminate_chr21.txt
print "$filename1\t$wfilename\t$filename2\n";

open FILE1, "$dir1/$filename1" or die "can't open file:$!";
open WFILE, ">$dir1/$wfilename" or die "can't open file:$!";

@des= "";
open FILE2, "$string/filter_terminate/$filename2" or die "can't open file:$!";  
	while ($line2=<FILE2>){#
		chomp $line2;    
		push(@des,$line2);
#			@lines2 = split('\t+',$line2);
#			$tmp = $lines2[5];
#			@lines3 = split(':',$tmp);
#			$read_num = $lines3[1];
#			@reads = push(@reads,$read_num);
		}
		$i = 1;
		$tag = 1;
while ($line1=<FILE1>){#sort_dup
	chomp $line1;
	@lines1 = split('	',$line1);
	if ($i == 1){
		print WFILE ">$des[$i]\n";
		print WFILE "$line1\n";
		$old_pos = $lines1[1];
	}
	else
	{
		$new_pos = $lines1[1];
		#print "$new_pos is ok\n";
		if ($new_pos eq $old_pos){
			print WFILE "$line1\n";
			$old_pos = $new_pos;
		}
		else
		{
			$tag++;
			print WFILE "//\n>$des[$tag]\n";
			print WFILE "$line1\n";
			$old_pos = $new_pos;
		}
	}
	$i++;
 }
print WFILE "//\n";	




}}
