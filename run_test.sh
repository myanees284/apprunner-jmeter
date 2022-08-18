#!/bin/bash -e
curl -L --silent https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.5.tgz > /tmp/apache-jmeter-5.5.tgz
yum -y install tar
tar -xzf /tmp/apache-jmeter-5.5.tgz -C /opt
export JMETER_HOME=/opt/apache-jmeter-5.5
export JMETER_BIN=${JMETER_HOME}/bin
export PATH=$PATH:$JMETER_BIN
export PATH=$PATH:$JMETER_BIN
echo jmeter -n -t $1.jmx -l $1.csv -e -o $1
#jmeter -n -t my_test.jmx -l $1.csv -e -o $1
#mv my_test.csv my_test/
#yum -y install httpd
#/usr/sbin/httpd
