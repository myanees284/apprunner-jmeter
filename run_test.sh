#!/bin/bash -e
yum -y install nc
rName=$(date +%F)_$(date +%s)
echo "*******************Downloading JMeter*******************"
curl -L --silent https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.5.tgz > /tmp/apache-jmeter-5.5.tgz
yum -y install tar
tar -xzf /tmp/apache-jmeter-5.5.tgz -C /opt
export JMETER_HOME=/opt/apache-jmeter-5.5
export JMETER_BIN=${JMETER_HOME}/bin
export PATH=$PATH:$JMETER_BIN
echo "*******************Starting load test*******************"
jmeter -n -t $1.jmx -l $1_result.csv -e -o $1
echo "*******************Test Complete*******************"
mv $1_result.csv $1/
yum install awscli -y
echo "*******************Copying Results into S3 bucket*******************"
aws s3 cp $1/ s3://loveisair/$1-$rName-html-report --recursive
while true; do { \
  echo -ne "HTTP/1.0 200 OK\r\nContent-Length: $(wc -c <index.html)\r\n\r\n"; \
  cat index.html; } | nc -l -p 8080 ; \ 
done &
