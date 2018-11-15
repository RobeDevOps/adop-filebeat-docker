FROM docker.elastic.co/beats/filebeat:6.4.3

LABEL MAINTAINER="roberto cardenas" 
LABEL MAINTAINER_EMAIL="rcardenas20@gmail.com"

ENV FILEBEAT_HOME /usr/share/filebeat

USER root
RUN rm -Rf ${FILEBEAT_HOME}/modules.d
USER filebeat
ADD ./config/filebeat.yml ${FILEBEAT_HOME}/filebeat.yml
USER root

ADD  entrypoint.sh /entrypoint.sh
RUN  chmod +x /entrypoint.sh

ENTRYPOINT  ["/entrypoint.sh"]
CMD ["start"]