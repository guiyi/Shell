#!/bin/bash
##############################################
#Author: Adair.zou - 274340311@qq.com
#Description: 监控硬盘/CPU/内存
##############################################
fdisk(){
        # 截取IP
        #bash
        IP=`ifconfig eth0 |awk -F " " 'NR==2{print $2}'`
        #mac
        IP=`ifconfig en0 |awk -F " " 'NR==5{print $2}'`
        # 定义使用率,并转换为数字
        SPACE=`df -Ph |awk '{print int($5)}'` 
        j=0
        MX=60 
        for i in $SPACE

        do
                if [ $i -ge $MX ]
                then
                     #array_name[$j]="$IP 的磁盘使用率已经超过了90%，请及时处理"
                     echo "$IP 的磁盘使用率已经超过了$MX%，请及时处理"
                     #存到Redis队列，等待消费
                     result=`redis-cli -h 127.0.0.1 -p 6379 lpush disk "$IP disk usage $MX%"`
                     [ $? -eq 0 ] && echo “insert into redis success” || echo “insert into redis fail”

                fi
        done  
       
        return ${array_name}; 
}
fcpu(){
        MX=80 
        #echo "$MX"
        #获取cpu使用率
        #bash
        cpuUsage=`top -n 1 | awk -F '[ %]+' 'NR==3 {print $2,$3}'`
        #mac
        #cpuUsage=`top -n 1 | awk -F '[ %]+' 'NR==4 {print $1,$2,$3}'`
        echo "$cpuUsage"
        if [ "$cpuUsage" > $MX ] 
        then
                     echo "$IP 的CPU使用率已经超过了$MX%，$cpuUsage 请及时处理"

        fi
}

fmemory(){
        MX=80
        #echo "$MX"
        #获取内存情况
        mem_total=`free -m | awk -F '[ :]+' 'NR==2{print $2}'`
        mem_used=`free -m | awk -F '[ :]+' 'NR==3{print $3}'`
       
        #统计内存使用率
        mem_used_persent=`awk 'BEGIN{printf "%.0f\n",('$mem_used'/'$mem_total')*100}'`
   
        if [ "$cpuUsage" > $MX ] 
        then
                     echo "$IP 的内存使用率已经超过了$MX%，$mem_used_persent 请及时处理"

        fi
}
fdisk
fcpu
fmemory
