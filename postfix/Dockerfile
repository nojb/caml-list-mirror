FROM debian:8.5
MAINTAINER Nicolás Ojeda Bär <n.oje.bar@gmail.com>
RUN apt-get update
RUN apt-get -y install \
    postfix \
    mailutils
RUN useradd -m -s /bin/bash caml-list
RUN postconf -e "home_mailbox = Maildir/"
RUN postconf -e "mydestination = "inbox.ocaml.org"
RUN postconf -e "inet_interfaces = all"
RUN postfix start
#CMD tail -f /var/log/mail.log
EXPOSE 25
