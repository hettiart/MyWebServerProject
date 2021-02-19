Create a script for webstart as below in ec2

[root@ip-172-31-70-240 ~]# cat webstart.sh
#!/bin/bash
systemctl start nginx
[root@ip-172-31-70-240 ~]# 

create an entry as below in crontab to start nginx webserver at 9.00 AM on weekdays

[root@ip-172-31-70-240 ~]# crontab -l
#nginx web server start at 9.00 AM on weekdays
0 9 * * 1-5 /root/webstart.sh
