FROM base_centos6:v1
MAINTAINER "loading.ding <loading.ding@gaeamobile.com>"

ENV   falcon_module="dashboard" \
      api_addr="127.0.0.1" \
      api_port="8080" \
      protal_db_host="127.0.0.1" \
      protal_db_user="root" \
      protal_db_pass="password" \
      alarm_db_host="127.0.0.1" \
      alarm_db_user="root" \
      alarm_db_pass="password"

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime \
      && yum install -y epel-release \
      && yum -y update \
      && yum groupinstall -y "Development tools" \
      && yum install -y python-virtualenv python-devel openldap-devel mysql-devel \
      && yum clean all

WORKDIR /home/work/open-falcon/${falcon_module}

ADD ./${falcon_module}/ ./

RUN virtualenv /home/work/open-falcon/dashboard/env \
      && /home/work/open-falcon/dashboard/env/bin/pip install -r pip_requirements.txt -i http://pypi.douban.com/simple

ADD ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
