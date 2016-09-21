#!usr/bin/perl -w
#-------------------滤除3'末端位点，重新统计位点的覆盖条数for bowtie，该脚本用于查询已知位点的编辑情况
use Switch;
my $starttime=time;
$dir0=$ARGV[0];#输入1：文件路径
$dir=$dir0."/cluster";#"聚类"
$run=$ARGV[1];
$dir1="$dir0/filter_terminate";#输入2：位点路径
$dir2="$dir0/filter_duplicate";#输出路径
opendir (DIR,$dir) or die "Can't open the document!";
@dir= readdir DIR;
foreach $file (@dir){
	if($file=~/_resort_$run.txt/){
		print "$file\n";
		@name2=split/_/,$file;
		$file_name=$name2[0];
		@array0="";     #记录已知A-to-I RNA编辑位点的染色体
		@array1=0;		 #记录已知位点的坐标
		@array2_g="";		 #------------------记录位点的基因组碱基
		@array2_t="";		 #------------------记录该位点的错配碱基
		@array3=0;			#----------------------记录已知位点的qual值
#		@array_A=0;
#		@array_T=0;
#		@array_C=0;
#		@array_G=0;
		@array_g=0;#支持基因组碱基数
		@array_t=0;#支持错配碱基数
		$array_l=0;     #数组的长度
		$start_p=0;     #在聚类范围位点数组起始坐标
		$end_p=0;       #在聚类范围位点数组的终止坐标
		$flag=0;        #标记该聚类是否需要处理
		$tt="";         #记录编辑位点所在坐标的读段碱基
		open IN1,"$dir1/result_terminate_$file_name\_$run.txt";
		while($rd=<IN1>){      #将编辑位点信息以数组形式储存在内存中
			chomp $rd;
			@point=split/\s+/,$rd;
			$array0[$array_l]=$point[0];     #位点所在的染色体
			$array1[$array_l]=$point[1];			#坐标
			@point2=split/-/,$point[2];
			$array2_g[$array_l]=$point2[0];			#基因组碱基类型
			$array2_t[$array_l]=$point2[1];			#基因组碱基类型
			$array3[$array_l]=$point[6];#--------------qual分值
			$array_l++;
		}
		$array0[$array_l]="";   #在数组后面多加一个初始化，防止后面出现未初始化
		$array1[$array_l]=0;
		$array2_g[$array_l]="";
		$array2_t[$array_l]="";
		$array3[$array_l]=0;					#---------------qual分值
  
		#位点存储完毕，读取聚类文件信息
		open IN2,"$dir/$file";
		open OUT,">$dir2/result_duplicate_$file_name\_$run.txt";
		while($rd=<IN2>){
			chomp $rd;
			@rd=split/\s+/,$rd;
			if($rd[0]=~/^>chr/){       #每个聚类的开始标志：>chr
				@rd1=split/_/,$rd[0];
				@rd2=split/-/,$rd1[1];     #分割该聚类起始、终止坐标
				if($array1[$array_l-1]<$rd2[0]){
					print " Complete!\n";
					last;
				}else{
					$start_p=$end_p;
					while($array1[$start_p]<$rd2[0]){	#确定聚类内编辑位点的起始数组坐标
						$start_p++;
					}
					$end_p=$start_p;
					while(($array1[$end_p]<=$rd2[1])&&($end_p<$array_l)){		#确定聚类内编辑位点的终止数据坐标
						$end_p++;
					}
					$end_p--;      #上一步计算中超过了聚类坐标的上限，要退回一个坐标
					if($array1[$start_p]>$rd2[1]){
						$flag=0;     #表明不需要计算，程序往下找下一个>chr
					}else{
						$flag=1;
						@rd3=split/:/,$rd[2];
						$count=$rd3[1];
						for($i=0;$i<=$end_p-$start_p;$i++){
							$array_g[$i]=0;#基因组碱基
							$array_t[$i]=0;#粗配碱基数
						}
					}
				}
			}elsif($flag==0){     #聚类区间没有编辑位点
				next;
			}elsif($flag==1){
				$num=@rd;      #该行被空格分割的单元数
				if($rd[$#rd] =~ /^CM:i:/){#判断是否为solid数据
					$num--;
				}
				$count--;
				$seq_len=length $rd[$num-14];#------------该行序列的长度
				#******
				$seq_name = $rd[$num-13];  #SRR名字
				#******
				$seq_qual = $rd[$num-4];#read的质量分数
				for($i=$start_p;$i<=$end_p;$i++){
					if($array1[$i]>=$rd[$num-10]+$seq_len){
						next;
					}elsif($array1[$i]<$rd[$num-10]){
						next;
					}else{
						$l=$i-$start_p;          #$end_p-$start_p的值，即该聚类要处理的位点数目
						$pos=$array1[$i]-$rd[$num-10];#编辑位点的坐标减去读段的起始坐标
						#*******************************************************************
						if($pos>=0 && $pos <= 5){#序列5'和 3'末端6nt
							next;
						}elsif($pos<=$seq_len-1 && $pos >= $seq_len-6){#序列5'和 3'末端6nt
							next;
						#*******************************************************************
						}else{
							$tt=substr($rd[$num-14],$pos,1);
							$qq = substr($seq_qual,$pos,1);
							print OUT "$array0[$i]\t$array1[$i]\t$array2_g[$i]\t$array2_t[$i]\t$tt\t$seq_name\t$seq_len\t$rd[$num-10]\t$qq\n";
							#switch($tt){
							#	case ("$array2_g[$i]") { $array_g[$l]++;last;}
							#	case ("$array2_t[$i]") { $array_t[$l]++;last;}
							#	default {last;}
							#}
						}
					}
				}
			}
		}
	}
}

			

my $duration=time-$starttime;
print "time:$duration";
