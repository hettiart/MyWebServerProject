#!/bin/bash
#ssh to the public server
ssh -i "kplabs-terraform.pem" ec2-user@ec2-54-209-117-2.compute-1.amazonaws.com
#check if the webserver is running & and serving the expected content if not start it
/usr/bin/wget "http://54.209.117.2/" --timeout 30 -O - 2>/dev/null | grep "nginx" || sudo systemctl start nginx
#Getting the results of the web to a file along with time stamp
curl -I "http://54.209.117.2/" 2>&1 >> results1.txt
#Backup the results to AWS S3
echo "Starting backup process: "
aws s3 cp results1.txt s3://nginx-web-server-bucket/
