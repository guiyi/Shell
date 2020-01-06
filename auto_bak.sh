#!/bin/sh
#备份数据库
#Adair 2020-01-06
#THIS_DAY=`date +"%Y-%m-%d"`
#PATH='/var/www/bak/'
#DATABASE='database_'${THIS_DAY}'.sql.gz'
#echo ${PATH}${DATABASE}
#FILE=${PATH}${DATABASE}


#echo scp -i /home/www_dfrobot_com.pem   ubuntu@52.15.224.251:${FILE}  /home/bak/


#rm -f ${PATH}database_`date -d '-5 days' +%Y-%m-%d`.sql.gz 

expect -c "
    spawn scp -i /密钥文件.pem ubuntu@52.15.224.251:/var/www/bak/all_database_`date +"%Y-%m-%d"`.sql.gz /home/bak/
    expect {
         {set timeout 20;  exp_continue;} #此处的jello为密码，自行替换
    }
expect eof"


rm -f /home/bak/all_database_`date -d '-3 days' +%Y-%m-%d`.sql.gz
