#!/bin/sh
echo "starting logstash agent"
java -jar logstash-1.1.1-monolithic.jar agent -f logstash.conf
