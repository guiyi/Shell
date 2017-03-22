#Auth: adair.zou


if [ $# -eq 1 ]
then
 year_month=$1
else
echo "Usage: $0  DateTime"
exit 1
fi
for s in {5..5}
do

if [ "$s" -lt 10 ]
then
name=${year_month}"0"${s}
else
name=${year_month}${s}
fi
echo ${name}

mkdir -p /hadoop_tmp/adair/${name}

# Get  data

table=dw.51_log_${name}
table1=adair.51_log_${name}

echo ${table}
yourdate=`date +%Y-%m-%d-%H:%M:%S`







GetData()
{


echo "+++++++Start hive get data +++++++++"`date +%Y-%m-%d-%H:%M:%S`
#hive -e "INSERT OVERWRITE LOCAL DIRECTORY '/hadoop_tmp/adair/${name}' select ip, getfs,url,getcs,agent,channel  from ${table}  where getcs like '?area=%'  and  channel in ('5www','tjwww') and url='/default-area.php'  and bz='0';"
#hive -e "INSERT OVERWRITE LOCAL DIRECTORY '/hadoop_tmp/adair/${name}www' select ip, getfs,url,getcs,agent,channel  from ${table}  where url='/default-qz.php' or url='/default.php'  or url='/'   or url='' or url='/default-e.php' or url='/default_res.php'  or url='/default-sd.php' or url='/default-dg.php' or url='/default-mn.php' or url like '%/careerpost/jianlishuoming/%' or url='/default-gj.php' or url='/default-it.php' and  channel in ('5www','tjwww') and bz='0';"  
#hive -e "INSERT OVERWRITE LOCAL DIRECTORY '/hadoop_tmp/adair/${name}my' select ip, getfs,url,getcs,agent,channel  from ${table}  where url='/my/My_Pmc.php' or url='/51club/index.php'  and channel='5linux' and bz='0';"
#hive -e "INSERT OVERWRITE LOCAL DIRECTORY '/hadoop_tmp/adair/${name}xy' select ip, getfs,url,getcs,agent,channel  from ${table}   where url='/ebook/index.html'  or url='/default-xs.php'  and channel='xy' ;"
#hive -e "INSERT OVERWRITE LOCAL DIRECTORY '/hadoop_tmp/adair/${name}tr' select ip, getfs,url,getcs,agent,channel from ${table}  where url like '%/index.asp'  or url like '%/'   or url='/default.php'  or  url='/default-tr.php' or url='/my/My_Pmc.php' or url='/51club/index.php' and  channel='blogdata' or channel='shixi'  or channel='tr' ;"
#hive -e "INSERT OVERWRITE LOCAL DIRECTORY '/hadoop_tmp/adair/${name}bbs' select ip, getfs,url,getcs,agent,channel  from ${table}  where channel='newehireweb'   and  lower(url)='/mainlogin.aspx'   or (url='/index.php'  and channel='bbs')  ;"

hive -e "drop table ${table1};"
 
hive -e "create table ${table1} as select * from ${table} where channel in ('5www','tjwww') and bz=0;"


hive -e "select ip, getfs,url,getcs,agent,channel  from ${table1}  where   getcs like '?area=%'  and  channel in ('5www','tjwww') and url='/default-area.php'  and bz='0';" > /hadoop_tmp/adair/${name}/mid.txta

hive -e "select ip, getfs,url,getcs,agent,channel  from ${table1}  where  ( url='/default-qz.php' or url='/default.php'  or url='/'   or url='' or url='/default-e.php' or url='/default_res.php'  or url='/default-sd.php' or url='/default-dg.php' or url='/default-mn.php' or url like '%/careerpost/jianlishuoming/%' or url='/default-gj.php' or url='/default-it.php' ) and  channel in ('5www','tjwww') and bz='0';"  > /hadoop_tmp/adair/${name}/mid_a.txta
 
hive -e "select ip, getfs,url,getcs,agent,channel  from ${table}  where   (url='/my/My_Pmc.php' or url='/51club/index.php' ) and channel='5linux' and bz='0';" > /hadoop_tmp/adair/${name}/mid_my.txta

hive -e " select ip, getfs,url,getcs,agent,channel  from ${table}   where   (url='/ebook/index.html'  or url='/default-xs.php')  and channel='xy' ;" > /hadoop_tmp/adair/${name}/mid_xy.txta

hive -e " select ip, getfs,url,getcs,agent,channel  from ${table}  where   (channel='newehireweb'   and  lower(url)='/mainlogin.aspx' )  or (url='/index.php'  and channel='bbs')  ;" > /hadoop_tmp/adair/${name}/mid_bbs.txta

hive -e " select ip, getfs,url,getcs,agent,channel from ${table}  where   (url like '%/index.asp'  or url like '%/') and channel='blogdata';" > /hadoop_tmp/adair/${name}/mid_hr.txta

hive -e "select ip, getfs,url,getcs,agent,channel from ${table}  where   url='/default-tr.php' and channel='tr';" > /hadoop_tmp/adair/${name}/mid_tr.txta


 


echo "+++++++End hive get data +++++++++"`date +%Y-%m-%d-%H:%M:%S`

}



WashData()
{


# wash data  (spider,IP)
echo "+++++++Start wash data +++++++++"`date +%Y-%m-%d-%H:%M:%S`
cd /home/hadoop/adair/py/area_spider/
#cat  /hadoop_tmp/adair/${name}/mid.txta |python pageview_month.py >/hadoop_tmp/adair/${name}/mid.txt
cat  /hadoop_tmp/adair/${name}/mid.txta |python pageview_month.py  >/hadoop_tmp/adair/${name}/mid.txt
cat  /hadoop_tmp/adair/${name}/mid_a.txta |python pageview_month_notArea.py >/hadoop_tmp/adair/${name}/mid_a.txt
cat  /hadoop_tmp/adair/${name}/mid_my.txta |python pageview_month_notArea.py  >/hadoop_tmp/adair/${name}/mid_my.txt
cat  /hadoop_tmp/adair/${name}/mid_xy.txta |python pageview_month_notArea.py >/hadoop_tmp/adair/${name}/mid_xy.txt
cat  /hadoop_tmp/adair/${name}/mid_tr.txta |python pageview_month_notArea.py >/hadoop_tmp/adair/${name}/mid_tr.txt
cat  /hadoop_tmp/adair/${name}/mid_hr.txta |python pageview_month_notArea.py >/hadoop_tmp/adair/${name}/mid_hr.txt
cat  /hadoop_tmp/adair/${name}/mid_bbs.txta |python pageview_month_notArea.py >/hadoop_tmp/adair/${name}/mid_bbs.txt



#echo "area Done  "`date +%Y-%m-%d-%H:%M:%S`
#cat  /hadoop_tmp/adair/${name}www/000*|python pageview_month_notArea.py >/hadoop_tmp/adair/${name}/mid_a.txt
echo "pingdao Done  "`date +%Y-%m-%d-%H:%M:%S`
#cat  /hadoop_tmp/adair/${name}my/000*|python pageview_month_notArea.py >>/hadoop_tmp/adair/${name}/mid_my.txt
echo "my Done  "`date +%Y-%m-%d-%H:%M:%S`
#cat  /hadoop_tmp/adair/${name}xy/000*|python pageview_month_notArea.py >>/hadoop_tmp/adair/${name}/mid_xy.txt
echo "xy Done  "`date +%Y-%m-%d-%H:%M:%S`
#cat  /hadoop_tmp/adair/${name}tr/000*|python pageview_month_notArea.py >>/hadoop_tmp/adair/${name}/mid_tr.txt
echo "tr Done  "`date +%Y-%m-%d-%H:%M:%S`
#cat  /hadoop_tmp/adair/${name}bbs/0000*|python pageview_month_notArea.py >>/hadoop_tmp/adair/${name}/mid_bbs.txt
echo "bbs Done  "`date +%Y-%m-%d-%H:%M:%S`
echo "+++++++End wash data +++++++++"`date +%Y-%m-%d-%H:%M:%S`


}





PvRes()
{
# Result
# Result
echo "+++++++Start PV Result data +++++++++"`date +%Y-%m-%d-%H:%M:%S`
echo pv_res${name}.txt
echo `date +%Y-%m-%d-%H:%M:%S`
echo "www pv  ****************"${name}>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |awk -F '\\t' '{if($3=="/default.php" || $3=="/" || $3==" ") print $3}'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=beijing|?area=010000'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shanghai|?area=020000'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=guangzhou|?area=030200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shenzhen|?area=040000'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=xian|?area=200200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=chengdu|?area=090200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=wuhan|?area=180200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=hangzhou|?area=080200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=kunming|?area=250200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=nanjing|?area=070200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=jinan|?area=120200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=daqing|?area=220500'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=dalian|?area=230300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shenyang|?area=230200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=qingdao|?area=120300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=chongqing|?area=060000'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=harbin|?area=220200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=changsha|?area=190200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=hefei|?area=150200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=ningbo|?area=080300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=dongguan|?area=030800'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=changchun|?area=240200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=suzhou|?area=070300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=fuzhou|?area=110200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=zhengzhou|?area=170200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=tianjin|?area=050000'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default-mn.php'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shijiazhuang|?area=160200|?area=handan|?area=160700'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=jiujiang|?area=130300|?area=nanchang|?area=130200|?area=ganzhou|?area=130800'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=wuxi|?area=070400|?area=jiangyin|?area=070500|?area=changzhou|?area=071500'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=huizhou|?area=030400|?area=shantou|?area=030500|?area=zhuhai|?area=030600|?area=foshan|?area=030700|?area=zhongshan|?area=030300|?area=jiangmen|?area=031500|?area=zhanjiang|?area=031800|?area=zhaoqing|?area=031700|?area=qingyuan|?area=031900|?area=shunde|?area=032500'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=nanning|?area=140200|?area=liuzhou|?area=140400'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=taiyuan|?area=210200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=wenzhou|?area=080400'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=nantong|?area=070900'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=yantai|?area=120400'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=guiyang|?area=260200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=jiaxing|?area=080700|?area=huzhou|?area=080900'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=lanzhou|?area=270200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=haikou|?area=100200|?area=sanya|?area=100300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=huhhot|?area=280200|?area=baotou|?area=280400|?area=eerduosi|?area=280800'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=xianyang|?area=200300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=urumqi|?area=310200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=kunshan|?area=070600|?area=changshu|?area=070700|?area=zhangjiagang|?area=071400'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=xuzhou|?area=071100|?area=yangzhou|?area=070800|?area=zhenjiang|?area=071000'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shaoxing|?area=080500|?area=tz|?area=080800|?area=jinhua|?area=080600|?area=yiwu|?area=081400'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=langfang|?area=160300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=baoding|?area=160400|?area=tangshan|?area=160500|?area=qinhuangdao|?area=160600'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=wuhu|?area=150300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=weifang|?area=120800|?area=linyi|?area=120500|?area=weihai|?area=120600|?area=zibo|?area=120700|?area=jining|?area=120900'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=jilin|?area=240300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=mianyang|?area=090300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=luoyang|?area=170300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=yancheng|?area=071200|?area=lianyungang|?area=071300|?area=huaian|?area=071900|?area=taizhou|?area=071800'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=yichang|?area=180300|?area=xiangyang|?area=180500|?area=jingzhou|?area=180700'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=zhuzhou|?area=190300|?area=hengyang|?area=190400|?area=xiangtan|?area=190500|?area=changde|?area=190700'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=yinchuan|?area=240300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=anshan|?area=230400|?area=yingkou|?area=230500|?area=fushun|?area=230600|?area=dandong|?area=230800|?area=tieling|?area=231200'|wc -l>>pv_res${name}.txt
#IT rencai
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default-it.php'|wc -l>>pv_res${name}.txt
#gaoji lietou
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default-gj.php'|wc -l>>pv_res${name}.txt
#xiaoyuan zhaopin
cat /hadoop_tmp/adair/${name}/mid_xy.txt |grep -a 'xy' |grep -a '/default-xs.php'|wc -l>>pv_res${name}.txt
#peixun pindao
cat /hadoop_tmp/adair/${name}/mid_tr.txt |grep -a 'tr' |grep -a '/default-tr.php'|wc -l>>pv_res${name}.txt
#zhichang zixun
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default_res.php'|wc -l>>pv_res${name}.txt
#echo "My51job  ****************">>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_my.txt |grep -a '5linux' |grep -a '/my/My_Pmc.php'|grep -a 'GET'|wc -l>>pv_res${name}.txt
#echo "51job wangcai ****************">>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_bbs.txt |grep -a 'newehireweb' |grep -i '/MainLogin.aspx'|wc -l>>pv_res${name}.txt
#echo "hr shequ club  ****************">>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_hr.txt |grep -a 'blogdata' |grep -w '/index.asp'|wc -l>>pv_res${name}.txt
#echo "yingwen zhuye  ****************">>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default-e.php'|wc -l>>pv_res${name}.txt


echo "tjwww  ****************">>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |awk -F '\\t' '{if($3=="/default.php" || $3=="/" || $3==" ") print $3}'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=beijing|?area=010000'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shanghai|?area=020000'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=guangzhou|?area=030200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shenzhen|?area=040000'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=xian|?area=200200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=chengdu|?area=090200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=wuhan|?area=180200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=hangzhou|?area=080200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=kunming|?area=250200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=nanjing|?area=070200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=jinan|?area=120200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=daqing|?area=220500'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=dalian|?area=230300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shenyang|?area=230200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=qingdao|?area=120300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=chongqing|?area=060000'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=harbin|?area=220200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=changsha|?area=190200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=hefei|?area=150200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=ningbo|?area=080300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=dongguan|?area=030800'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=changchun|?area=240200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=suzhou|?area=070300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=fuzhou|?area=110200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=zhengzhou|?area=170200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=tianjin|?area=050000'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep  -a '/default-mn.php'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shijiazhuang|?area=160200|?area=handan|?area=160700'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=jiujiang|?area=130300|?area=nanchang|?area=130200|?area=ganzhou|?area=130800'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=wuxi|?area=070400|?area=jiangyin|?area=070500|?area=changzhou|?area=071500'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=huizhou|?area=030400|?area=shantou|?area=030500|?area=zhuhai|?area=030600|?area=foshan|?area=030700|?area=zhongshan|?area=030300|?area=jiangmen|?area=031500|?area=zhanjiang|?area=031800|?area=zhaoqing|?area=031700|?area=qingyuan|?area=031900|?area=shunde|?area=032500'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=nanning|?area=140200|?area=liuzhou|?area=140400'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=taiyuan|?area=210200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=wenzhou|?area=080400'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=nantong|?area=070900'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=yantai|?area=120400'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=guiyang|?area=260200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=jiaxing|?area=080700|?area=huzhou|?area=080900'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=lanzhou|?area=270200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=haikou|?area=100200|?area=sanya|?area=100300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=huhhot|?area=280200|?area=baotou|?area=280400|?area=eerduosi|?area=280800'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=xianyang|?area=200300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=urumqi|?area=310200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=kunshan|?area=070600|?area=changshu|?area=070700|?area=zhangjiagang|?area=071400'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=xuzhou|?area=071100|?area=yangzhou|?area=070800|?area=zhenjiang|?area=071000'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shaoxing|?area=080500|?area=tz|?area=080800|?area=jinhua|?area=080600|?area=yiwu|?area=081400'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=langfang|?area=160300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=baoding|?area=160400|?area=tangshan|?area=160500|?area=qinhuangdao|?area=160600'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=wuhu|?area=150300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=weifang|?area=120800|?area=linyi|?area=120500|?area=weihai|?area=120600|?area=zibo|?area=120700|?area=jining|?area=120900'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=jilin|?area=240300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=mianyang|?area=090300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=luoyang|?area=170300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww'  |grep -wE '?area=yancheng|?area=071200|?area=lianyungang|?area=071300|?area=huaian|?area=071900|?area=taizhou|?area=071800'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=yichang|?area=180300|?area=xiangyang|?area=180500|?area=jingzhou|?area=180700'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=zhuzhou|?area=190300|?area=hengyang|?area=190400|?area=xiangtan|?area=190500|?area=changde|?area=190700'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=yinchuan|?area=240300'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww'  |grep -wE '?area=anshan|?area=230400|?area=yingkou|?area=230500|?area=fushun|?area=230600|?area=dandong|?area=230800|?area=tieling|?area=231200'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep  -a '/default-it.php'|wc -l>>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep  -a '/default-gj.php'|wc -l>>pv_res${name}.txt
echo " ">>pv_res${name}.txt
echo " ">>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep  -a '/default_res.php'|wc -l>>pv_res${name}.txt
echo " ">>pv_res${name}.txt
echo " ">>pv_res${name}.txt
echo " ">>pv_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep  -a '/default-e.php'|wc -l>>pv_res${name}.txt

echo "+++++++End PV Result data +++++++++"`date +%Y-%m-%d-%H:%M:%S`
}




IpRes()
{

# Result
echo "+++++++Start IP Result data +++++++++"`date +%Y-%m-%d-%H:%M:%S`
echo ip_res${name}.txt
pwd
echo "www IP ****************"${name}>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |awk -F '\\t' '{if($3=="/default.php" || $3=="/" || $3==" ")  print $0}'|awk '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=beijing|?area=010000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shanghai|?area=020000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=guangzhou|?area=030200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shenzhen|?area=040000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=xian|?area=200200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=chengdu|?area=090200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=wuhan|?area=180200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=hangzhou|?area=080200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=kunming|?area=250200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=nanjing|?area=070200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=jinan|?area=120200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=daqing|?area=220500'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=dalian|?area=230300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shenyang|?area=230200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=qingdao|?area=120300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=chongqing|?area=060000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=harbin|?area=220200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=changsha|?area=190200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=hefei|?area=150200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=ningbo|?area=080300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=dongguan|?area=030800'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=changchun|?area=240200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=suzhou|?area=070300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=fuzhou|?area=110200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=zhengzhou|?area=170200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=tianjin|?area=050000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default-mn.php'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shijiazhuang|?area=160200|?area=handan|?area=160700'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=jiujiang|?area=130300|?area=nanchang|?area=130200|?area=ganzhou|?area=130800'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=wuxi|?area=070400|?area=jiangyin|?area=070500|?area=changzhou|?area=071500'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=huizhou|?area=030400|?area=shantou|?area=030500|?area=zhuhai|?area=030600|?area=foshan|?area=030700|?area=zhongshan|?area=030300|?area=jiangmen|?area=031500|?area=zhanjiang|?area=031800|?area=zhaoqing|?area=031700|?area=qingyuan|?area=031900|?area=shunde|?area=032500'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=nanning|?area=140200|?area=liuzhou|?area=140400'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=taiyuan|?area=210200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=wenzhou|?area=080400'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=nantong|?area=070900'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=yantai|?area=120400'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=guiyang|?area=260200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=jiaxing|?area=080700|?area=huzhou|?area=080900'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=lanzhou|?area=270200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=haikou|?area=100200|?area=sanya|?area=100300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=huhhot|?area=280200|?area=baotou|?area=280400|?area=eerduosi|?area=280800'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=xianyang|?area=200300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=urumqi|?area=310200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=kunshan|?area=070600|?area=changshu|?area=070700|?area=zhangjiagang|?area=071400'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=xuzhou|?area=071100|?area=yangzhou|?area=070800|?area=zhenjiang|?area=071000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shaoxing|?area=080500|?area=tz|?area=080800|?area=jinhua|?area=080600|?area=yiwu|?area=081400'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=langfang|?area=160300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=baoding|?area=160400|?area=tangshan|?area=160500|?area=qinhuangdao|?area=160600'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=wuhu|?area=150300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=weifang|?area=120800|?area=linyi|?area=120500|?area=weihai|?area=120600|?area=zibo|?area=120700|?area=jining|?area=120900'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=jilin|?area=240300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=mianyang|?area=090300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=luoyang|?area=170300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=yancheng|?area=071200|?area=lianyungang|?area=071300|?area=huaian|?area=071900|?area=taizhou|?area=071800'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=yichang|?area=180300|?area=xiangyang|?area=180500|?area=jingzhou|?area=180700'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=zhuzhou|?area=190300|?area=hengyang|?area=190400|?area=xiangtan|?area=190500|?area=changde|?area=190700'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=yinchuan|?area=240300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=anshan|?area=230400|?area=yingkou|?area=230500|?area=fushun|?area=230600|?area=dandong|?area=230800|?area=tieling|?area=231200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
#IT rencai
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default-it.php'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
#gaoji lietou
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default-gj.php'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
#xiaoyuan zhaopin
cat /hadoop_tmp/adair/${name}/mid_xy.txt |grep -a 'xy' |grep -a '/default-xs.php'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
#peixun pindao
cat /hadoop_tmp/adair/${name}/mid_tr.txt |grep -a 'tr' |grep -a '/default-tr.php'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
#zhichang zixun
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default_res.php'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
#echo "My51job  ****************">>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_my.txt |grep -a '5linux' |grep -a '/my/My_Pmc.php'|grep -a 'GET'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
#echo "51job wangcai ****************">>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_bbs.txt |grep -a 'newehireweb' |grep -i '/MainLogin.aspx'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
#echo "hr shequ club  ****************">>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_hr.txt |grep -a 'blogdata' |grep -w '/index.asp'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
#echo "yingwen zhuye  ****************">>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default-e.php'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt


echo "tjwww  ****************">>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |awk -F '\\t'  '{if($3=="/default.php" || $3=="/" || $3==" ")  print $0}'|awk '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=beijing|?area=010000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shanghai|?area=020000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=guangzhou|?area=030200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shenzhen|?area=040000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=xian|?area=200200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=chengdu|?area=090200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=wuhan|?area=180200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=hangzhou|?area=080200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=kunming|?area=250200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=nanjing|?area=070200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=jinan|?area=120200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=daqing|?area=220500'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=dalian|?area=230300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shenyang|?area=230200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=qingdao|?area=120300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=chongqing|?area=060000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=harbin|?area=220200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=changsha|?area=190200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=hefei|?area=150200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=ningbo|?area=080300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=dongguan|?area=030800'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=changchun|?area=240200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=suzhou|?area=070300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=fuzhou|?area=110200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=zhengzhou|?area=170200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=tianjin|?area=050000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep  -a '/default-mn.php'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shijiazhuang|?area=160200|?area=handan|?area=160700'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=jiujiang|?area=130300|?area=nanchang|?area=130200|?area=ganzhou|?area=130800'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=wuxi|?area=070400|?area=jiangyin|?area=070500|?area=changzhou|?area=071500'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=huizhou|?area=030400|?area=shantou|?area=030500|?area=zhuhai|?area=030600|?area=foshan|?area=030700|?area=zhongshan|?area=030300|?area=jiangmen|?area=031500|?area=zhanjiang|?area=031800|?area=zhaoqing|?area=031700|?area=qingyuan|?area=031900|?area=shunde|?area=032500'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=nanning|?area=140200|?area=liuzhou|?area=140400'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=taiyuan|?area=210200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=wenzhou|?area=080400'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=nantong|?area=070900'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=yantai|?area=120400'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=guiyang|?area=260200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=jiaxing|?area=080700|?area=huzhou|?area=080900'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=lanzhou|?area=270200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=haikou|?area=100200|?area=sanya|?area=100300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=huhhot|?area=280200|?area=baotou|?area=280400|?area=eerduosi|?area=280800'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=xianyang|?area=200300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=urumqi|?area=310200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=kunshan|?area=070600|?area=changshu|?area=070700|?area=zhangjiagang|?area=071400'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=xuzhou|?area=071100|?area=yangzhou|?area=070800|?area=zhenjiang|?area=071000'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shaoxing|?area=080500|?area=tz|?area=080800|?area=jinhua|?area=080600|?area=yiwu|?area=081400'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=langfang|?area=160300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=baoding|?area=160400|?area=tangshan|?area=160500|?area=qinhuangdao|?area=160600'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=wuhu|?area=150300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=weifang|?area=120800|?area=linyi|?area=120500|?area=weihai|?area=120600|?area=zibo|?area=120700|?area=jining|?area=120900'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=jilin|?area=240300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=mianyang|?area=090300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=luoyang|?area=170300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww'  |grep -wE '?area=yancheng|?area=071200|?area=lianyungang|?area=071300|?area=huaian|?area=071900|?area=taizhou|?area=071800'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=yichang|?area=180300|?area=xiangyang|?area=180500|?area=jingzhou|?area=180700'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=zhuzhou|?area=190300|?area=hengyang|?area=190400|?area=xiangtan|?area=190500|?area=changde|?area=190700'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=yinchuan|?area=240300'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww'  |grep -wE '?area=anshan|?area=230400|?area=yingkou|?area=230500|?area=fushun|?area=230600|?area=dandong|?area=230800|?area=tieling|?area=231200'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep  -a '/default-it.php'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep  -a '/default-gj.php'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
echo " ">>ip_res${name}.txt
echo " ">>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep  -a '/default_res.php'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt
echo " ">>ip_res${name}.txt
echo " ">>ip_res${name}.txt
echo " ">>ip_res${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep  -a '/default-e.php'|awk -F '\\t' '{print $1}'|sort|uniq -c|wc -l>>ip_res${name}.txt

echo "+++++++End PV Result data +++++++++"`date +%Y-%m-%d-%H:%M:%S`

}



IpTopRes()
{

right_name=${name:0:4}'-'${name:4:2}'-'${name:6:2}
echo ${right_name}

cd /home/hadoop/adair/py/area_spider/
echo "+++++++Start PV Result data +++++++++"`date +%Y-%m-%d-%H:%M:%S`
echo ip_top10${name}.txt
echo `date +%Y-%m-%d-%H:%M:%S`
#echo "www IP TOP 10  ****************"${name}>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |awk -F '\\t' '{if($3=="/default.php" || $3=="/" || $3==" ")  print $0}'|awk '{print $1,"5www","/default.php|/| ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=beijing|?area=010000'|awk -F '\\t' '{print $1,$6,"?area=beijing|?area=010000 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shanghai|?area=020000'|awk -F '\\t' '{print $1,$6,"?area=shanghai|?area=020000 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=guangzhou|?area=030200'|awk -F '\\t' '{print $1,$6,"?area=guangzhou|?area=030200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shenzhen|?area=040000'|awk -F '\\t' '{print $1,$6,"?area=shenzhen|?area=040000 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=xian|?area=200200'|awk -F '\\t' '{print $1,$6,"?area=xian|?area=200200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=chengdu|?area=090200'|awk -F '\\t' '{print $1,$6,"?area=chengdu|?area=090200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=wuhan|?area=180200'|awk -F '\\t' '{print $1,$6,"?area=wuhan|?area=180200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=hangzhou|?area=080200'|awk -F '\\t' '{print $1,$6,"?area=hangzhou|?area=080200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=kunming|?area=250200'|awk -F '\\t' '{print $1,$6,"?area=kunming|?area=250200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=nanjing|?area=070200'|awk -F '\\t' '{print $1,$6,"?area=nanjing|?area=070200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=jinan|?area=120200'|awk -F '\\t' '{print $1,$6,"?area=jinan|?area=120200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=daqing|?area=220500'|awk -F '\\t' '{print $1,$6,"?area=daqing|?area=220500 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=dalian|?area=230300'|awk -F '\\t' '{print $1,$6,"?area=dalian|?area=230300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shenyang|?area=230200'|awk -F '\\t' '{print $1,$6,"?area=shenyang|?area=230200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=qingdao|?area=120300'|awk -F '\\t' '{print $1,$6,"?area=qingdao|?area=120300",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=chongqing|?area=060000'|awk -F '\\t' '{print $1,$6,"?area=chongqing|?area=060000 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=harbin|?area=220200'|awk -F '\\t' '{print $1,$6,"?area=harbin|?area=220200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=changsha|?area=190200'|awk -F '\\t' '{print $1,$6,"?area=changsha|?area=190200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=hefei|?area=150200'|awk -F '\\t' '{print $1,$6,"?area=hefei|?area=150200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=ningbo|?area=080300'|awk -F '\\t' '{print $1,$6,"?area=ningbo|?area=080300",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=dongguan|?area=030800'|awk -F '\\t' '{print $1,$6,"?area=dongguan|?area=030800 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=changchun|?area=240200'|awk -F '\\t' '{print $1,$6,"?area=changchun|?area=240200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=suzhou|?area=070300'|awk -F '\\t' '{print $1,$6,"?area=suzhou|?area=070300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=fuzhou|?area=110200'|awk -F '\\t' '{print $1,$6,"?area=fuzhou|?area=110200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=zhengzhou|?area=170200'|awk -F '\\t' '{print $1,$6,"?area=zhengzhou|?area=170200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=tianjin|?area=050000'|awk -F '\\t' '{print $1,$6,"?area=tianjin|?area=050000 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default-mn.php'|awk -F '\\t' '{print $1,"5www","/default-mn.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shijiazhuang|?area=160200|?area=handan|?area=160700'|awk -F '\\t' '{print $1,$6,"?area=shijiazhuang|?area=160200|?area=handan|?area=160700 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=jiujiang|?area=130300|?area=nanchang|?area=130200|?area=ganzhou|?area=130800'|awk -F '\\t' '{print $1,$6,"?area=jiujiang|?area=130300|?area=nanchang|?area=130200|?area=ganzhou|?area=130800 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=wuxi|?area=070400|?area=jiangyin|?area=070500|?area=changzhou|?area=071500'|awk -F '\\t' '{print $1,$6,"?area=wuxi|?area=070400|?area=jiangyin|?area=070500|?area=changzhou|?area=071500 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=huizhou|?area=030400|?area=shantou|?area=030500|?area=zhuhai|?area=030600|?area=foshan|?area=030700|?area=zhongshan|?area=030300|?area=jiangmen|?area=031500|?area=zhanjiang|?area=031800|?area=zhaoqing|?area=031700|?area=qingyuan|?area=031900|?area=shunde|?area=032500'|awk -F '\\t' '{print $1,$6,"zhusanjiao ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=nanning|?area=140200|?area=liuzhou|?area=140400'|awk -F '\\t' '{print $1,$6,"?area=nanning|?area=140200|?area=liuzhou|?area=140400 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=taiyuan|?area=210200'|awk -F '\\t' '{print $1,$6,"?area=taiyuan|?area=210200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=wenzhou|?area=080400'|awk -F '\\t' '{print $1,$6,"?area=wenzhou|?area=080400 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=nantong|?area=070900'|awk -F '\\t' '{print $1,$6,"?area=nantong|?area=070900 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=yantai|?area=120400'|awk -F '\\t' '{print $1,$6,"?area=yantai|?area=120400 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=guiyang|?area=260200'|awk -F '\\t' '{print $1,$6,"?area=guiyang|?area=260200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=jiaxing|?area=080700|?area=huzhou|?area=080900'|awk -F '\\t' '{print $1,$6,"?area=jiaxing|?area=080700|?area=huzhou|?area=080900 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=lanzhou|?area=270200'|awk -F '\\t' '{print $1,$6,"?area=lanzhou|?area=270200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=haikou|?area=100200|?area=sanya|?area=100300'|awk -F '\\t' '{print $1,$6,"?area=haikou|?area=100200|?area=sanya|?area=100300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=huhhot|?area=280200|?area=baotou|?area=280400|?area=eerduosi|?area=280800'|awk -F '\\t' '{print $1,$6,"?area=huhhot|?area=280200|?area=baotou|?area=280400|?area=eerduosi|?area=280800 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=xianyang|?area=200300'|awk -F '\\t' '{print $1,$6,"?area=xianyang|?area=200300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=urumqi|?area=310200'|awk -F '\\t' '{print $1,$6,"?area=urumqi|?area=310200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=kunshan|?area=070600|?area=changshu|?area=070700|?area=zhangjiagang|?area=071400'|awk -F '\\t' '{print $1,$6,"?area=kunshan|?area=070600|?area=changshu|?area=070700|?area=zhangjiagang|?area=071400 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=xuzhou|?area=071100|?area=yangzhou|?area=070800|?area=zhenjiang|?area=071000'|awk -F '\\t' '{print $1,$6,"?area=xuzhou|?area=071100|?area=yangzhou|?area=070800|?area=zhenjiang|?area=071000 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=shaoxing|?area=080500|?area=tz|?area=080800|?area=jinhua|?area=080600|?area=yiwu|?area=081400'|awk -F '\\t' '{print $1,$6,"?area=shaoxing|?area=080500|?area=tz|?area=080800|?area=jinhua|?area=080600|?area=yiwu|?area=081400 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=langfang|?area=160300'|awk -F '\\t' '{print $1,$6,"?area=langfang|?area=160300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=baoding|?area=160400|?area=tangshan|?area=160500|?area=qinhuangdao|?area=160600'|awk -F '\\t' '{print $1,$6,"?area=baoding|?area=160400|?area=tangshan|?area=160500|?area=qinhuangdao|?area=160600 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=wuhu|?area=150300'|awk -F '\\t' '{print $1,$6,"?area=wuhu|?area=150300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=weifang|?area=120800|?area=linyi|?area=120500|?area=weihai|?area=120600|?area=zibo|?area=120700|?area=jining|?area=120900'|awk -F '\\t' '{print $1,$6,"?area=weifang|?area=120800|?area=linyi|?area=120500|?area=weihai|?area=120600|?area=zibo|?area=120700|?area=jining|?area=120900 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=jilin|?area=240300'|awk -F '\\t' '{print $1,$6,"?area=jilin|?area=240300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=mianyang|?area=090300'|awk -F '\\t' '{print $1,$6,"?area=mianyang|?area=090300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=luoyang|?area=170300'|awk -F '\\t' '{print $1,$6,"?area=luoyang|?area=170300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=yancheng|?area=071200|?area=lianyungang|?area=071300|?area=huaian|?area=071900|?area=taizhou|?area=071800'|awk -F '\\t' '{print $1,$6,"?area=yancheng|?area=071200|?area=lianyungang|?area=071300|?area=huaian|?area=071900|?area=taizhou|?area=071800 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=yichang|?area=180300|?area=xiangyang|?area=180500|?area=jingzhou|?area=180700'|awk -F '\\t' '{print $1,$6,"?area=yichang|?area=180300|?area=xiangyang|?area=180500|?area=jingzhou|?area=180700 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=zhuzhou|?area=190300|?area=hengyang|?area=190400|?area=xiangtan|?area=190500|?area=changde|?area=190700'|awk -F '\\t' '{print $1,$6,"?area=zhuzhou|?area=190300|?area=hengyang|?area=190400|?area=xiangtan|?area=190500|?area=changde|?area=190700 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=yinchuan|?area=240300'|awk -F '\\t' '{print $1,$6,"?area=yinchuan|?area=240300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a '5www' |grep -wE '?area=anshan|?area=230400|?area=yingkou|?area=230500|?area=fushun|?area=230600|?area=dandong|?area=230800|?area=tieling|?area=231200'|awk -F '\\t' '{print $1,$6,"?area=anshan|?area=230400|?area=yingkou|?area=230500|?area=fushun|?area=230600|?area=dandong|?area=230800|?area=tieling|?area=231200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#IT rencai
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default-it.php'|awk -F '\\t' '{print $1,"5www","/default-it.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#gaoji lietou
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default-gj.php'|awk -F '\\t' '{print $1,"5www","/default-gj.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#xiaoyuan zhaopin
cat /hadoop_tmp/adair/${name}/mid_xy.txt |grep -a 'xy' |grep -a '/default-xs.php'|awk -F '\\t' '{print $1,"xy","/default-xs.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#peixun pindao
cat /hadoop_tmp/adair/${name}/mid_tr.txt |grep -a 'tr' |grep -a '/default-tr.php'|awk -F '\\t' '{print $1,"tr","/default-tr.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#zhichang zixun
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default_res.php'|awk -F '\\t' '{print $1,"5www","/default_res.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#echo "My51job  ****************">>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid_my.txt |grep -a '5linux' |grep -a '/my/My_Pmc.php'|grep -a 'GET'|awk -F '\\t' '{print $1,"5linux","/my/My_Pmc.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#echo "51job wangcai ****************">>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid_bbs.txt |grep -a 'newehireweb' |grep -a '/MainLogin.aspx'|awk -F '\\t' '{print $1,"newehireweb","/MainLogin.aspx ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#echo "hr shequ club  ****************">>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid_hr.txt |grep -a 'blogdata' |grep -w '/index.asp'|awk -F '\\t' '{print $1,"blogdata","/index.asp ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#echo "yingwen zhuye  ****************">>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a '5www' |grep -a '/default-e.php'|awk -F '\\t' '{print $1,"5www","/default-e.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#echo "tjwww  ****************">>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |awk -F '\\t' '{if($3=="/default.php" || $3=="/" || $3==" ")  print $0}'|awk '{print $1,"5www","/default.php|/| ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=beijing|?area=010000'|awk -F '\\t' '{print $1,$6,"?area=beijing|?area=010000 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shanghai|?area=020000'|awk -F '\\t' '{print $1,$6,"?area=shanghai|?area=020000 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=guangzhou|?area=030200'|awk -F '\\t' '{print $1,$6,"?area=guangzhou|?area=030200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shenzhen|?area=040000'|awk -F '\\t' '{print $1,$6,"?area=shenzhen|?area=040000 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=xian|?area=200200'|awk -F '\\t' '{print $1,$6,"?area=xian|?area=200200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=chengdu|?area=090200'|awk -F '\\t' '{print $1,$6,"?area=chengdu|?area=090200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=wuhan|?area=180200'|awk -F '\\t' '{print $1,$6,"?area=chengdu|?area=090200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=hangzhou|?area=080200'|awk -F '\\t' '{print $1,$6,"?area=hangzhou|?area=080200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=kunming|?area=250200'|awk -F '\\t' '{print $1,$6,"?area=kunming|?area=250200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=nanjing|?area=070200'|awk -F '\\t' '{print $1,$6,"?area=nanjing|?area=070200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=jinan|?area=120200'|awk -F '\\t' '{print $1,$6,"?area=jinan|?area=120200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=daqing|?area=220500'|awk -F '\\t' '{print $1,$6,"?area=daqing|?area=220500 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=dalian|?area=230300'|awk -F '\\t' '{print $1,$6,"?area=dalian|?area=230300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shenyang|?area=230200'|awk -F '\\t' '{print $1,$6,"?area=shenyang|?area=230200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=qingdao|?area=120300'|awk -F '\\t' '{print $1,$6,"?area=qingdao|?area=120300",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=chongqing|?area=060000'|awk -F '\\t' '{print $1,$6,"?area=chongqing|?area=060000 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=harbin|?area=220200'|awk -F '\\t' '{print $1,$6,"?area=harbin|?area=220200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=changsha|?area=190200'|awk -F '\\t' '{print $1,$6,"?area=changsha|?area=190200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=hefei|?area=150200'|awk -F '\\t' '{print $1,$6,"?area=hefei|?area=150200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=ningbo|?area=080300'|awk -F '\\t' '{print $1,$6,"?area=ningbo|?area=080300",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=dongguan|?area=030800'|awk -F '\\t' '{print $1,$6,"?area=dongguan|?area=030800 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=changchun|?area=240200'|awk -F '\\t' '{print $1,$6,"?area=changchun|?area=240200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=suzhou|?area=070300'|awk -F '\\t' '{print $1,$6,"?area=suzhou|?area=070300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=fuzhou|?area=110200'|awk -F '\\t' '{print $1,$6,"?area=fuzhou|?area=110200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=zhengzhou|?area=170200'|awk -F '\\t' '{print $1,$6,"?area=zhengzhou|?area=170200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=tianjin|?area=050000'|awk -F '\\t' '{print $1,$6,"?area=tianjin|?area=050000 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep -a '/default-mn.php'|awk -F '\\t' '{print $1,"tjwww","/default-mn.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shijiazhuang|?area=160200|?area=handan|?area=160700'|awk -F '\\t' '{print $1,$6,"?area=shijiazhuang|?area=160200|?area=handan|?area=160700 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=jiujiang|?area=130300|?area=nanchang|?area=130200|?area=ganzhou|?area=130800'|awk -F '\\t' '{print $1,$6,"?area=jiujiang|?area=130300|?area=nanchang|?area=130200|?area=ganzhou|?area=130800 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=wuxi|?area=070400|?area=jiangyin|?area=070500|?area=changzhou|?area=071500'|awk -F '\\t' '{print $1,$6,"?area=wuxi|?area=070400|?area=jiangyin|?area=070500|?area=changzhou|?area=071500 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=huizhou|?area=030400|?area=shantou|?area=030500|?area=zhuhai|?area=030600|?area=foshan|?area=030700|?area=zhongshan|?area=030300|?area=jiangmen|?area=031500|?area=zhanjiang|?area=031800|?area=zhaoqing|?area=031700|?area=qingyuan|?area=031900|?area=shunde|?area=032500'|awk -F '\\t' '{print $1,$6,"zhusanjiao ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=nanning|?area=140200|?area=liuzhou|?area=140400'|awk -F '\\t' '{print $1,$6,"?area=nanning|?area=140200|?area=liuzhou|?area=140400 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=taiyuan|?area=210200'|awk -F '\\t' '{print $1,$6,"?area=taiyuan|?area=210200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=wenzhou|?area=080400'|awk -F '\\t' '{print $1,$6,"?area=wenzhou|?area=080400 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=nantong|?area=070900'|awk -F '\\t' '{print $1,$6,"?area=nantong|?area=070900 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=yantai|?area=120400'|awk -F '\\t' '{print $1,$6,"?area=yantai|?area=120400 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=guiyang|?area=260200'|awk -F '\\t' '{print $1,$6,"?area=guiyang|?area=260200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=jiaxing|?area=080700|?area=huzhou|?area=080900'|awk -F '\\t' '{print $1,$6,"?area=jiaxing|?area=080700|?area=huzhou|?area=080900 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=lanzhou|?area=270200'|awk -F '\\t' '{print $1,$6,"?area=lanzhou|?area=270200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=haikou|?area=100200|?area=sanya|?area=100300'|awk -F '\\t' '{print $1,$6,"?area=haikou|?area=100200|?area=sanya|?area=100300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=huhhot|?area=280200|?area=baotou|?area=280400|?area=eerduosi|?area=280800'|awk -F '\\t' '{print $1,$6,"?area=huhhot|?area=280200|?area=baotou|?area=280400|?area=eerduosi|?area=280800 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=xianyang|?area=200300'|awk -F '\\t' '{print $1,$6,"?area=xianyang|?area=200300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=urumqi|?area=310200'|awk -F '\\t' '{print $1,$6,"?area=urumqi|?area=310200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=kunshan|?area=070600|?area=changshu|?area=070700|?area=zhangjiagang|?area=071400'|awk -F '\\t' '{print $1,$6,"?area=kunshan|?area=070600|?area=changshu|?area=070700|?area=zhangjiagang|?area=071400 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=xuzhou|?area=071100|?area=yangzhou|?area=070800|?area=zhenjiang|?area=071000'|awk -F '\\t' '{print $1,$6,"?area=xuzhou|?area=071100|?area=yangzhou|?area=070800|?area=zhenjiang|?area=071000 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=shaoxing|?area=080500|?area=tz|?area=080800|?area=jinhua|?area=080600|?area=yiwu|?area=081400'|awk -F '\\t' '{print $1,$6,"?area=shaoxing|?area=080500|?area=tz|?area=080800|?area=jinhua|?area=080600|?area=yiwu|?area=081400 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=langfang|?area=160300'|awk -F '\\t' '{print $1,$6,"?area=langfang|?area=160300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=baoding|?area=160400|?area=tangshan|?area=160500|?area=qinhuangdao|?area=160600'|awk -F '\\t' '{print $1,$6,"?area=baoding|?area=160400|?area=tangshan|?area=160500|?area=qinhuangdao|?area=160600 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=wuhu|?area=150300'|awk -F '\\t' '{print $1,$6,"?area=wuhu|?area=150300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=weifang|?area=120800|?area=linyi|?area=120500|?area=weihai|?area=120600|?area=zibo|?area=120700|?area=jining|?area=120900'|awk -F '\\t' '{print $1,$6,"?area=weifang|?area=120800|?area=linyi|?area=120500|?area=weihai|?area=120600|?area=zibo|?area=120700|?area=jining|?area=120900 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=jilin|?area=240300'|awk -F '\\t' '{print $1,$6,"?area=jilin|?area=240300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=mianyang|?area=090300'|awk -F '\\t' '{print $1,$6,"?area=mianyang|?area=090300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=luoyang|?area=170300'|awk -F '\\t' '{print $1,$6,"?area=luoyang|?area=170300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=yancheng|?area=071200|?area=lianyungang|?area=071300|?area=huaian|?area=071900|?area=taizhou|?area=071800'|awk -F '\\t' '{print $1,$6,"?area=yancheng|?area=071200|?area=lianyungang|?area=071300|?area=huaian|?area=071900|?area=taizhou|?area=071800 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=yichang|?area=180300|?area=xiangyang|?area=180500|?area=jingzhou|?area=180700'|awk -F '\\t' '{print $1,$6,"?area=yichang|?area=180300|?area=xiangyang|?area=180500|?area=jingzhou|?area=180700 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=zhuzhou|?area=190300|?area=hengyang|?area=190400|?area=xiangtan|?area=190500|?area=changde|?area=190700'|awk -F '\\t' '{print $1,$6,"?area=zhuzhou|?area=190300|?area=hengyang|?area=190400|?area=xiangtan|?area=190500|?area=changde|?area=190700 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=yinchuan|?area=240300'|awk -F '\\t' '{print $1,$6,"?area=yinchuan|?area=240300 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid.txt |grep -a 'tjwww' |grep -wE '?area=anshan|?area=230400|?area=yingkou|?area=230500|?area=fushun|?area=230600|?area=dandong|?area=230800|?area=tieling|?area=231200'|awk -F '\\t' '{print $1,$6,"?area=anshan|?area=230400|?area=yingkou|?area=230500|?area=fushun|?area=230600|?area=dandong|?area=230800|?area=tieling|?area=231200 ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#IT rencai
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep -a '/default-it.php'|awk -F '\\t' '{print $1,"tjwww","/default-it.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#gaoji lietou
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep -a '/default-gj.php'|awk -F '\\t' '{print $1,"tjwww","/default-gj.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
#xiaoyuan zhaopin
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep -a '/default_res.php'|awk -F '\\t' '{print $1,"tjwww","/default_res.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt
cat /hadoop_tmp/adair/${name}/mid_a.txt |grep -a 'tjwww' |grep -a '/default-e.php'|awk -F '\\t' '{print $1,"tjwww","/default-e.php ",'${name:0:4}'"-"'${name:4:2}'"-"'${name:6:2}' }' |sort|uniq -c|sort -k1 -n -r|head|awk '{print $1,$2,$3,$4,$5}'>>ip_top10${name}.txt



echo "+++++++End IP TOP 10 Result data +++++++++"`date +%Y-%m-%d-%H:%M:%S`
}



GetData
WashData
PvRes
IpRes
IpTopRes



hive -e "drop table ${table1};"





#rm file
#rm -rf  /hadoop_tmp/adair/${name}*

#rm -rf  /hadoop_tmp/adair/${name}/000*
#rm -rf  /hadoop_tmp/adair/${name}www
rm -rf /hadoop_tmp/adair/${name}my
rm -rf /hadoop_tmp/adair/${name}xy
rm -rf /hadoop_tmp/adair/${name}tr
rm -rf /hadoop_tmp/adair/${name}hr
rm -rf /hadoop_tmp/adair/${name}bbs






done


