#!/bin/bash
CMD=$1
#Control script to start and stop Solr 5 instances form Claudera Manager
case $CMD in
  (start)
    if [ -f /opt/solr/solr/bin/solr.in.sh ];
    then
       mv  /opt/solr/solr/bin/solr.in.sh  /opt/solr/solr/bin/solr.in.shOLD
    fi
    rm -f /var/solr/solr.in.sh
    echo "SOLR_HOST=\"$(hostname)\"" > /var/solr/solr.in.sh
    #All the parameters should be passed as environnment variable understandable by the Solr 5 scripts
    exec /opt/solr/solr/bin/solr start -f  -V
    ;;
  (stop)
    echo "Stopping Solr  on port $SOLR_PORT"
    /opt/solr/solr/bin/solr stop -p $SOLR_PORT -V
    ;;
  (*)
    echo "Don't understand [$CMD]"
    ;;
esac
