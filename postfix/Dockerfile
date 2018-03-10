FROM debian:8.5
MAINTAINER Nicolás Ojeda Bär <n.oje.bar@gmail.com>
RUN apt-get update
RUN echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt && \
    echo "postfix postfix/mailname string inbox.ocaml.org" >> preseed.txt && \
    debconf-set-selections preseed.txt && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install postfix
RUN apt-get install -y mailutils rsyslog
RUN useradd -m -s /bin/bash caml-list && \
    mkdir /home/caml-list/Maildir && \
    chmod 777 /home/caml-list/Maildir
RUN postconf -e "home_mailbox = Maildir/" && \
    postconf -e "mydestination = inbox.ocaml.org" && \
    postconf -e "inet_interfaces = all"
RUN ln -sf /dev/stdout /var/log/mail.log
CMD service postfix start && rsyslogd -n
EXPOSE 25
