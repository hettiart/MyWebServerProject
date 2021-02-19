Webserver stop script should be script as below

[root@ip-172-31-70-240 ~]# cat webstop.sh
#!/bin/bash
systemctl stop nginx
[root@ip-172-31-70-240 ~]#

Cronjob entry should be wriiten as below

#nginx web server stop at 5.00 PM on weekdays
0 17 * * 1-5 /root/webstop.sh
[root@ip-172-31-70-240 ~]#
