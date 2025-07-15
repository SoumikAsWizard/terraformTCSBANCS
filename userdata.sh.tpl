#!/bin/bash
mkfs -t ext4 /dev/xvdf
mkdir -p /app
echo "/dev/xvdf /app ext4 defaults,nofail 0 2" >> /etc/fstab
mount -a

yum install -y amazon-efs-utils
mkdir -p /mnt/efs
echo "${efs_dns}:/ /mnt/efs efs defaults,_netdev 0 0" >> /etc/fstab
mount -a
