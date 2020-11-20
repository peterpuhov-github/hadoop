#!/bin/bash

set -e               # exit on error

mvn package -Pdist,native -DskipTests -Dtar

tar -xzf hadoop-dist/target/hadoop-3.4.0-SNAPSHOT.tar.gz --directory ~/server/hadoop

ln -s ~/server/hadoop/hadoop-3.4.0-SNAPSHOT ~/server/hadoop/hadoop

# export JAVA_HOME=
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

cd ~/server/hadoop/hadoop
sed -i '/# export JAVA_HOME=/c\export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' etc/hadoop/hadoop-env.sh
cp ~/server/config/core-site.xml etc/hadoop/
cp ~/server/config/hdfs-site.xml etc/hadoop/

mkdir -p /opt/volume/datanode
mkdir -p /opt/volume/namenode

bin/hdfs namenode -format