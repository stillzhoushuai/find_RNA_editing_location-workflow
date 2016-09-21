#!usr/bin/perl -w
#$dir="/home/storage/lung_cancer/all_gz_files";
$dir="/home/storage/lung/ls";
opendir(DIR,$dir) or die "cannot open the directory";
@dir=readdir(DIR);
open OUT,">$dir/ls_gunzip_500-549.sh";
foreach $file(@dir){

if ($file=~/.fastq.gz/){
print "$file\n";
@name=split/_/,$file;
print OUT "gunzip $file\n";
#$filename1=$name[0]."_1.fastq";
#$filename2=$name[0]."_2.fastq";
#print OUT "./bowtie -t -n 1 -e 120 -l 28 -S -m 1 --chunkmbs 500 -p 5 -X 500 hg19 -1 /home/storage/lungcancer/$filename1 -2 /home/storage/lungcancer/$filename2 $name[0].sam\n";

}

}




