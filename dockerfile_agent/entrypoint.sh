#!/bin/bash 

set +e

# modify config
sed -i "2s/true/${falcon_debug}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "13s/0.0.0.0:6030/${hbs_addr_port}/" /home/work/open-falcon/${falcon_module}/config/cfg.json
sed -i "20s/0.0.0.0:8433/${transfer_addr_port}/" /home/work/open-falcon/${falcon_module}/config/cfg.json

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
