FROM alpine:latest

# تثبيت الأدوات المطلوبة
RUN apk update && apk add \
    bash \
    curl \
    git \
    ttyd \
    nano \
    htop \
    neofetch

# تعيين البورت 8080
EXPOSE 8080

# تشغيل ttyd مع bash
CMD ["ttyd", "-p", "8080", "bash"]
