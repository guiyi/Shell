zcat   5www1_www.tgz   |grep -a "default-e.php" |awk '{print $4}'|wc -l

zcat   5www1_www.tgz   |awk '{++S[$4]} END {for(a in S) print a, S[a]}'

zcat   5www1_www.tgz  |grep -a "default-e.php" |awk '{++S[$NF]} END {for(a in S) print a, S[a]}'

zcat   5www1_www.tgz  |grep -a "default-e.php" |awk '{++S[$4]} END {for(a in S) print a, S[a]}'

********************* 2014-08-07 ***************************************************************************************************************************

cat mid.txt |grep -a '5www' |grep -wE '?area=beijing|?area=010000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l
cat mid.txt |grep -a '5www' |grep -wE '?area=shanghai|?area=020000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l
cat mid.txt |grep -a '5www' |grep -wE '?area=guangzhou|?area=030200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l
cat mid.txt |grep -a '5www' |grep -wE '?area=shenzhen|?area=040000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l

cat mid.txt |grep -a 'tjwww' |grep -wE '?area=beijing|?area=010000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l
cat mid.txt |grep -a 'tjwww' |grep -wE '?area=shanghai|?area=020000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l
cat mid.txt |grep -a 'tjwww' |grep -wE '?area=guangzhou|?area=030200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l
cat mid.txt |grep -a 'tjwww' |grep -wE '?area=shenzhen|?area=040000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l




cat  201406*/mid*.txt >201406.txt
cat  201407*/mid*.txt >201407.txt

cat /hadoop_tmp/adair/201406.txt | grep -a '5www' | awk '{if($4=="?area=beijing" || $4=="?area=010000" print $0}'|awk   '{print $1}'|sort|uniq -c|wc -l

cat /hadoop_tmp/adair/201406.txt |grep -a '5www' |awk  '{if($4=="?area=beijing" || $4=="?area=010000")  print $1}'|sort|uniq -c|wc -l
cat /hadoop_tmp/adair/201406.txt |grep -a '5www' |awk  '{if($4=="?area=shanghai" || $4=="?area=020000")  print $0}'|awk  '{print $1}'|sort|uniq -c|wc -l
cat /hadoop_tmp/adair/201406.txt |grep -a 'tjwww' |awk  '{if($4=="?area=shanghai" || $4=="?area=020000")  print $0}'|awk  '{print $1}'|sort|uniq -c|wc -l






60 = "compatible; Indy Library"



cat /hadoop_tmp/adair/20140601/mid_a.txt |grep -a '5www' |awk -F '\\t' '{if($3=="/default.php" || $3=="/" || $3==" ")  print $0}'|awk '{print $1}'|sort|uniq -c|wc -l




select count(1) from 51_log_20140601 where    channel='5www'  and url='/default.php'  or url='/'   or url='' ; 


INSERT OVERWRITE LOCAL DIRECTORY '/hadoop_tmp/adair/nanjing' select ip, getfs,url,getcs,agent,channel  from 51_log_20140601 where    channel='5www'  and url='/default.php'  or url='/'   or url='' ; 




grep -a 'newehireweb' |grep -a '/MainLogin.aspx'|wc -l
cat /hadoop_tmp/adair/${name}/mid_bbs.txt |grep -a 'newehireweb' |grep -a '/MainLogin.aspx'|wc -l>>pv_res${name}.txt

cat /hadoop_tmp/adair/20140603/mid_bbs.txt |grep -a 'newehireweb' |grep -a '/MainLogin.aspx'|wc -l>>pv_res06${name}.txt
cat /hadoop_tmp/adair/20140601/mid_a.txt |grep -a '5www' |awk -F '\\t' '{if($3=="/default.php" || $3=="/" || $3==" ") print $3}'|wc -l


select ip, getfs,url,getcs,agent,channel  from  51_log_20140601  where channel='newehireweb'   and url='/MainLogin.aspx' or (url='/index.php'  and channel='bbs') limit 100




INSERT OVERWRITE LOCAL DIRECTORY '/hadoop_tmp/adair/20140630bbs' select ip, getfs,url,getcs,agent,channel  from 51_log_20140630  where channel='newehireweb'   and url='/MainLogin.aspx'  ;

cat  /hadoop_tmp/adair/20140630bbs/0000*|python pageview_month_notArea.py >>/hadoop_tmp/adair/20140630bbs/mid_bbs.txt
cat /hadoop_tmp/adair/20140630bbs/mid_bbs.txt |grep -a 'newehireweb' |grep -a '/MainLogin.aspx'|wc -l




 cat  mid.txt | grep -a 'tjwww' |grep -wE '?area=yantai|?area=120400' |   awk -F'\\t' '{print $1}'|sort|uniq -c|sort -k1 -n -r|more


 cat  mid_a.txt |grep -a '5www' |awk -F '\\t' '{if($3=="/default.php" || $3=="/" || $3==" ") print $1}' |sort|uniq -c|sort -k1 -n -r|more


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
