FROM docker.elastic.co/beats/filebeat:6.4.3

LABEL MAINTAINER="roberto cardenas"
LABEL MAINTAINER_EMAIL="rcardenas20@gmail.com"

ENV FILEBEAT_HOME /usr/share/filebeat
ADD filebeat.yml ${FILEBEAT_HOME}/filebeat.yml

USER root
RUN chown root:filebeat ${FILEBEAT_HOME}/filebeat.yml
RUN chmod go-w /usr/share/filebeat/filebeat.yml
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT  ["/entrypoint.sh"]
CMD ["start"]
