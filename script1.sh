#!/bin/bash
ssh -i kplabs-terraform.pem ec2-user@54.226.64.162
/usr/bin/wget "http://54.226.64.162/" --timeout 30 -O - 2>/dev/null | grep "nginx" || sudo systemctl start nginx 
curl -I "http://54.226.64.162/" 2>&1 >> results1.txt
echo "Starting backup process: "
aws s3 cp results1.txt s3://nginx-web-server-bucket/
