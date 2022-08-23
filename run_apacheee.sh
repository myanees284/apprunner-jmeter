#!/bin/bash -e
yum -y install httpd
httpd -k start
sleep 5
echo "--------"apache server started--------"
