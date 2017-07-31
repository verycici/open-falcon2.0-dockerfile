#!/bin/bash 

set +e

# modify config
sed -i "2s/false/${falcon_debug}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "15s/127.0.0.1/${mysql_addr}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "15s/root:/${mysql_user_pass}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "24s/127.0.0.1/${graph_00_addr}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "24s/6070/${graph_00_port}/" /home/work/open-falcon/${falcon_module}/config/cfg.json

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
