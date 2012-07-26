#!/bin/sh


JK_URL="http://mirrors.jenkins-ci.org/war/latest"
JK_PACKAGE="jenkins.war"
JK_DIR="Server"
if [ ! -d "$JK_DIR" ] ; then
  echo "Creation du répertoire pour Jenkins ${JK_DIR}"
  mkdir -p ${JK_DIR}
fi
JK_DWNL_DEST="$JK_DIR/$JK_PACKAGE"
if [ ! -s "$JK_DWNL_DEST" ]; then
  echo "Downloading $JK_DWNL_DEST"
  wget --no-check-certificate -O "$JK_DWNL_DEST" "$JK_URL/$JK_PACKAGE"
else
  echo "Jenkins déjà présent $JK_DIR/$JK_PACKAGE"
fi

echo "Pour lancer jenkins : $JK_DIR/jenkins.sh"
echo "Pour accéder à l'UI : http://localhost:8080/"
