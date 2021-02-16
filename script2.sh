#!/bin/bash
aws ssm send-command \
	--document-name "AWS-RunShellScript" \
	--targets '[{"Key":"InstanceIds","Values":["i-03377a80bb4152d26"]}]' \
	--parameters '{"commands":["#!/bin/bash","sudo -i","cd /var/log/nginx","tar -czf logs_"`date +"%d-%m-%Y"`".tgz *.gz"]}'
scp -i kplabs-terraform.pem eec2-user@ec2-54-209-117-2.compute-1.amazonaws.com:/var/log/nginx/logs_"`date +"%d-%m-%Y"`".tgz .
aws s3 cp logs_"`date +"%d-%m-%Y"`".tgz *.gz s3://nginx-web-server-bucket/
rm -rf logs_"`date +"%d-%m-%Y"`".tgz