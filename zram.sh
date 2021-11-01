#!/bin/bash
# this script is used to configure zram

sudo apt install -y zram-config util-linux
totalmem=`LC_ALL=C free | grep -e "^Mem:" | sed -e 's/^Mem: *//' -e 's/  *.*//'`

#if ram is less than 2 GB blocks will be of 256 MB
if [ $totalmem -lt 3500000 ] ; 
then 
    MEMORY_BLOCK=512
elif [ $totalmem -lt 2500000 ] ;
then
    MEMORY_BLOCK=256
else
    MEMORY_BLOCK=1024
fi

sudo sed -i 's/) * 1024 )/) * ${MEMORY_BLOCK} )/g' /usr/bin/init-zram-swapping # change the default size of zram to 512MB

#TODO: check system cpu and determine if use zstd or lzo as compression system

# set compress algorithm to zstd before the disksize is set
sudo sed '/^echo zstd > /sys/block/zram${DEVNUMBER}/comp_algorithm.*/i echo $mem' /usr/bin/init-zram-swapping

OPTIONS = ("vm.vfs_cache_pressure=500" "vm.swappiness=100" "vm.dirty_background_ratio=1" "vm.dirty_ratio=50" "vm.page-cluster=0")

for s in ${OPTIONS[@]} ; do
    sudo echo $s >> /etc/sysctl.conf
done 

notify-send 'zram impostata!'
