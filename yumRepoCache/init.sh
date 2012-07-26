#!/bin/sh

#Gestion d'un cache de dépendances
 yum -y install yum-utils createrepo

 # creation du cache
  yumdownloader java-1.6.0-openjdk-devel git ksh rpm-build createrepo
  
# Construire les meta pour le repo
createrepo -d .
