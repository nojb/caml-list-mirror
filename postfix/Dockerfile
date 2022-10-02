FROM debian:8.5

MAINTAINER Nicolás Ojeda Bär <n.oje.bar@gmail.com>

RUN apt-get update

RUN echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt && \
    echo "postfix postfix/mailname string inbox.ocaml.org" >> preseed.txt && \
    debconf-set-selections preseed.txt && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install postfix

RUN apt-get install -y mailutils rsyslog

ADD aliases /etc/aliases

RUN postconf -e "home_mailbox = Maildir/" && \
    postconf -e "mydestination = inbox.ocaml.org, localhost, localhost.localdomain" && \
    postconf -e "inet_interfaces = all"

RUN ln -sf /dev/stdout /var/log/mail.log

CMD service postfix start && newaliases && rsyslogd -n

EXPOSE 25
