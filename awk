zcat   5www1_www.tgz   |grep -a "default-e.php" |awk '{print $4}'|wc -l

zcat   5www1_www.tgz   |awk '{++S[$4]} END {for(a in S) print a, S[a]}'

zcat   5www1_www.tgz  |grep -a "default-e.php" |awk '{++S[$NF]} END {for(a in S) print a, S[a]}'

zcat   5www1_www.tgz  |grep -a "default-e.php" |awk '{++S[$4]} END {for(a in S) print a, S[a]}'



zcat   5www1_www.tgz  |awk 'BEGIN{info = "default-e.php";split(info,tA," ");for(k in tA){print k,tA[k];}}'

流程：
zcat   5www*_www.tgz  |awk -F'\032' '{if($5=="/default-e.php")++S[$1]} END {for(a in S) print a, S[a]}' >/exports/home/zouhd/BI_job_log/en.txt

awk -F '\032' '{++S[$1,$5,$11]} END {for(a in S) print a, S[a]}' 5www10407.txt 
awk -F '\032' '{if($5=="/ex/page_view.php/adid=14088465")++S[$1,$5]} END {for(a in S) print a, S[a]}' 5www10407.txt 

这里
bzcat 5www120130407.tar.bz2|awk -F'\032' '{if($5=="/default-e.php")++S[$1,$5,$11]} END {for(a in S) print a, S[a]}' >/exports/home/zouhd/BI_job_log/aen.txt

bzcat     5www*20130407.tar.bz2 |awk -F'\032' '{if($5=="default-e.php")++S[$1,$5,$11]} END {for(a in S) print a, S[a]}'>/exports/home/zouhd/BI_job_log/default-e.php.20130407.txt

bzcat 5www*20130407.tar.bz2|awk -F'\032' '{if($5=="/default-e.php")++S[$1]} END {for(a in S) print a, S[a]}' >/exports/home/zouhd/BI_job_log/en.txt



zcat   5www6_www.tgz  |grep -a "default-e.php" |awk '{++S[$1]} END {for(a in S) print a, S[a]}'>>/exports/home/zouhd/BI_job_log/en.txt

bzcat 5www120130407.tar.bz2|grep -a "default-e.php" |awk '{++S[$1]} END {for(a in S) print a, S[a]}'>>/exports/home/zouhd/BI_job_log/en.txt


sort -k 1 -g -r /exports/home/zouhd/BI_job_log/en.txt > /exports/home/zouhd/BI_job_log/en.jiang.txt
head /exports/home/zouhd/BI_job_log/en.jiang.txt 

awk '{a[$1]+=$2}END{for (i in a){print i,a[ i ]}}' en.jiang.txt 

awk '{a[$1]+=$4}END{for (i in a){print i,a[ i ]}}' aen.txt


awk '{a[$2]+=$1}END{for (i in a){print i,a[ i ]}}' aen.txt

sort –k1nr  aen.txt.add  >aen.txt.sort


bzcat     5www*20130407.tar.bz2 |awk -F'\032' '{if($5=="/default-e.php")++S[$1,$9,$10,$11]} END {for(a in S) print  a,S[a]}'>/exports/home/zouhd/BI_job_log//default-e.php.20130407.txt

awk '{a[$1]+=$4}END{for (i in a){print i,a[ i ]}}'/default-e.php.20130407.txt >/exports/home/zouhd/BI_job_log//default-e.php.20130407.txtadd

sort -k1nr /default-e.php.20130407.txtadd >/exports/home/zouhd/BI_job_log//default-e.php.20130407.txtaddsort

bzcat     5www*20130407.tar.bz2 |awk -F'\032' '{if($5=="/default-e.php")++S[$1,$9,$10,$11]} END {for(a in S) print  a,S[a]}'>/exports/home/zouhd/BI_job_log/default-e.php.20130407.txt
awk '{a[$1]+=$2}END{for (i in a){print i,a[ i ]}}'default-e.php.20130407.txt >/exports/home/zouhd/BI_job_log/default-e.php.20130407.txtadd
sort -k1nr default-e.php.20130407.txtadd >/exports/home/zouhd/BI_job_log/default-e.php.20130407.txtaddsort



二.实用的日志分析脚本
了解日志的各种定义后,这里分享一下从网上淘来的一些对日志分析的脚本

1.查看apache的进程数
ps -aux | grep httpd | wc -l

2.分析日志查看当天的ip连接数
cat default-access_log | grep "10/Dec/2010" | awk '{print $2}' | sort | uniq -c | sort -nr

3.查看指定的ip在当天究竟访问了什么url
cat default-access_log | grep "10/Dec/2010" | grep "218.19.140.242" | awk '{print $7}' | sort | uniq -c | sort -nr

4.查看当天访问排行前10的url
cat default-access_log | grep "10/Dec/2010" | awk '{print $7}' | sort | uniq -c | sort -nr | head -n 10

5.看到指定的ip究竟干了什么
cat default-access_log | grep 218.19.140.242 | awk '{print $1"\t"$8}' | sort | uniq -c | sort -nr | less

6.查看访问次数最多的几个分钟(找到热点)
awk '{print $4}' default-access_log |cut -c 14-18|sort|uniq -c|sort -nr|head
