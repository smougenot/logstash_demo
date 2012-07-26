#!/bin/sh


JK_URL="http://mirrors.jenkins-ci.org/war/latest"
JK_PACKAGE="jenkins.war"
JK_DIR="Server"
if [ ! -d "$JK_DIR" ] ; then
  echo "Creation du r�pertoire pour Jenkins ${JK_DIR}"
  mkdir -p ${JK_DIR}
fi
JK_DWNL_DEST="$JK_DIR/$JK_PACKAGE"
if [ ! -s "$JK_DWNL_DEST" ]; then
  echo "Downloading $JK_DWNL_DEST"
  wget --no-check-certificate -O "$JK_DWNL_DEST" "$JK_URL/$JK_PACKAGE"
else
  echo "Jenkins d�j� pr�sent $JK_DIR/$JK_PACKAGE"
fi

echo "Pour lancer jenkins : $JK_DIR/jenkins.sh"
echo "Pour acc�der � l'UI : http://localhost:8080/"
