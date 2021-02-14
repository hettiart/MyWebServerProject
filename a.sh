#!/bin/bash
ssh -i kplabs-terraform.pem ec2-user@54.226.64.162
if /usr/bin/wget "http://54.226.64.162/" --timeout 30 -O - 2>/dev/null | grep "nginx";
then
echo "webserver is alive and content verified"
else
sudo systemctl start nginx && echo "webserver started"
fi
curl -I "http://54.226.64.162/" 2>&1 >> results1.txt
echo "Starting backup process: "
aws s3 cp results1.txt s3://nginx-web-server-bucket/
