#!/bin/bash -e
yum update -y
yum install awscli -y
aws --version
aws s3 ls
