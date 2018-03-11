FROM debian:8.5
MAINTAINER Nicolás Ojeda Bär <n.oje.bar@gmail.com>
RUN apt-get update
RUN apt-get -y install \
    git make perl \
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
    libnet-server-perl \
    libplack-middleware-deflater-perl \
    libplack-middleware-reverseproxy-perl
RUN git clone https://github.com/nojb/public-inbox /root/public-inbox
RUN cd /root/public-inbox && perl Makefile.PL && make && make install
COPY config /root/.public-inbox/config
