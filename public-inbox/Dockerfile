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
EXPOSE 8080
