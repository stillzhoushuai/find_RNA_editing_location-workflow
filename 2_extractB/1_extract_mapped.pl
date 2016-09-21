#!usr/bin/perl -w
$dir=$ARGV[0];
opendir (DIR, $dir) or die "can’t open the directory!"; 
@dir = readdir DIR; 
foreach $file (@dir){
	#if($file =~ /^SRR/ && $file =~ /.sam$/){#匹配所有SAM文件
	if($file =~ /^ERR/ && $file =~ /.sam$/){#匹配所有SAM文件
		print "$file\n";
		@tt=split/.sam/,$file;
		$file2=$tt[0].".result";#out文件名
		$a=0;
		open IN,"$dir/$file";
		open OUT,">$dir/$file2";
		while($rd=<IN>){
			$a++;
			if($a>26){ #sam文件中人类的数据前26行为说明文字，小鼠为22，黑猩猩为27
				chomp $rd;
				@rd=split/\s+/,$rd;
				if($rd[2]=~/^chr/){
					print OUT "$rd\n";
				}
			}
		}
	}
}
