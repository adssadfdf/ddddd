FROM alpine:latest

# تثبيت الأدوات المطلوبة
RUN apk update && apk add \
    bash \
    curl \
    git \
    ttyd \
    nano \
    htop

# تثبيت neofetch يدويًا
RUN git clone https://github.com/dylanaraps/neofetch && \
    cd neofetch && \
    cp neofetch /usr/local/bin/ && \
    chmod +x /usr/local/bin/neofetch

# فتح بورت 8080
EXPOSE 8080

# بدء ttyd مع bash
CMD ["ttyd", "-p", "8080", "bash"]
