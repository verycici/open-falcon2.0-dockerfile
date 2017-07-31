FROM base_centos6:v1
MAINTAINER "loading.ding <loading.ding@gaeamobile.com>"

ENV     falcon_module="alarm" \
        redis_addr="127.0.0.1" \
        im_addr_port="127.0.0.1:10086" \
        sms_addr_port="127.0.0.1:10086" \
        mail_addr_port="127.0.0.1:10086" \
        dashboard_addr_port="127.0.0.1:8081" \
        api_addr_port="127.0.0.1:8080" \
        api_token="default-token-used-in-server-side" \
        mysql_addr="127.0.0.1" \
        mysql_user_pass="root:password" 

RUN     ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime \
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
