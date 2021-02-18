#!/bin/bash
#Create one compressed file from the daily logs
aws ssm send-command --document-name "AWS-RunShellScript" --targets '[{"Key":"InstanceIds","Values":["i-03377a80bb4152d26"]}]' --parameters '{"commands":["#!/bin/bash","sudo -i","cd /var/log/nginx","tar -czf logs.tgz *.gz"]}'
#Move the compressed file to the same location as script is running
#scp -i kplabs-terraform.pem root@ec2-54-209-117-2.compute-1.amazonaws.com:/var/log/nginx/logs.tgz .
#ssh -i kplabs-terraform.pem root@i-03377a80bb4152d26
scp -i kplabs-terraform.pem root@i-03377a80bb4152d26:/var/log/nginx/logs.tgz .
#Rename the compressed log file with timestamps
mv logs.tgz logs_"`date +"%d-%m-%Y"`".tgz
#Upload compressed log file to AWS S3
aws s3 cp logs_"`date +"%d-%m-%Y"`".tgz s3://nginx-web-server-bucket/
#Remove the log file
rm -rf logs_"`date +"%d-%m-%Y"`".tgz