#!/bin/bash -e
yum -y install httpd
httpd
sleep 5
curl localhost:80
echo $1
