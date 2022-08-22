#!/usr/bin/env bash
yum -y install nc
while true; do { \
  echo -ne "HTTP/1.1 200 OK\r\n"; \
  echo "Hello World" } | nc -l -p 8080 ; \ 
done
