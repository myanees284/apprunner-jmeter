#!/bin/bash -e

# Setting up dummy server just to make the AWS App Runner service to be created successfully
yum -y install nc
while true; do { echo -e 'HTTP/1.1 200 OK\r\n'; echo "Hello World"; } | nc -l 8080; done &
rm $0

rName=$(date +%F)_$(date +%s)
echo "*******************Downloading JMeter*******************"
curl -L --silent https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.5.tgz > /tmp/apache-jmeter-5.5.tgz
yum -y install tar
tar -xzf /tmp/apache-jmeter-5.5.tgz -C /opt

export JMETER_HOME=/opt/apache-jmeter-5.5
export JMETER_BIN=${JMETER_HOME}/bin
export PATH=$PATH:$JMETER_BIN
export curr_path=${PWD}

echo "*******************Starting load test*******************"
jmeter -n -t $1.jmx -l $1_${rName}_result.csv
echo "*******************Test Complete*******************"

# Copying test results to S3 bucket using AWS CLI command - Option-1
yum install awscli -y
echo "*******************Copying Results into S3 bucket*******************"
aws s3 cp $1_${rName}_result.csv s3://$2/$1_${rName}_result.csv

# Copying test results to S3 bucket using AWS API Gateway service - Option-2
# tar -czf $1.tar.gz $1_${rName}_result.csv
# echo "*******************Copying Results into S3 bucket*******************"
# curl --location --request PUT https://<AP_GATEWAY_STAGE_URL>$2/${rName}_test_result.tar.gz --header 'Content-Type: application/gzip' --data-binary @${curr_path}/$1.tar.gz
