FROM alpine:latest

RUN apk update && apk add \
    bash \
    curl \
    git \
    ttyd \
    nano \
    htop && \
    git clone https://github.com/dylanaraps/neofetch && \
    cp neofetch/neofetch /usr/local/bin/ && \
    chmod +x /usr/local/bin/neofetch && \
    rm -rf neofetch

EXPOSE 8080

CMD ["ttyd", "-p", "8080", "bash"]
