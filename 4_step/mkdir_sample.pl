#!usr/bin perl -w
$dir="/home/storage/lung/result_samB";
opendir(DIR,$dir) or die "cannnot open the directory";
@dir=readdir(DIR);
open OUT1,">/home/storage/lung/result_samB/mkdir_sample_B.sh";
open OUT2,">/home/storage/lung/result_samB/mkdir_run_B.sh";
open OUT3,">/home/storage/lung/result_samB/mkdir_sort_in_chr_B.sh";
open OUT4,">/home/storage/lung/result_samB/4_sepreate_in_chr_command_B.sh";
open OUT5,">/home/storage/lung/result_samB/mkdir_cluster.sh";
open OUT6,">/home/storage/lung/result_samB/5_cluster_command_B.sh";
open OUT7,">/home/storage/lung/result_samB/mkdir_diff_point_B.sh";
open OUT8,">/home/storage/lung/result_samB/6_diff_point_B_command.sh";
open OUT9,">/home/storage/lung/result_samB/mkdir_filter_snp_B_command.sh";
open OUT10,">/home/storage/lung/result_samB/7_filter_snp_B_command.sh";
open OUT11,">/home/storage/lung/result_samB/mkdir_filter_terminate_B_command.sh";
open OUT12,">/home/storage/lung/result_samB/8_filter_terminate_B_command.sh";
foreach $file (@dir){
if ($file=~/.result$/){

print "$file\n";
@array1=split/\./,$file;

open IN,"lung_runname.list";
while($rd=<IN>){
chomp $rd;
@array2=split/\t/,$rd;

if ($array1[0] eq $array2[1]){
$run=substr($array1[0],6,3);
print OUT1 "mkdir /home/storage/lung/resultsB/$array2[0]\n";
print OUT2 "mkdir /home/storage/lung/resultsB/$array2[0]/$array2[1]\n";
print OUT3 "mkdir /home/storage/lung/resultsB/$array2[0]/$array2[1]/sort_in_chr\n";
print OUT4 "perl 4_sep_in_chr.pl $array1[0]\_sort.txt /home/storage/lung/resultsB/$array2[0]\n";
print OUT5 "mkdir /home/storage/lung/resultsB/$array2[0]/$array2[1]/cluster\n";
print OUT6 "perl 5_statical_all_c.pl /home/storage/lung/resultsB/$array2[0]/$array2[1]\n";
print OUT7 "mkdir /home/storage/lung/resultsB/$array2[0]/$array2[1]/diff_point\n";
print OUT8 "perl 6_find_diff_point_bowtie.pl /home/storage/lung/resultsB/$array2[0]/$array2[1] $run\n";
print OUT9 "mkdir /home/storage/lung/resultsB/$array2[0]/$array2[1]/filter_snp\n";
print OUT10 "perl  7_filter_snp.pl /home/storage/lung/resultsB/$array2[0]/$array2[1]\n";
print OUT11 "mkdir /home/storage/lung/resultsB/$array2[0]/$array2[1]/filter_terminate\n";
print OUT10 "perl  8_filter_terminate.pl /home/storage/lung/resultsB/$array2[0]/$array2[1] $run\n ";





}





}




}





}
