#!/bin/sh
echo "Lancement de Jenkins"
nohup java -jar jenkins.war > jenkins.log 2>&1 &
