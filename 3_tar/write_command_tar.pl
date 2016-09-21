#!usr/bin/perl -w
$dir=$ARGV[0];
opendir(DIR,$dir) or die "cannot open the directory";
@dir=readdir (DIR);
open OUT, ">$dir/tar_505_548_sam.sh";
foreach $file (@dir){
if ($file=~/.sam$/)
{print "$file\n";
print OUT "tar -czvf $file\.tar.gz $file\n";









}




}
