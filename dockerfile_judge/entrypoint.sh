#!/bin/bash 

set +e

# modify config
sed -i "2s/true/${falcon_debug}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "14s/0.0.0.0/${hbs_addr}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "14s/6030/${hbs_port}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "23s/127.0.0.1/${redis_addr}/" /home/work/open-falcon/${falcon_module}/config/cfg.json

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
