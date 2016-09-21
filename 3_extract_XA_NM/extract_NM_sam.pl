#!usr/bin/perl -w
$dir=$ARGV[0];
opendir (DIR, $dir) or die "can’t open the directory!"; 

@dir = readdir DIR; 
foreach $file (@dir){
if($file =~ /.sam$/){
print "$file\n";
@array_name=split/\./,$file;
$filename=$array_name[0];
$fileoutname=$filename."_NM.txt";
#print "$fileoutname\n";
open FILE,"$dir/$file";
open WFILE,">$dir/NM_resultsB/$fileoutname";
open OUT,">>$dir/lung_cancer_NM_sumB.txt";
$sum=0;
@array_num="";

while($rd=<FILE>){
	
	chomp $rd;
   $flag=0;
	@array=split/\t/,$rd;
	for($i=0;$i<@array;$i++){

		if ($array[$i]=~/^NM:/){
			$flag=1;
			
         @array_num=split/:/,$array[$i];
         $sum=$sum+$array_num[2];
        print WFILE "$array_num[2]\n";
			}
}
}
print "$fileoutname\tsum:$sum\n";
print  OUT "$file\tsum:$sum\n";
}
}
