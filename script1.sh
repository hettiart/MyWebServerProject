#!/bin/bash
#while true
#do
#every 10 seconds ssh to public server/check web server alive if not start
ssh -i kplabs-terraform.pem ec2-user@54.226.64.162
/usr/bin/wget "http://54.226.64.162/" --timeout 30 -O - 2>/dev/null | grep "nginx" && echo "webserver is alive and content verified" || sudo systemctl start nginx && echo "webserver started"
curl -I "http://54.226.64.162/" 2>&1 >> results1.txt
echo "Starting backup process: "
#export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
#export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
aws s3 cp results1.txt s3://nginx-web-server-bucket/
#sleep 10
#done
