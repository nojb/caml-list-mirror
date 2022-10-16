FROM debian:bullseye-backports

MAINTAINER Nicolás Ojeda Bär <n.oje.bar@gmail.com>

RUN echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt && \
    echo "postfix postfix/mailname string inbox.ocaml.org" >> preseed.txt && \
    debconf-set-selections preseed.txt

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get -y install \
    make \
    libtimedate-perl \
    libplack-middleware-reverseproxy-perl \
    liblinux-inotify2-perl \
    public-inbox \
    postfix \
    sudo

RUN echo "nobody ALL=(root) NOPASSWD:SETENV:/usr/bin/public-inbox-mda" >> /etc/sudoers.d/nobody

ADD mda.sh /mda.sh

RUN chmod +x /mda.sh

RUN postconf -e "mydestination = inbox.ocaml.org, localhost, localhost.localdomain"
RUN postconf -e "inet_interfaces = all"
RUN postconf -e "maillog_file = /dev/stdout"

ADD aliases /etc/aliases

RUN postalias /etc/aliases

COPY config /root/.public-inbox/config
