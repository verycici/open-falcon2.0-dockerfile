FROM base_centos6:v1
MAINTAINER "loading.ding <loading.ding@gaeamobile.com>"

ENV	falcon_module="api" \
	mysql_addr="127.0.0.1" \
	mysql_user_pass="root:password" \
	graph_00_addr="127.0.0.1" \
	graph_00_port="6070"

RUN	ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime \
	&& yum install -y epel-release \
	&& yum -y update \
	&& yum groupinstall -y "Development tools" \
	&& yum install -y mysql-devel \
	&& yum clean all

WORKDIR /home/work/open-falcon

ADD ./open-falcon/${falcon_module}/ ./${falcon_module}/
ADD ./open-falcon/open-falcon ./

ADD ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
