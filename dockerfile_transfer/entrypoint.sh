#!/bin/bash 

set +e

# modify config
sed -i "2s/true/${falcon_debug}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "26s/0.0.0.0/${judge_00_addr}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "26s/6080/${judge_00_port}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "38s/0.0.0.0/${graph_00_addr}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "38s/6070/${graph_00_port}/" /home/work/open-falcon/${falcon_module}/config/cfg.json

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
