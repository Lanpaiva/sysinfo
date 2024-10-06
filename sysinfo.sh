#!/bin/sh
#### Alan A. Paiva ( alanpaiva@ibm.com )
###  release: 06/10/24
#### usage: sudo sh sysinfo.sh
clear
echo .
echo ..OS
head -n1 /etc/issue
# OS release REDHAT
if [ -f /etc/redhat-release ]; then
        cat /etc/redhat-release
fi
# OS release SUSE
if [ -f /etc/os-release ]; then
        grep PRETTY /etc/os-release
fi
echo .
echo ..HOST
export HNAME=`hostname -f`
export HADDR=`ifconfig -a | grep -i inet | grep -i cast | awk '{print "("$1": " $2" " $3": " $4 ")"}'`
echo " Server: "$HNAME" "$HADDR
hostnamectl | grep -v ID | grep -v Icon | grep -v Chassis | grep -v CPE | grep -v Static
echo .
echo ..MEMORIA
grep MemTotal /proc/meminfo
echo .
echo ..CPU
echo "TOTAL CPU :" `grep "model name" /proc/cpuinfo | wc -l` " Core"
echo `grep  "# processors" /proc/cpuinfo` " Core"
grep -m1 "model name" /proc/cpuinfo
grep "vendor_id" /proc/cpuinfo
echo .
echo ..DISKS
# cat /proc/partitions
# fdisk -l |grep '^Disk /dev/' |grep -v '/dev/mapper'
# echo
echo Show all partitions registered on o system
lsblk
# echo ..# df -h
echo .
df -h
# hdparm -i /dev/sda
echo .
echo ..NETWORKs
ip a | grep inet
echo ...
netstat -ar
echo .
echo ..NETPORTS
netstat -tnlp
echo .
echo : /etc/resolv.conf // DNS configuration
cat /etc/resolv.conf | grep -v \#
# echo .
# echo : /etc/hosts // File-based network name resolution
# cat /etc/hosts
echo .
echo ..TIMESYNC
echo .Checking Time Synchronization
timedatectl
echo .
echo ..SELINUX
if [ -f /etc/selinux/config ]; then
        cat /etc/selinux/config
fi
cat /etc/selinux/config
echo .
echo ..USERLIMITS !
cat /etc/security/limits.conf | grep -v \#
echo .
ulimit -a
echo .
# echo .IWS USERS
# grep -i iws /etc/passwd

echo .
echo DONE !!
## fim do arquivo
