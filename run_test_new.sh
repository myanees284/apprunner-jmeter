#!/bin/bash -e
rName=$(date +%F)_$(date +%s)
echo "*******************Downloading JMeter*******************"
curl -L --silent https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.5.tgz > /tmp/apache-jmeter-5.5.tgz
yum -y install tar
tar -xzf /tmp/apache-jmeter-5.5.tgz -C /opt
export JMETER_HOME=/opt/apache-jmeter-5.5
export JMETER_BIN=${JMETER_HOME}/bin
export PATH=$PATH:$JMETER_BIN
export curr_path=${PWD}
echo ${curr_path}
echo "*******************Starting load test*******************"
jmeter -n -t $1.jmx -l $1_result.csv
echo "*******************Test Complete*******************"
tar -czf $1.tar.gz $1_result.csv
curl --location --request PUT 'https://h45evhjgs3.execute-api.us-east-1.amazonaws.com/dev/$2/$rName_test_result.tar.gz' --header 'Content-Type: application/gzip' --data-binary @${curr_path}/$1.tar.gz

# yum install awscli -y
# echo "*******************Copying Results into S3 bucket*******************"
# aws s3 cp $1/ s3://loveisair/$1-$rName-html-report --recursive

yum -y install nc
while true; do { \
  echo -ne "HTTP/1.0 200 OK\r\nContent-Length: $(wc -c <index.html)\r\n\r\n"; \
  cat index.html; } | nc -l -p 8080 ; \ 
done &
rm $0
