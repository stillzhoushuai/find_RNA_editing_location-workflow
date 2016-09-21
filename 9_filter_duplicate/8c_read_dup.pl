#!usr/bin/perl -w
$dir= $ARGV[0]."/filter_duplicate";
$run=$ARGV[1];
opendir DIR,$dir or die "cannot open the directory";
@dir=readdir(DIR);
foreach $file(@dir)
{ if ($file=~/^fast_duplicate_chr/){
print "$file\n";
$filename1 = $file;
$filename2 = "ascii.txt";
@array_name=split/_/,$file;

$wfilename = "asci_duplicate_$array_name[2]\_$run.list1";#
open FILE1, "$dir/$filename1" or die "can't open file:$!";
open WFILE, ">$dir/$wfilename" or die "can't open file:$!";
while ($line1=<FILE1>){
	chomp $line1;
	if ($line1 =~ />chr/){
		@lines0 = split('\t+',$line1);
		$tmp = $lines0[5];
		@lines00 = split(':',$tmp);
		$read_num = $lines00[1];
		#print "$read_num\n";
		print WFILE "$line1\n";
		$old_pos = 0;
		$old_qul = 0;
		$old_res = "";
		$tag = 0;
	} 
	elsif ($line1 =~ /ERR/){                       #      *******************
		$tag++;
		@lines1 = split('\t+',$line1);
		$obj_pos = $lines1[7];   ###
		$query_qul = $lines1[8];
		open FILE2, "$filename2" or die "can't open file:$!"; 
		while ($line2=<FILE2>){
			chomp $line2;
			@lines2 = split('\t+',$line2);
			$obj_qul = $lines2[0];
			if ($query_qul eq $obj_qul){
				$new_qul = $lines2[1];###
			}
		}
		if ($obj_pos > $old_pos and $tag == 1){
			$old_pos = $obj_pos;
			$old_qul = $new_qul;
			$old_res = $line1;
		}
		elsif ($obj_pos > $old_pos and $tag != 1){
			print WFILE "$old_res\t$old_qul\n";
			$old_pos = $obj_pos;
			$old_qul = $new_qul;
			$old_res = $line1; 
			if ($tag == $read_num){
				print WFILE "$line1\t$new_qul\n";
			}
		}
		elsif ($obj_pos == $old_pos){
			if ($old_qul < $new_qul){
				$old_pos = $obj_pos;
				$old_qul = $new_qul;
				$old_res = $line1;
			}
			if ($tag == $read_num){
				if ($old_qul < $new_qul){
					print WFILE "$line1\t$new_qul\n";
				}
				else
				{
					print WFILE "$old_res\t$old_qul\n";
				}
			}
		}
	}
	elsif ($line1 =~ /\/\//){
if($tag == 1){print WFILE "$old_res\t$old_qul\n";}
		print WFILE "$line1\n";
	}
}




}








}
