FROM alpine:3.18.2

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update
RUN apk add --no-cache xvfb fluxbox supervisor bash wqy-zenhei openjdk11

ADD supervisord.conf /etc/supervisord.conf
ADD config/microemulator/config2.xml /root/.microemulator/config2.xml
ADD entry.sh /entry.sh
ADD micro micro/

COPY jar/game.jar /data/game.jar
COPY jar/password /data/password 
COPY micro/libvncserver.so.0.9.14 /usr/lib/libvncserver.so.0.9.14
COPY micro/libvncserver.so.1 /usr/lib/libvncserver.so.1
COPY micro/libvncserver.so /usr/lib/libvncserver.so

RUN chmod +x /entry.sh

ENV DISPLAY :0
ENV RESOLUTION=1x1
ENV LD_PRELOAD=/micro/libvncserver.so

EXPOSE 5900

ENTRYPOINT ["/bin/bash", "-c", "/entry.sh"]
