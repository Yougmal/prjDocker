FROM freeradius/freeradius-server:latest

RUN apt update && \
    apt install -y procps vim sudo && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# 로그 저장을 위해 파일 권한 설정 (필요 시)
RUN mkdir -p /var/debug && \
    touch /var/debug/freeradius.log && \
    chmod 666 /var/debug/freeradius.log

# 기본 실행 명령어
CMD ["/bin/bash", "-c", "freeradius -f"]
