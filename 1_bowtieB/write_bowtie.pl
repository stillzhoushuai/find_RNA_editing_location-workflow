#!usr/bin/perl -w
#$dir="/home/storage/lung_cancer/all_gz_files";
$dir="/home/storage/lung/ls";
opendir(DIR,$dir) or die "cannot open the directory";
@dir=readdir(DIR);
open OUT,">$dir/ls_bowtie_505-549.sh";
foreach $file(@dir){

if ($file=~/_1.fastq/){
print "$file\n";
@name=split/_/,$file;
#print OUT "gunzip $file\n";
$filename1=$name[0]."_1.fastq";
$filename2=$name[0]."_2.fastq";
print OUT "./bowtie -t -v 3 -S -m 1 -p 7 -X 500 hg19 -1 /home/storage/lung/ls/$filename1 -2 /home/storage/lung/ls/$filename2 /home/storage/lung/result_samB/$name[0].sam\n";

}

}




