FROM debian:8.5
MAINTAINER Nicolás Ojeda Bär <n.oje.bar@gmail.com>
RUN apt-get update
RUN apt-get -y install \
    git make perl supervisor \
    libtimedate-perl \
    libemail-mime-perl \
    libemail-mime-contenttype-perl \
    libplack-perl \
    liburi-perl \
    libsearch-xapian-perl \
    libio-compress-perl \
    libdbi-perl \
    libdbd-sqlite3-perl \
    libnet-server-perl \
    libfilesys-notify-simple-perl \
    libdanga-socket-perl \
    libnet-server-perl
RUN git clone git://80x24.org/public-inbox /root/public-inbox
RUN cd /root/public-inbox && perl Makefile.PL && make && make install
COPY config /root/.public-inbox/config
RUN public-inbox-init caml-list ~/caml-list.git https://inbox.ocaml.org/caml-list caml-list@inria.fr
RUN cd /root/caml-list.git && git config user.name bactrian && git config user.email bactrian@ocaml.org
COPY caml-list.tar.gz /root/caml-list.tar.gz
COPY public-inbox/scripts/import_maildir /root/import_maildir
RUN cd /root/ && tar zxvf caml-list.tar.gz
RUN cd /root/caml-list.git && perl /root/import_maildir /root/caml-list/
RUN cd /root/caml-list.git && public-inbox-index
COPY supervisord.conf /root/supervisord.conf
CMD /usr/bin/supervisord -c /root/supervisord.conf -n
EXPOSE 8080
