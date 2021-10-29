#!/bin/bash
# this script is used to configure zram

sudo apt install -y zram-config util-linux
totalmem=`LC_ALL=C free | grep -e "^Mem:" | sed -e 's/^Mem: *//' -e 's/  *.*//'`

#if ram is less than 2 GB blocks will be of 256 MB
if [ $totalmem -lt 2500000] ; then 
    MEMORY_BLOCK= 256
else
    MEMORY_BLOCK= 512
fi

sudo sed -i 's/) * 1024 )/) * ${MEMORY_BLOCK} )/g' /usr/bin/init-zram-swapping # change the default size of zram to 512MB

#TODO: calculate a right size block for actual system memory 
#TODO: check system cpu and determine if use zstd or lzo as compression system

# set compress algorithm to zstd before the disksize is set
sudo sed '/^echo $mem .*/i echo zstd > /sys/block/zram${DEVNUMBER}/comp_algorithm' /usr/bin/init-zram-swapping

sudo echo "vm.vfs_cache_pressure=500" >> /etc/sysctl.conf
sudo echo "vm.swappiness=100" >> /etc/sysctl.conf
sudo echo "vm.dirty_background_ratio=1" >> /etc/sysctl.conf
sudo echo "vm.dirty_ratio=50" >> /etc/sysctl.conf
sudo echo "vm.page-cluster=0" >> /etc/sysctl.conf

notify-send 'zram impostata!'
