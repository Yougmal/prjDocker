FROM freeradius/freeradius-server:latest

RUN apt update && \
    apt install -y procps vim sudo && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

