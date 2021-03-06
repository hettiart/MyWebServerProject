#!/bin/bash
#Create one compressed file from the daily logs
aws ssm send-command --document-name "AWS-RunShellScript" --targets '[{"Key":"InstanceIds","Values":["i-03377a80bb4152d26"]}]' --parameters '{"commands":["#!/bin/bash","sudo -i","cd /var/log/nginx","tar -czf logs.tgz *.gz"]}'
#Move the compressed file to the same location as script is running
scp -i kplabs-terraform.pem root@i-03377a80bb4152d26:/var/log/nginx/logs.tgz /mnt/c/Users/user/Desktop/Git/logs.tgz
#Upload compressed log file to AWS S3
aws s3 cp '/mnt/c/Users/user/Desktop/Git/logs.tgz'$'\r' s3://nginx-web-server-bucket/logs.tgz
#Remove the log file after S3 copy
rm '/mnt/c/Users/user/Desktop/Git/logs.tgz'$'\r'
