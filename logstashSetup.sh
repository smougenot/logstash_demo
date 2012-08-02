#!/bin/sh

LS_VERSION="1.1.1"
if [ $# -gt 0 ]; then
  LS_VERSION=$1
fi
echo "Récupération de logstash ${LS_VERSION}"
LS_PACKAGE="logstash-${LS_VERSION}-monolithic.jar"
LS_URL="http://semicomplete.com/files/logstash"
LS_DIR="logstash"
LS_DWNL_DEST="$LS_DIR/$LS_PACKAGE"
if [ ! -s "$LS_DWNL_DEST" ]; then
  echo "Downloading $LS_DWNL_DEST"
  wget --no-check-certificate -O "$LS_DWNL_DEST" "$LS_URL/$LS_PACKAGE"
else
  echo "Logstash ${LS_VERSION} déjà présent"
fi

echo "Pour lancer l'UI logstash : ${LS_DIR}/logstash_web.sh"
echo "Pour lancer l'agent logstash : ${LS_DIR}/logstash_agent.sh"
echo "Pour accéder à l'UI : http://localhost:9292"
