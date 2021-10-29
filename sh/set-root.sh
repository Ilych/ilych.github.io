#!/bin/bash

chmod o-rx -vR /home/nik

echo -e 'vm.swappiness=5\nvm.vfs_cache_pressure=10' >> /etc/sysctl.conf
sysctl --system

# if name to eth0
ifname=$(ip l | sed -nr '/pfifo_fast/{s/^.: (.{5,10}): .*/\1/p;q}')
ip link set $ifname down
ip link set $ifname name eth0

sed -ir '/GRUB_CMDLINE_LINUX=""/{/\#/!{s/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0 consoleblank=300"/}}' 
grep -H 'GRUB_CMDLINE_LINUX="' /etc/default/grub
update-grub

echo -e '\nauto eth0\niface eth0 inet dhcp\n' >> /etc/network/interfaces


