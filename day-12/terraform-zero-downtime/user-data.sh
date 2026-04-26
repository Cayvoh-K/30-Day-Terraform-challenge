#!/bin/bash

yum update -y
yum install -y python3

cd /home/ec2-user

echo "Hello World v1 - $(hostname)" > index.html

nohup python3 -m http.server 80 &