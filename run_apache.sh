#!/bin/bash -e
yum -y install httpd
/usr/sbin/httpd
curl google.com
