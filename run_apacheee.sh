#!/bin/bash -e
yum -y install httpd
service httpd start
sleep 5
curl localhost:80
