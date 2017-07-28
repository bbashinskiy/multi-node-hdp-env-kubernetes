#!/bin/bash
#Commentd because:
#Note: Many tools used to edit files including vi and sed --in-place may result in an inode change. 
#Since Docker v1.1.0, this will produce an error such as "sed: cannot rename ./sedKdJ9Dy: Device or resource busy". 
#In the case where you want to edit the mounted file, it is often easiest to instead mount the parent directory.
#sed -i 's/'$hostname'.hdp-master.default.svc.cluster.local\t//g' /etc/hosts
domain=`echo $HOSTNAME|awk -F '-[0-9]+' '{print $1}'`
sed 's/'$HOSTNAME'.'$domain'.default.svc.cluster.local\t//g' /etc/hosts > /etc/hosts.tmp
/bin/cp /etc/hosts.tmp /etc/hosts && rm /etc/hosts.tmp
ambari-agent start
