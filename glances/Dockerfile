FROM nicolargo/glances:latest
COPY glances.conf /glances/conf/glances.conf
CMD python -m glances -C /home/docker/glances/glances.conf $GLANCES_OPT