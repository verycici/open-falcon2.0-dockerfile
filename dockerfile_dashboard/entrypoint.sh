#!/bin/bash 

set +e

# modify config
sed -i "s/^API_ADDR.*$/API_ADDR = os.environ.get(\"API_ADDR\",\"http:\/\/${api_addr}:${api_port}\/api\/v1\")/g" /home/work/open-falcon/${falcon_module}/rrd/config.py
sed -i "s/^PORTAL_DB_HOST.*$/PORTAL_DB_HOST = os.environ.get(\"PORTAL_DB_HOST\",\"${protal_db_host}\")/g" /home/work/open-falcon/${falcon_module}/rrd/config.py
sed -i "s/^PORTAL_DB_USER.*$/PORTAL_DB_USER = os.environ.get(\"PORTAL_DB_USER\",\"${protal_db_user}\")/g" /home/work/open-falcon/${falcon_module}/rrd/config.py
sed -i "s/^PORTAL_DB_PASS.*$/PORTAL_DB_PASS = os.environ.get(\"PORTAL_DB_PASS\",\"${protal_db_pass}\")/g" /home/work/open-falcon/${falcon_module}/rrd/config.py
sed -i "s/^ALARM_DB_HOST.*$/ALARM_DB_HOST = os.environ.get(\"ALARM_DB_HOST\",\"${alarm_db_host}\")/g" /home/work/open-falcon/${falcon_module}/rrd/config.py
sed -i "s/^ALARM_DB_USER.*$/ALARM_DB_USER = os.environ.get(\"ALARM_DB_USER\",\"${alarm_db_user}\")/g" /home/work/open-falcon/${falcon_module}/rrd/config.py
sed -i "s/^ALARM_DB_PASS.*$/ALARM_DB_PASS = os.environ.get(\"ALARM_DB_PASS\",\"${alarm_db_pass}\")/g" /home/work/open-falcon/${falcon_module}/rrd/config.py

# start falcon_module
/home/work/open-falcon/dashboard/control start

# Launch
errno=$?
if [ $errno -ne 0 ] ; then
  echo "Failed to start"
  exit 1
fi

# Monitor
pid=$(pgrep -f -U $(id -u) ${falcon_module}|sort -r|tail -n 1)
while kill -0 $pid 2>/dev/null ; do
  sleep 10
done
echo "${falcon_module} exited"
