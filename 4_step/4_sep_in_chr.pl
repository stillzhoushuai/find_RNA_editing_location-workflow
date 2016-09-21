#!usr/bin/perl -w
#use Switch;
$file=$ARGV[0];
$dir=$ARGV[1];  #打开要分割的文件所在文件夹
 open IN, "/home/storage/lung/result_samB/$file";
		print "$file\n";
		@tt=split/_/,$file;
		$run=substr($tt[0],6,3);
		
		open OUT1,">$dir/$tt[0]/sort_in_chr/sort_in_chr1_$run\.txt";#注意输出路径####预先建立文件夹$tt[0]
		open OUT2,">$dir/$tt[0]/sort_in_chr/sort_in_chr2_$run\.txt";
		open OUT3,">$dir/$tt[0]/sort_in_chr/sort_in_chr3_$run\.txt";
		open OUT4,">$dir/$tt[0]/sort_in_chr/sort_in_chr4_$run\.txt";
		open OUT5,">$dir/$tt[0]/sort_in_chr/sort_in_chr5_$run\.txt";
		open OUT6,">$dir/$tt[0]/sort_in_chr/sort_in_chr6_$run\.txt";
		open OUT7,">$dir/$tt[0]/sort_in_chr/sort_in_chr7_$run\.txt";
		open OUT8,">$dir/$tt[0]/sort_in_chr/sort_in_chr8_$run\.txt";
		open OUT9,">$dir/$tt[0]/sort_in_chr/sort_in_chr9_$run\.txt";
		open OUT10,">$dir/$tt[0]/sort_in_chr/sort_in_chr10_$run\.txt";
		open OUT11,">$dir/$tt[0]/sort_in_chr/sort_in_chr11_$run\.txt";
		open OUT12,">$dir/$tt[0]/sort_in_chr/sort_in_chr12_$run\.txt";
		open OUT13,">$dir/$tt[0]/sort_in_chr/sort_in_chr13_$run\.txt";
		open OUT14,">$dir/$tt[0]/sort_in_chr/sort_in_chr14_$run\.txt";
		open OUT15,">$dir/$tt[0]/sort_in_chr/sort_in_chr15_$run\.txt";
		open OUT16,">$dir/$tt[0]/sort_in_chr/sort_in_chr16_$run\.txt";
		open OUT17,">$dir/$tt[0]/sort_in_chr/sort_in_chr17_$run\.txt";
		open OUT18,">$dir/$tt[0]/sort_in_chr/sort_in_chr18_$run\.txt";
		open OUT19,">$dir/$tt[0]/sort_in_chr/sort_in_chr19_$run\.txt";
		open OUT20,">$dir/$tt[0]/sort_in_chr/sort_in_chr20_$run\.txt";
		open OUT21,">$dir/$tt[0]/sort_in_chr/sort_in_chr21_$run\.txt";
		open OUT22,">$dir/$tt[0]/sort_in_chr/sort_in_chr22_$run\.txt";
		open OUTX,">$dir/$tt[0]/sort_in_chr/sort_in_chrX_$run\.txt";
		open OUTY,">$dir/$tt[0]/sort_in_chr/sort_in_chrY_$run\.txt";
		while($rd=<IN>){
			chomp $rd;
			@rds=split(/\s+/,$rd);
			if($rds[2] eq "chr1"){
				print OUT1 "$rd\n";
			}elsif($rds[2] eq "chr2"){
				print OUT2 "$rd\n";
			}elsif($rds[2] eq "chr3"){
				print OUT3 "$rd\n";
			}elsif($rds[2] eq "chr4"){
				print OUT4 "$rd\n";
			}elsif($rds[2] eq "chr5"){
				print OUT5 "$rd\n";
			}elsif($rds[2] eq "chr6"){
				print OUT6 "$rd\n";
			}elsif($rds[2] eq "chr7"){
				print OUT7 "$rd\n";
			}elsif($rds[2] eq "chr8"){
				print OUT8 "$rd\n";
			}elsif($rds[2] eq "chr9"){
				print OUT9 "$rd\n";
			}elsif($rds[2] eq "chr10"){
				print OUT10 "$rd\n";
			}elsif($rds[2] eq "chr11"){
				print OUT11 "$rd\n";
			}elsif($rds[2] eq "chr12"){
				print OUT12 "$rd\n";
			}elsif($rds[2] eq "chr13"){
				print OUT13 "$rd\n";
			}elsif($rds[2] eq "chr14"){
				print OUT14 "$rd\n";
			}elsif($rds[2] eq "chr15"){
				print OUT15 "$rd\n";
			}elsif($rds[2] eq "chr16"){
				print OUT16 "$rd\n";
			}elsif($rds[2] eq "chr17"){
				print OUT17 "$rd\n";
			}elsif($rds[2] eq "chr18"){
				print OUT18 "$rd\n";
			}elsif($rds[2] eq "chr19"){
				print OUT19 "$rd\n";
			}elsif($rds[2] eq "chr20"){
				print OUT20 "$rd\n";
			}elsif($rds[2] eq "chr21"){
				print OUT21 "$rd\n";
			}elsif($rds[2] eq "chr22"){
				print OUT22 "$rd\n";
			}elsif($rds[2] eq "chrX"){
				print OUTX "$rd\n";
			}elsif($rds[2] eq "chrY"){
				print OUTY "$rd\n";
			}
                   }
	

