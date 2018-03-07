cat re_purchase.sh
#!/bin/sh
#复购率
#Adair 2018-03-07
DBNAME="df_opencartv3"
THIS_MONTH=`date +"%Y-%m"`
#echo ${THIS_MONTH}
NEXT_MONTH=`date -d next-month +"%Y-%m"`
#echo ${NEXT_MONTH}


cd /var/www/sh && mysql --defaults-file='my.cnf' -e"use ${DBNAME};SELECT * FROM ( SELECT o.order_id, o.firstname, o.email, CASE o.customer_group_id WHEN 8 THEN 'Default' WHEN 9 THEN 'Distributor' WHEN 10 THEN 'Distributor(HK)' END AS 'Wholesale', o.shipping_country, o.date_added, ot.model, ot.name, ot.quantity, ot.total, o.shipping_method, os. NAME AS order_status FROM df_opencartv3.order AS o LEFT JOIN order_product AS ot ON o.order_id = ot.order_id LEFT JOIN order_status AS os ON o.order_status_id = os.order_status_id WHERE o.date_added >= '${THIS_MONTH}.-01' AND o.date_added <= '${NEXT_MONTH}.-01'  AND ot.total > 0 ) AS a JOIN ( SELECT o1.email, IF ( o1.email = o2.email, 'customer', 'new customer' ) AS customer FROM ( ( SELECT DISTINCT (email) FROM df_opencartv3.order WHERE date_added >= '${THIS_MONTH}.-01' AND date_added <= '${NEXT_MONTH}.-01'  ) AS o1 LEFT JOIN ( SELECT DISTINCT (email) FROM df_opencartv3.order WHERE date_added < '${THIS_MONTH}.-01' ) AS o2 ON o1.email = o2.email ) ) AS b ON a.email = b.email JOIN ( SELECT email, COUNT(DISTINCT order_id) AS orders FROM df_opencartv3.order WHERE email IN ( SELECT DISTINCT (email) FROM df_opencartv3.order WHERE date_added >= '${THIS_MONTH}.-01' AND date_added <= '${NEXT_MONTH}.-02' ) GROUP BY email ) AS c ON a.email = c.email ; "  > /var/www/sh/log_re_purchase_${THIS_MONTH}.xls




cat my.cnf
[client]
user='root'
password='***'
host='localhost'
port='3333'
