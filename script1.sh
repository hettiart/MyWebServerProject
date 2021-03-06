#!/bin/bash
#ssh to the public server
ssh -i /mnt/c/Users/user/Desktop/Git/kplabs-terraform.pem ec2-user@ec2-34-234-203-145.compute-1.amazonaws.com
#check if the webserver is running & and serving the expected content if not start it
/usr/bin/wget "http://34.234.203.145/" --timeout 30 -O - 2>/dev/null | grep "nginx" && echo "webserver is alive and content verified" || aws ssm send-command --document-name "AWS-RunShellScript" --parameters 'commands=["sudo systemctl start nginx"]' --targets "Key=instanceids,Values=i-03377a80bb4152d26"
#Getting the results of the web to a file along with time stamp
curl -I "http://34.234.203.145/" 2>&1 >> results1.txt
#Backup the results to AWS S3
echo "Starting backup process: "
aws s3 cp  'results1.txt'$'\r' s3://nginx-web-server-bucket/results1.txt