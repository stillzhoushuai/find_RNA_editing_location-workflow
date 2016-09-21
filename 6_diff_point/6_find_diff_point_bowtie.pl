#!usr/bin/perl -w	#perl for Bowtie 直接输入聚类文件即可，因为聚类第一行标有基因组信息，相当于所有已知位点
use Switch;
my $starttime=time;
$dir=$ARGV[0]."/cluster";#输入的聚类文件路径
$dir1=$ARGV[0]."/diff_point";				#输出的结果文件路径
$run=$ARGV[1];
opendir (DIR,$dir) or die "Can't open the document!";
@dir= readdir DIR;
foreach $file (@dir){
	if($file =~ /_resort_$run/){#读取聚类文件
		print "$file\n";
		@name2=split/_/,$file;
		$file_name=$name2[0];#染色体名

		open IN,"$dir/$file";
		open OUT,">$dir1/result_$file_name\_$run\.txt";#输出文件
		while($rd=<IN>){
			chomp $rd;
			@rd=split/\s+/,$rd;
			if($rd[0]=~/^>chr/){#----每个聚类的开始标志：读取以>chr开头的行
				@rd1=split/_/,$rd[0];
				@rd2=split/-/,$rd1[1];#分割后得到聚类起始、终止坐标
				@rd3=split/:/,$rd[2];#聚类中的序列条数，reads：100
				$base_num=length $rd[3];#聚类中的基因组碱基个数
#-----------------------------初始化
				for($i=0;$i<$base_num;$i++){#每一个位点的信息初始化
					$array0[$i]="";    #记录该类中第i个位点的染色体
					$array1[$i]=0;		 #记录该类中第i个位点的坐标
					$array2[$i]="";	 #记录该类中第i个位点的碱基类型（基因组上）
					$array_A[$i]=0;	 #记录该泪中第i个位点的RNA-Seq序列上四种碱基出现的频数
					$array_T[$i]=0;
					$array_C[$i]=0;
					$array_G[$i]=0;
				}
				$tt="";         	#记录读段上的碱基类型
				$count=$rd3[1];	#该类中的序列总条数
#-----------------------------将基因组碱基信息读入内存，给每一个位点赋初值
				for($i=0;$i<$base_num;$i++){
					$array0[$i]=$file_name;#-----------染色体
					$array1[$i]=$rd2[0]+$i;#-----------坐标
					$array2[$i]=substr($rd[3],$i,1);#--碱基类型，ACGTN
				}
			}else{#-----------------读取该类中的reads
				$count--;#记录该类中剩余行数，当count为0时，表明已经到了该类的最后一行
				$num=@rd;#该行被Tab键分割的单元数，TopHat第一轮比对有13列，第二轮比对有14列,bowtie有15列(solid)
				if($rd[$#rd] =~ /^CM:i:/){#判断是否为solid格式
					$num--;
				}
				for($i=0;$i<$base_num;$i++){#对于每一行，遍历所有位点，看是否有位点在该行上
					if($array1[$i]>=($rd[$num-10]+length($rd[$num-14]))){#第i个位点坐标超出该行的范围，则第i+1个位点也超出范围，跳出for循环
						last;
					}elsif($array1[$i]<$rd[$num-10]){#第i个位点坐标小于该行的范围，继续搜索第i+1个位点
						next;
					}else{#第i个位点坐标在该行范围内，记录该位点的碱基类型，ACGTN?
						$pos=$array1[$i]-$rd[$num-10]; #编辑位点的坐标减去读段的起始坐标,得到距离最左边的长度
						$tt=substr($rd[$num-14],$pos,1);#捕获到序列上的i碱基
						switch($tt){
							case ("A") {$array_A[$i]++;last;}#记录第i位点的转录情况：ACGT各有多少?
							case ("T") {$array_T[$i]++;last;}
							case ("C") {$array_C[$i]++;last;}
							case ("G") {$array_G[$i]++;last;}
							default {last;}
						}
					}
				}
				if($count==0){#读到该类的最后一行，统计该类中所有位点的信息，并输出
					for($i=0;$i<$base_num;$i++){
						$sum=$array_A[$i]+$array_T[$i]+$array_C[$i]+$array_G[$i];#第i个位点的覆盖条数
						$flag_0=0;#--------------记录错配碱基种数
						$flag_1=0;#--------------记录错配碱基支持数
						$flag_2="";#-------------记录错配碱基类型
#---------------------每一个位点i，按照基因组碱基不同，分成四种情况考虑
						if($array2[$i] eq "A"){#---基因组是A，顺序TCG
							$temp_count[0]=$array_T[$i];#错配数
							$temp_count[1]=$array_C[$i];
							$temp_count[2]=$array_G[$i];
							$temp_base[0]="T";			 #碱基
							$temp_base[1]="C";
							$temp_base[2]="G";
							if($array_A[$i]==$sum){#无错配，不输出
								next;
							}else{
								for($j=0;$j<3;$j++){#TCG循环
									if($temp_count[$j]!=0){#是否有A－T，A－C，A－G错配
										$flag_0++;					#记录错配种数
										$flag_1=$temp_count[$j];#记录错配个数
										$flag_2=$temp_base[$j]; #记录错配类型
									}
								}
								if($flag_0==1){#---------只输出含一种错配类型的位点
									print OUT "$array0[$i]\t$array1[$i]\t$array2[$i]-$flag_2\tA:$array_A[$i]\t$flag_2:$flag_1\tsum:$sum\n";
								}
							}
						}elsif($array2[$i] eq "T"){#---基因组是T，顺序ACG
							$temp_count[0]=$array_A[$i];#错配数
							$temp_count[1]=$array_C[$i];
							$temp_count[2]=$array_G[$i];
							$temp_base[0]="A";					#碱基
							$temp_base[1]="C";
							$temp_base[2]="G";
							if($array_T[$i]==$sum){#无错配，不输出
								next;
							}else{
								for($j=0;$j<3;$j++){#ACG循环
									if($temp_count[$j]!=0){
										$flag_0++;
										$flag_1=$temp_count[$j];
										$flag_2=$temp_base[$j];
									}
								}
								if($flag_0==1){#---------保证只有一种错配类型
									print OUT "$array0[$i]\t$array1[$i]\t$array2[$i]-$flag_2\tT:$array_T[$i]\t$flag_2:$flag_1\tsum:$sum\n";
								}
							}
						}elsif($array2[$i] eq "C"){#---基因组是C，顺序ATG
							$temp_count[0]=$array_A[$i];#错配数
							$temp_count[1]=$array_T[$i];
							$temp_count[2]=$array_G[$i];
							$temp_base[0]="A";					#碱基
							$temp_base[1]="T";
							$temp_base[2]="G";
							if($array_C[$i]==$sum){#无错配，不输出
								next;
							}else{
								for($j=0;$j<3;$j++){#ATG循环
									if($temp_count[$j]!=0){
										$flag_0++;
										$flag_1=$temp_count[$j];
										$flag_2=$temp_base[$j];
									}
								}
								if($flag_0==1){#---------保证只有一种错配类型
									print OUT "$array0[$i]\t$array1[$i]\t$array2[$i]-$flag_2\tC:$array_C[$i]\t$flag_2:$flag_1\tsum:$sum\n";
								}
							}
						}elsif($array2[$i] eq "G"){#---基因组是G，顺序ATC
							$temp_count[0]=$array_A[$i];#错配数
							$temp_count[1]=$array_T[$i];
							$temp_count[2]=$array_C[$i];
							$temp_base[0]="A";					#碱基
							$temp_base[1]="T";
							$temp_base[2]="C";
							if($array_G[$i]==$sum){#无错配，不输出
								next;
							}else{
								for($j=0;$j<3;$j++){#ATC循环
									if($temp_count[$j]!=0){
										$flag_0++;
										$flag_1=$temp_count[$j];
										$flag_2=$temp_base[$j];
									}
								}
								if($flag_0==1){#---------保证只有一种错配类型
									print OUT "$array0[$i]\t$array1[$i]\t$array2[$i]-$flag_2\tG:$array_G[$i]\t$flag_2:$flag_1\tsum:$sum\n";
								}
							}
						}else{
							next;
						}
					}
				}
			}
		}
	}
}

			

my $duration=time-$starttime;
print "time:$duration";
