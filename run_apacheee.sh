#!/bin/bash -e
yum -y install httpd
httpd
sleep 5
curl -s -o /dev/null -w "The status code is %{http_code}" localhost:80
