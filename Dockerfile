FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y \
    git cmake g++ libjson-c-dev libwebsockets-dev libssl-dev \
    build-essential curl tini bash \
    && git clone --depth=1 https://github.com/tsl0922/ttyd.git /ttyd \
    && cd /ttyd && mkdir build && cd build \
    && cmake .. && make && make install \
    && rm -rf /ttyd

# Expose the ttyd port
EXPOSE 7681

ENTRYPOINT ["/usr/local/bin/ttyd"]
CMD ["bash"]
