#!/bin/bash
if ssh -i "kplabs-terraform.pem ec2-user@54.226.64.162"
then
/usr/bin/wget "http://54.226.64.162/" --timeout 30 -O - 2>/dev/null | grep "nginx" && echo "webserver is alive and content verified"
else
sudo sudo service nnginx start && echo "webserver started"
fi
#curl -I "http://54.226.64.162/" 2>&1 >> results11.txt
#echo "Starting backup process: "
#aws s3 cp results11.txt s3://nginx-web-server-bucket/