FROM debian:8.5
MAINTAINER Nicolás Ojeda Bär <n.oje.bar@gmail.com>
RUN apt-get update
RUN echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt
RUN echo "postfix postfix/mailname string inbox.ocaml.org" >> preseed.txt
RUN debconf-set-selections preseed.txt
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install postfix
RUN apt-get install -y mailutils syslog-ng
RUN useradd -m -s /bin/bash caml-list
RUN postconf -e "home_mailbox = Maildir/"
RUN postconf -e "mydestination = inbox.ocaml.org"
RUN postconf -e "inet_interfaces = all"
CMD service postfix start && tail -F /var/log/mail.log
EXPOSE 25
