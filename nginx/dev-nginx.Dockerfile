FROM ubuntu:20.04
# MAINTAINER Younghwan Chin "younghwan.chin@keyonet.com"

ENV TZ Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y procps
RUN apt install -y nginx

RUN apt install -y software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN apt update
RUN apt install -y php-fpm php-mysql php-xml php-curl php-gd php-soap

RUN mkdir -p /www
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 8080

WORKDIR /uacs
ENTRYPOINT ["/usr/sbin/entrypoint.sh"]

