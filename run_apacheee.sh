#!/bin/bash -e
yum -y install httpd
httpd -k start
sleep 5
curl localhost:80
