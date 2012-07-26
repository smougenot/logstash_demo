#!/bin/sh
echo "Lancement d'ElasticSearch"
nohup ./elasticsearch-*/bin/elasticsearch -f > elasticsearch.log 2>&1 &
