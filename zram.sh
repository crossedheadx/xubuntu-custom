#!/usr/bin/env bash
# this script is used to configure zram
# launch thi script as root and as $ sudo ./zram.sh to not encour in array issue

if [ "$(whoami)" != 'root' ]; then
        echo "Must be root to run $0"
        exit 1;
fi

apt install -y zram-config util-linux
totalmem=$(LC_ALL=C free | grep -e "^Mem:" | sed -e 's/^Mem: *//' -e 's/  *.*//')

#if ram is less than 2 GB blocks will be of 256 MB
if [ "$totalmem" -lt 3500000 ] ; 
then 
    MEMORY_BLOCK=512
elif [ "$totalmem" -lt 2500000 ] ;
then
    MEMORY_BLOCK=256
else
    MEMORY_BLOCK=1024
fi

sed -i "s/1024)/$MEMORY_BLOCK)/g" /usr/bin/init-zram-swapping 

# set compress algorithm to zstd before the disksize is set
sed -i '/echo $mem >/iecho zstd /sys/block/zram${DEVNUMBER}/comp_algorithm' /usr/bin/init-zram-swapping
OPTIONS=("vm.vfs_cache_pressure=500" "vm.swappiness=100" "vm.dirty_background_ratio=1" "vm.dirty_ratio=50" "vm.page-cluster=0")

for s in "${OPTIONS[@]}" ; do
    printf "%s\n" "${s}" >> /etc/sysctl.conf
done 

notify-send 'zram impostata!'
