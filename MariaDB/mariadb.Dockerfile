#: FROM mariadb:10.6.12
FROM mariadb:latest
RUN echo "Acquire::Check-Valid-Until \"false\";\nAcquire::Check-Date \"false\";" | cat > /etc/apt/apt.conf.d/10no--check-valid-until
RUN apt update && apt install -y procps
EXPOSE 3306