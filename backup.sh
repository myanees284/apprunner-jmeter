#!/bin/bash -e
yum update -y
yum install awscli -y
curl -L --silent https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.5.tgz > /tmp/apache-jmeter-5.5.tgz
yum -y install tar
tar -xzf /tmp/apache-jmeter-5.5.tgz -C /opt
export JMETER_HOME=/opt/apache-jmeter-5.5
export JMETER_BIN=${JMETER_HOME}/bin
export PATH=$PATH:$JMETER_BIN
export PATH=$PATH:$JMETER_BIN
echo jmeter -n -t $1.jmx -l $1_result.csv -e -o $1
jmeter -n -t my_test.jmx -l $1_result.csv -e -o $1
mv $1_result.csv $1/
aws s3 cp $1/ s3://loveisair/$1-html-report --recursive
yum -y install httpd #dummy step
httpd #dummy step
