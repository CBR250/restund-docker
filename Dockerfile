FROM ubuntu:14.04
MAINTAINER Matti Jokitulppo <matti.jokitulppo@aalto.fi>

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install g++ patch make curl -y

RUN mkdir /re
RUN mkdir /restund

RUN curl -O "https://ftp.fau.de/macports/distfiles/restund/restund-0.4.12.tar.gz"
RUN tar --strip-components=1 -xf restund-0.4.12.tar.gz -C /restund

RUN curl -O "www.mirrorservice.org/sites/distfiles.macports.org/libre/re-0.4.15.tar.gz"
RUN tar --strip-components=1 -xf re-0.4.15.tar.gz  -C /re

ADD . /restund

WORKDIR /re
RUN make
RUN make install

WORKDIR /restund
RUN make
RUN make install

RUN cp /restund/restund.custom.conf /etc/restund.conf

RUN chmod +x /restund/start-restund.sh

EXPOSE 3478

CMD ["bash", "/restund/start-restund.sh"]

