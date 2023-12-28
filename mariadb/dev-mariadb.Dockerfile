FROM mariadb:10.6.12
ENV TZ Asia/Seoul  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y procps
EXPOSE 3306
