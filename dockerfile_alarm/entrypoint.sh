#!/bin/bash 

set +e

# modify config
sed -i "8s/127.0.0.1/${redis_addr}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "26s/127.0.0.1:10086/${im_addr_port}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "27s/127.0.0.1:10086/${sms_addr_port}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "28s/127.0.0.1:10086/${mail_addr_port}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "29s/127.0.0.1:8081/${dashboard_addr_port}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "30s/127.0.0.1:8080/${api_addr_port}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "31s/default-token-used-in-server-side/${api_token}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "34s/127.0.0.1/${mysql_addr}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "34s/root:/${mysql_user_pass}/" /home/work/open-falcon/${falcon_module}/config/cfg.json

# start falcon_module
/home/work/open-falcon/open-falcon start ${falcon_module}

# Launch
errno=$?
if [ $errno -ne 0 ] ; then
  echo "Failed to start"
  exit 1
fi

# Monitor
pid=$(pgrep -f -U $(id -u) falcon-${falcon_module})
while kill -0 $pid 2>/dev/null ; do
  sleep 10
done
echo "falcon-${falcon_module} exited"
