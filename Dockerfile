FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install everything
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies tightvncserver wget git cmake g++ curl tini bash \
    libjson-c-dev libwebsockets-dev libssl-dev libtool make python3-websockify novnc \
    && git clone --depth=1 https://github.com/tsl0922/ttyd.git /ttyd \
    && cd /ttyd && mkdir build && cd build \
    && cmake .. && make && make install \
    && rm -rf /ttyd

# Install cloudflared (optional)
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb \
    && dpkg -i cloudflared-linux-amd64.deb || true \
    && rm -f cloudflared-linux-amd64.deb

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Required ports
EXPOSE 5901 6080 7681

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/start.sh"]
