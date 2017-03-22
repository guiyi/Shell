#Date: 2014-07-10
#Auth: adair.zou


if [ $# -eq 1 ]
then
 name=$1
 ss='_nospider'


#table=dw.51_log_${name}
table=dw.51_log_${name}_${ss}
echo ${table}


echo "beijing 0100 ****************">page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%beijing%' or  getcs like '?area=0100' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%beijing%' or  getcs like '?area=0100' ">>page_view_${name}.txt

echo "Shanghai 0200 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%shanghai%' or  getcs like '?area=0200' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%shanghai%' or  getcs like '?area=0200' ">>page_view_${name}.txt


echo "guangzhou 0302 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%guangzhou%' or  getcs like '?area=0302' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%guangzhou%' or  getcs like '?area=0302' ">>page_view_${name}.txt

echo "shenzhen 0400 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%shenzhen%' or  getcs like '?area=0400' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%shenzhen%' or  getcs like '?area=0400' ">>page_view_${name}.txt

echo "xian 2002 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%xian%' or  getcs like '?area=2002' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%xian%' or  getcs like '?area=2002' ">>page_view_${name}.txt

echo "chengdu 0902 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%chengdu%' or  getcs like '?area=0902' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%chengdu%' or  getcs like '?area=0902' ">>page_view_${name}.txt

echo "wuhan 1802 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%wuhan%' or  getcs like '?area=1802' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%wuhan%' or  getcs like '?area=1802' ">>page_view_${name}.txt


echo "hangzhou 0802 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%hangzhou%' or  getcs like '?area=0802' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%hangzhou%' or  getcs like '?area=0802' ">>page_view_${name}.txt

echo "kunming 2502 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%kunming%' or  getcs like '?area=2502' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%kunming%' or  getcs like '?area=2502' ">>page_view_${name}.txt

echo "nanjing 0702 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%nanjing%' or  getcs like '?area=0702' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%nanjing%' or  getcs like '?area=0702' ">>page_view_${name}.txt

echo "jinan 1202 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%jinan%' or  getcs like '?area=1202' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%jinan%' or  getcs like '?area=1202' ">>page_view_${name}.txt


echo "dalian 2303 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%dalian%' or  getcs like '?area=2303' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%dalian%' or  getcs like '?area=2303' ">>page_view_${name}.txt


echo "shenyang 2302 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%shenyang%' or  getcs like '?area=2302' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%shenyang%' or  getcs like '?area=2302' ">>page_view_${name}.txt


echo "qingdao 1203 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%qingdao%' or  getcs like '?area=1203' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%qingdao%' or  getcs like '?area=1203' ">>page_view_${name}.txt

echo "chongqing 0600 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%chongqing%' or  getcs like '?area=0600' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%chongqing%' or  getcs like '?area=0600' ">>page_view_${name}.txt


echo "haerbin harbin 2202 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%harbin%' or  getcs like '?area=2202' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%harbin%' or  getcs like '?area=2202' ">>page_view_${name}.txt


echo "changsha 1902 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%changsha%' or  getcs like '?area=1902' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%changsha%' or  getcs like '?area=1902' ">>page_view_${name}.txt


echo "hefei 1502 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%hefei%' or  getcs like '?area=1502' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%hefei%' or  getcs like '?area=1502' ">>page_view_${name}.txt


echo "ningbo 0803 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%ningbo%' or  getcs like '?area=0803' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%ningbo%' or  getcs like '?area=0803' ">>page_view_${name}.txt

echo "dongguan 0308 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%dongguan%' or  getcs like '?area=0308' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%dongguan%' or  getcs like '?area=0308' ">>page_view_${name}.txt

echo "changchun 2402 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%changchun%' or  getcs like '?area=2402' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%changchun%' or  getcs like '?area=2402' ">>page_view_${name}.txt

echo "suzhou 0703 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%suzhou%' or  getcs like '?area=0703' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%suzhou%' or  getcs like '?area=0703' ">>page_view_${name}.txt


echo "fuzhou 1102 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%fuzhou%' or  getcs like '?area=1102' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%fuzhou%' or  getcs like '?area=1102' ">>page_view_${name}.txt

echo "zhengzhou 1702 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%zhengzhou%' or  getcs like '?area=1702' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%zhengzhou%' or  getcs like '?area=1702' ">>page_view_${name}.txt

echo "tianjin 0500 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%tianjin%' or  getcs like '?area=0500' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%tianjin%' or  getcs like '?area=0500' ">>page_view_${name}.txt

echo "shijiazhuang handan 1602 1607 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%shijiazhuang%' or  getcs like '?area=1602' or getcs like '%handan%' or  getcs like '?area=1607'">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%shijiazhuang%' or  getcs like '?area=1602'or getcs like '%handan%' or  getcs like '?area=1607' ">>page_view_${name}.txt

echo "jiujiang nanchang ganzhou 1303 1302  1308 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%jiujiang%' or  getcs like '?area=1303' or getcs like '%nanchang%' or  getcs like '?area=1302' or getcs like '%ganzhou%' or  getcs like '?area=1308' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%jiujiang%' or  getcs like '?area=1303' or getcs like '%nanchang%' or  getcs like '?area=1302' or getcs like '%ganzhou%' or  getcs like '?area=1308' ">>page_view_${name}.txt

echo "wuxi jiangyin changzhou 0704 0705 0715 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%wuxi%' or  getcs like '?area=0704' or getcs like '%jiangyin%' or  getcs like '?area=0705' or getcs like '%changzhou%' or  getcs like '?area=0715' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%wuxi%' or  getcs like '?area=0704' or getcs like '%jiangyin%' or  getcs like '?area=0705' or getcs like '%changzhou%' or  getcs like '?area=0715' ">>page_view_${name}.txt

echo "huizhou shantou zhuhai foshan zhongshan jiangmen zhanjiang zhaoqing qingyuan shunde 0304 0305 0306 0307 0303 0315 0318 0317 0319 0325 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%huizhou%' or  getcs like '?area=0304' or getcs like '%shantou%' or  getcs like '?area=0305' or getcs like '%zhuhai%' or  getcs like '?area=0306' or getcs like '%foshan%' or  getcs like '?area=0307' or getcs like '%zhongshan%' or  getcs like '?area=0303' or getcs like '%jiangmen%' or  getcs like '?area=0315' or getcs like '%zhanjiang%' or  getcs like '?area=0318' or getcs like '%zhaoqing%' or  getcs like '?area=0317' or getcs like '%qingyuan%' or  getcs like '?area=0319' or getcs like '%shunde%' or  getcs like '?area=0325'">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%huizhou%' or  getcs like '?area=0304' or getcs like '%shantou%' or  getcs like '?area=0305' or getcs like '%zhuhai%' or  getcs like '?area=0306' or getcs like '%foshan%' or  getcs like '?area=0307' or getcs like '%zhongshan%' or  getcs like '?area=0303' or getcs like '%jiangmen%' or  getcs like '?area=0315' or getcs like '%zhanjiang%' or  getcs like '?area=0318' or getcs like '%zhaoqing%' or  getcs like '?area=0317' or getcs like '%qingyuan%' or  getcs like '?area=0319' or getcs like '%shunde%' or  getcs like '?area=0325' ">>page_view_${name}.txt

echo " nanning liuzhou  1402 1404 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%nanning%' or  getcs like '?area=1402'  or getcs like '%liuzhou%' or  getcs like '?area=1404' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'   and url='/default-area.php' and getcs like '%nanning%' or  getcs like '?area=1402'  or getcs like '%liuzhou%' or  getcs like '?area=1404' ">>page_view_${name}.txt

echo "taiyuan 2102 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%taiyuan%' or  getcs like '?area=2102' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%taiyuan%' or  getcs like '?area=2102' ">>page_view_${name}.txt

echo "wenzhou 0804 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%wenzhou%' or  getcs like '?area=0804' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%wenzhou%' or  getcs like '?area=0804' ">>page_view_${name}.txt

echo "nantong 0709 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%nantong%' or  getcs like '?area=0709' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%nantong%' or  getcs like '?area=0709' ">>page_view_${name}.txt

echo "yantai 1204 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%yantai%' or  getcs like '?area=1204' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%yantai%' or  getcs like '?area=1204' ">>page_view_${name}.txt

echo "guiyang 2602 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%guiyang%' or  getcs like '?area=2602' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%guiyang%' or  getcs like '?area=2602' ">>page_view_${name}.txt

echo "jiaxing huzhou 0807 0809 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%jiaxing%' or  getcs like '?area=0807' or getcs like '%huzhou%' or  getcs like '?area=0809' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%jiaxing%' or  getcs like '?area=0807' or getcs like '%huzhou%' or  getcs like '?area=0809' ">>page_view_${name}.txt


echo "lanzhou 2702 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%lanzhou%' or  getcs like '?area=2702' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%lanzhou%' or  getcs like '?area=2702' ">>page_view_${name}.txt


echo "haikou sanya 1002  1003 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%haikou%' or  getcs like '?area=1002' or getcs like '%sanya%' or  getcs like '?area=1003' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%haikou%' or  getcs like '?area=1002' or getcs like '%sanya%' or  getcs like '?area=1003' ">>page_view_${name}.txt

echo "huhehaote huhhot  baotou  eerduosi 2802 2804  2808 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%huhhot%' or  getcs like '?area=2802' or getcs like '%baotou%' or  getcs like '?area=2808' or getcs like '%eerduosi%' or  getcs like '?area=2804'  ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%huhhot%' or  getcs like '?area=2802' or getcs like '%baotou%' or  getcs like '?area=2804' or getcs like '%eerduosi%' or  getcs like '?area=2804'  ">>page_view_${name}.txt

echo "wulumuqi urumqi 3102 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%urumqi%' or  getcs like '?area=3102' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%urumqi%' or  getcs like '?area=3102' ">>page_view_${name}.txt


echo "kunshan changshu zhangjiagang 0706 0707 0714 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%kunshan%' or  getcs like '?area=0706' or getcs like '%changshu%' or  getcs like '?area=0707' or getcs like '%zhangjiagang%' or  getcs like '?area=0714' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%kunshan%' or  getcs like '?area=0706' or getcs like '%changshu%' or  getcs like '?area=0707' or getcs like '%zhangjiagang%' or  getcs like '?area=0714'">>page_view_${name}.txt



echo "xuzhou yangzhou zhenjiang 0711 0708  0710 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%xuzhou%' or  getcs like '?area=0711'  or getcs like '%yangzhou%' or  getcs like '?area=0708'  or getcs like '%zhenjiang%' or  getcs like '?area=0710' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%xuzhou%' or  getcs like '?area=0711'  or getcs like '%yangzhou%' or  getcs like '?area=0708'  or getcs like '%zhenjiang%' or  getcs like '?area=0710' ">>page_view_${name}.txt


echo "shaoxing taizhou jinhua  yiwu 0805 0808  0806 0814 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%shaoxing%' or  getcs like '?area=0805' or getcs like '%taizhou%' or  getcs like '?area=0808' or getcs like '%jinhua%' or  getcs like '?area=0806' or getcs like '%yiwu%' or  getcs like '?area=0814' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%shaoxing%' or  getcs like '?area=0805' or getcs like '%taizhou%' or  getcs like '?area=0808' or getcs like '%jinhua%' or  getcs like '?area=0806' or getcs like '%yiwu%' or  getcs like '?area=0814' ">>page_view_${name}.txt


echo "langfang 1603 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%langfang%' or  getcs like '?area=1603' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%langfang%' or  getcs like '?area=1603' ">>page_view_${name}.txt

echo "wuhu 1503 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%wuhu%' or  getcs like '?area=1503' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%wuhu%' or  getcs like '?area=1503' ">>page_view_${name}.txt

echo "weifang linyi weihai  zibo  jining 1208 1205 1206  1207 1209 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%weifang%' or  getcs like '?area=1208' or getcs like '%linyi%' or  getcs like '?area=1205' or getcs like '%weihai%' or  getcs like '?area=1206' or getcs like '%zibo%' or  getcs like '?area=1207' or getcs like '%jining%' or  getcs like '?area=1209' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%weifang%' or  getcs like '?area=1208' or getcs like '%linyi%' or  getcs like '?area=1205' or getcs like '%weihai%' or  getcs like '?area=1206' or getcs like '%zibo%' or  getcs like '?area=1207' or getcs like '%jining%' or  getcs like '?area=1209' ">>page_view_${name}.txt


echo "baoding tangshan qinhuangdao 1604 1605 1606 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%baoding%' or  getcs like '?area=1604' or getcs like '%tangshan%' or  getcs like '?area=1605' or getcs like '%qinhuangdao%' or  getcs like '?area=1606' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%baoding%' or  getcs like '?area=1604' or getcs like '%tangshan%' or  getcs like '?area=1605' or getcs like '%qinhuangdao%' or  getcs like '?area=1606' ">>page_view_${name}.txt


echo "jilin 2403 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%jilin%' or  getcs like '?area=2403' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%jilin%' or  getcs like '?area=2403' ">>page_view_${name}.txt

echo "luoyang 1703 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%luoyang%' or  getcs like '?area=1703' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%luoyang%' or  getcs like '?area=1703' ">>page_view_${name}.txt


echo "yichang xiangyang jingzhou 1803 1805 1807 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%yichang%' or  getcs like '?area=1803' or  getcs like '?area=1805' or getcs like '%xiangyang%' or  getcs like '?area=1807' or getcs like '%jingzhou%' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%yichang%' or  getcs like '?area=1803' or  getcs like '?area=1805' or getcs like '%xiangyang%' or  getcs like '?area=1807' or getcs like '%jingzhou%'">>page_view_${name}.txt

echo "zhuzhou hengyang xiangtan changde 1903 1904 1905 1907 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%zhuzhou%' or  getcs like '?area=1903' or getcs like '%hengyang%' or  getcs like '?area=1904' or getcs like '%xiangtan%' or  getcs like '?area=1905' or getcs like '%changde%' or  getcs like '?area=1907' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%zhuzhou%' or  getcs like '?area=1903' or getcs like '%hengyang%' or  getcs like '?area=1904' or getcs like '%xiangtan%' or  getcs like '?area=1905' or getcs like '%changde%' or  getcs like '?area=1907' ">>page_view_${name}.txt

echo "yancheng lianyungang huaian taizhou  0712 0713 0719 0718 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%yancheng%' or  getcs like '?area=0712'  or getcs like '%lianyungang%'  or  getcs like '?area=0713' or getcs like '%huaian%' or  getcs like '?area=0719' or getcs like '%taizhou%' or  getcs like '?area=0718' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww' and url='/default-area.php' and getcs like '%yancheng%' or  getcs like '?area=0712'  or getcs like '%lianyungang%'  or  getcs like '?area=0713' or getcs like '%huaian%' or  getcs like '?area=0719' or getcs like '%taizhou%' or  getcs like '?area=0718'  ">>page_view_${name}.txt


echo "anshan yingkou fushun dandong tieling  2304 2305 2306 2308 2312 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%anshan%' or  getcs like '?area=2304'  or getcs like '%yingkou%'  or  getcs like '?area=2305' or getcs like '%fushun%' or  getcs like '?area=2306' or getcs like '%dandong%' or  getcs like '?area=2308'  or getcs like '%tieling%' or  getcs like '?area=2312'  ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww' and url='/default-area.php' and getcs like '%anshan%' or  getcs like '?area=2304'  or getcs like '%yingkou%'  or  getcs like '?area=2305' or getcs like '%fushun%' or  getcs like '?area=2306' or getcs like '%dandong%' or  getcs like '?area=2308'  or getcs like '%tieling%' or  getcs like '?area=2312'  ">>page_view_${name}.txt

echo "yinchuan 2403 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%yinchuan%' or  getcs like '?area=2902' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%yinchuan%' or  getcs like '?area=2902' ">>page_view_${name}.txt



echo "mianyang 0903 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%mianyang%' or  getcs like '?area=0903' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%mianyang%' or  getcs like '?area=0903' ">>page_view_${name}.txt

echo "xianyang 2003 ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-area.php' and getcs like '%xianyang%' or  getcs like '?area=2003' ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-area.php' and getcs like '%xianyang%' or  getcs like '?area=2003' ">>page_view_${name}.txt


echo "quanguo pingdao ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-qz.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-qz.php'   ">>page_view_${name}.txt

echo "51job zhuye ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default.php'  or url='/'   or url=''   ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default.php'   or url='/'  or url=''  ">>page_view_${name}.txt

echo "yingwen zhuye ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-e.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-e.php'   ">>page_view_${name}.txt

echo "My51job ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table}  where channel='5linux'  and url='/my/My_Pmc.php' and getfs='GET'   ">>page_view_${name}.txt

echo "zhichang zixun ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default_res.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default_res.php'   ">>page_view_${name}.txt

echo "qilurexian hezuo yemian ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-sd.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-sd.php'   ">>page_view_${name}.txt

echo "donguan hezuo yemian ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-dg.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-dg.php'   ">>page_view_${name}.txt

echo "daxuesheng qiuzhi baodian yemian****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='xy'  and url='/ebook/index.html'    ">>page_view_${name}.txt

echo "hr shequ club ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='blogdata'    and url='%/index.asp%'   or url='/'  ">>page_view_${name}.txt

echo "minnan pindao****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-mn.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-mn.php'   ">>page_view_${name}.txt

echo "xiaoyuan zhaopin ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='xy'  and url='/default-xs.php'    ">>page_view_${name}.txt

echo "shixi pindao****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='shixi'  and url='/default.php'    ">>page_view_${name}.txt


echo "jianli zhidao****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url like '%/careerpost/jianlishuoming/%'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url like '%/careerpost/jianlishuoming/%'    ">>page_view_${name}.txt

echo "51 club ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='my'  and url='/51club/index.php'    ">>page_view_${name}.txt

echo "BBS****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='bbs'  and url='/index.php'    ">>page_view_${name}.txt

echo "peixun pindao ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tr'  and url='/default-tr.php'    ">>page_view_${name}.txt

echo "gaoji lietou ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-gj.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-gj.php'   ">>page_view_${name}.txt


echo "IT rencai****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-it.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-it.php'   ">>page_view_${name}.txt

echo "51job wangcai ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='newehireweb'  and url='/MainLogin.aspx'     ">>page_view_${name}.txt


else
 echo "Usage: $0  DateTime"
 exit 1
fi
















********************************************************************************************************************************



echo "quanguo pingdao ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-qz.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-qz.php'   ">>page_view_${name}.txt

echo "51job zhuye ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default.php'  or url='/'   or url=''   ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default.php'   or url='/'  or url=''  ">>page_view_${name}.txt

echo "yingwen zhuye ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-e.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-e.php'   ">>page_view_${name}.txt

echo "My51job ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table}  where channel='5linux'  and url='/my/My_Pmc.php' and getfs='GET' ">>page_view_${name}.txt

echo "zhichang zixun ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default_res.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default_res.php'   ">>page_view_${name}.txt

echo "qilurexian hezuo yemian ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-sd.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-sd.php'   ">>page_view_${name}.txt

echo "donguan hezuo yemian ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-dg.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-dg.php'   ">>page_view_${name}.txt

echo "daxuesheng qiuzhi baodian yemian****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='xy'  and url='/ebook/index.html'    ">>page_view_${name}.txt

echo "hr shequ club ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='blogdata'  and url='%/index.asp%'    ">>page_view_${name}.txt

echo "minnan pindao****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-mn.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-mn.php'   ">>page_view_${name}.txt

echo "xiaoyuan zhaopin ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='xy'  and url='/default-xs.php'    ">>page_view_${name}.txt

echo "shixi pindao****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='shixi'  and url='/default.php'    ">>page_view_${name}.txt


echo "jianli zhidao****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url like '%/careerpost/jianlishuoming/%'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url like '%/careerpost/jianlishuoming/%'    ">>page_view_${name}.txt

echo "51 club ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='my'  and url='/51club/index.php'    ">>page_view_${name}.txt

echo "BBS****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='bbs'  and url='/index.php'    ">>page_view_${name}.txt

echo "peixun pindao ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tr'  and url='/default-e.php'    ">>page_view_${name}.txt

echo "gaoji lietou ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-gj.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-gj.php'   ">>page_view_${name}.txt


echo "IT rencai****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='5www'  and url='/default-it.php'    ">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='tjwww'  and url='/default-it.php'   ">>page_view_${name}.txt

echo "51job wangcai ****************">>page_view_${name}.txt
hive -e  "select count(*) from ${table} where channel='ehire'  and url='/MainLogin.aspx'    ">>page_view_${name}.txt












