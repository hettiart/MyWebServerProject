#!/bin/bash
ssh -i "kplabs-terraform.pem" ec2-user@ec2-54-209-117-2.compute-1.amazonaws.com
/usr/bin/wget "http://54.209.117.2/" --timeout 30 -O - 2>/dev/null | grep "nginx" || sudo systemctl start nginx 
curl -I "http://54.209.117.2/" 2>&1 >> results1.txt
echo "Starting backup process: "
aws s3 cp results1.txt s3://nginx-web-server-bucket/
