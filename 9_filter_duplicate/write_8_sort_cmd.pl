#!usr/bin/perl -w
open IN ,"$ARGV[0]";
open OUT,">$ARGV[1]";
while($rd=<IN>){
chomp $rd;
@array=split/\s+/,$rd;
#perl 8a_dup_read.pl /home/storage/lung/resultsA/LC_C10_nor/ERR164479 479
print "$array[3]\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chrY_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chrY_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr20_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr20_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr11_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr11_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr9_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr9_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr10_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr10_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr8_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr8_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr5_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr5_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr12_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr12_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chrX_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chrX_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr6_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr6_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr19_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr19_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr17_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr17_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr7_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr7_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr3_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr3_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr1_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr1_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr21_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr21_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr15_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr15_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr22_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr22_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr4_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr4_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr2_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr2_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr14_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr14_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr18_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr18_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr16_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr16_$array[3]\.txt\n";
print OUT "sort -n  -k 2 -k 8 -o $array[2]/filter_duplicate/sort_duplicate_chr13_$array[3]\.txt $array[2]/filter_duplicate/result_duplicate_chr13_$array[3]\.txt\n";

}
