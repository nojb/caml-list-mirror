FROM debian:bullseye-backports

MAINTAINER Nicolás Ojeda Bär <n.oje.bar@gmail.com>

RUN apt-get update && \
    apt-get -y install \
    make \
    libtimedate-perl \
    libplack-middleware-reverseproxy-perl \
    liblinux-inotify2-perl \
    public-inbox

COPY config /root/.public-inbox/config
