#!/bin/sh
ES_URL=https://github.com/downloads/elasticsearch/elasticsearch
ES_VERSION="0.19.8"
ES_ROOT="elasticsearch-${ES_VERSION}"
ES_PACKAGE="${ES_ROOT}.zip"
ES_DIR="Server"
if [ ! -d "$ES_DIR" ] ; then
  echo "Creation du répertoire pour ES ${ES_DIR}"
  mkdir -p ${ES_DIR}
fi
ES_DWNL_DEST="$ES_DIR/$ES_PACKAGE"
if [ ! -s "$ES_DWNL_DEST" ]; then
  echo "Downloading $ES_DWNL_DEST"
  wget --no-check-certificate -O "$ES_DWNL_DEST" "$ES_URL/$ES_PACKAGE"
  echo "installing ES"
  unzip -d ${ES_DIR} ${ES_DWNL_DEST}
  echo "installing ES-HEAD UI"
  "$ES_DIR/$ES_ROOT/bin/plugin" -install mobz/elasticsearch-head
else
  echo "ElasticSearch ${ES_VERSION} already downloaded"
fi

echo "Pour lancer ElasticSearch : $ES_DIR/$ES_ROOT/bin/elasticsearch -f"
echo "Pour accéder à l'UI : http://localhost:9200/_plugin/head/"
echo "Pour accéder à Elasticsearch : http://localhost:9200/"
