FROM alpine

RUN apk --update add \
bash build-base clang \
openssl-dev util-linux-dev libwebsockets-dev openssl

ENV SRC_DIR /usr/local/src
ENV MOSQ_DIR ${SRC_DIR}/mosquitto-1.4.14
WORKDIR ${SRC_DIR}
RUN mkdir -p ${SRC_DIR}    
RUN wget http://mosquitto.org/files/source/mosquitto-1.4.14.tar.gz -P ${SRC_DIR}
RUN tar xf ${SRC_DIR}/mosquitto-1.4.14.tar.gz -C ${SRC_DIR}
RUN cd ${MOSQ_DIR} && make WITH_WEBSOCKETS=yes WITH_SRV=no
RUN cp ${MOSQ_DIR}/src/mosquitto /usr/local/bin/
RUN mkdir -p /etc/mosquitto/certs
COPY mosquitto.conf /etc/mosquitto
COPY server.crt server.key ca.crt /etc/mosquitto/certs/ 

ENV AUTH_DIR ${SRC_DIR}/mosquitto-auth-plug-master
RUN wget https://github.com/jpmens/mosquitto-auth-plug/archive/master.zip  -P ${SRC_DIR}
RUN cd ${SRC_DIR} && unzip master.zip
RUN apk del openssl-dev
RUN apk add mysql-dev 
RUN cd ${AUTH_DIR} && cp config.mk.in config.mk
RUN sed -i 's/BACKEND_MYSQL ?= no/BACKEND_MYSQL ?= yes/' ${AUTH_DIR}/config.mk
RUN sed -i 's/MOSQUITTO_SRC =/MOSQUITTO_SRC = \/usr\/local\/src\/mosquitto-1\.4\.14/' ${AUTH_DIR}/config.mk
RUN cat ${AUTH_DIR}/config.mk
RUN cd ${AUTH_DIR} && make
RUN cp ${AUTH_DIR}/auth-plug.so /usr/local/lib/

EXPOSE 8883
CMD ["/usr/local/bin/mosquitto", "-c", "/etc/mosquitto/mosquitto.conf"]

