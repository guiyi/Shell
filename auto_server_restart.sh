#!/bin/bash
# author: Adair 2018-02-11


#502 监测重启
CheckURL="https://www.***.com"

STATUS_CODE=`curl -o /dev/null -m 10 --connect-timeout 10 -s -w %{http_code} $CheckURL`
#echo "$CheckURL Status Code:\t$STATUS_CODE"
if [ "$STATUS_CODE" -ge 500 ]; then
        /etc/init.d/php7.0-fpm restart
        service nginx restart
        /etc/init.d/mysql restart
        echo "`date +%Y-%m-%d,%H:%M:%S`--$STATUS_CODE---/etc/init.d/php7.0-fpm restart">>/tmp/502.log
fi

#Nginx 监测重启
RED_COLOR='\E[1;31m'
RES='\E[0m'
NGX=`netstat -anput | grep nginx | wc -l`
if [ "$NGX" -ne 0 ]
   then
     echo -en "${RED_COLOR} Nginx is running！\n${RES}"
   else
     echo "`date +%Y-%m-%d,%H:%M:%S`-----service nginx restart">>/tmp/502.log
     service nginx restart
fi


#Mysql 监测重启
NGX=`netstat -anput | grep mysql | wc -l`
if [ "$NGX" -ne 0 ]
   then
     echo -en "${RED_COLOR} Mysql is running！\n${RES}"
   else
     echo "`date +%Y-%m-%d,%H:%M:%S`-----/etc/init.d/mysql restart">>/tmp/502.log
     sudo /etc/init.d/mysql restart
fi


#PHP 监测重启
RED_COLOR='\E[1;31m'
RES='\E[0m'
NGX=`netstat -anput | grep php | wc -l`
if [ "$NGX" -ne 0 ]
   then
     echo -en "${RED_COLOR} PHP is running！\n${RES}"
   else
     echo "`date +%Y-%m-%d,%H:%M:%S`-----service php7.0-fpm restart">>/tmp/502.log
     service php7.0-fpm restart
fi
