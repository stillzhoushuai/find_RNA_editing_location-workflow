#!usr/bin/perl -w
$dir=$ARGV[0];
opendir(DIR,$dir) or die "cannot open the directory";
@dir=readdir (DIR);
open OUT, ">$dir/sort_505_548_result.sh";
foreach $file (@dir){
if ($file=~/.result$/)
{print "$file\n";
@name=split/\./,$file;
print OUT "sort -T /home/storage/tmp -k 3,3 -k 4,4n -o $name[0]\_sort.txt $file\n";









}




}
