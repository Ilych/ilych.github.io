---
layout: post
title:  "Заметки про Debian"
date:   2020-11-27 00:49:40 +0300
categories: open info
---

/etc/apt/source.list:

	deb https://mirror.yandex.ru/debian/ bullseye main contrib non-free
	deb https://mirror.yandex.ru/debian/ bullseye-updates main contrib non-free

Для netinstall:

	apt-get install vim screen sudo network-manager iptables iptables-persistent htop iotop iftop git
	apt-get install openssh-server
	apt-get install xserver-xorg xinit 
	apt-get install mate-desktop-environment 
	apt-get install gparted pavucontrol guake firefox-esr
	apt-get install ntfs-3g 
	apt-get install mc netcat socat

VirtualBox Guest Additions kernel headers and build tools:	

	apt install build-essential dkms linux-headers-$(uname -r)

Драйвер Nvidia:

	apt install nvidia-driver firmware-misc-nonfree 

Защитить права хомяка:

	chmod o-rx -R /home/nik

Сделать бекап:
	
	tar -cvzpf /media/bkp/$(hostname)_root_$(date +%F_%H-%M).tgz --one-file-system --exclude=home/nik/Загрузки/ --exclude=/home/nik/.cache --exclude=/mnt --exclude=/media --exclude=/tmp /

Залить конфиги:

	git clone https://gitlab.com/Ilichev/myconf.git
 
Включить своп при 5% свободной памяти:

	echo -e 'vm.swappiness=5\nvm.vfs_cache_pressure=10' >> /etc/sysctl.conf

Применить изменения без перезагрузки:
	
	sysctl --system

swap как файл:
	
	fallocate -l 8G /var/swapfile; mkswap /var/swapfile; chmod 600 /var/swapfile; swapon /var/swapfile; 
	echo -e '#swap\n/var/swapfile none swap sw 0 0' >> /etc/fstab

Монтирование ntfs:

	#win
	/dev/sda3 /mnt/win	ntfs-3g rw,nosuid,noexec,nodev,permissions,relatime,locale=ru_RU.UTF-8,nofail,dmask=002,fmask=0113,uid=1000,gid=1000 0 

Отключить ctrl-alt-del в консоли:
	
	sudo systemctl mask ctrl-alt-del.target

Отключить пищалку:

	echo 'blacklist pcspkr' >> /etc/modprobe.d/pcspkr.blacklist

Темы Guake описаны в /usr/lib/python3/dist-packages/guake/palettes.py. В настройках оформления выбрать тему как основу, затем переключиться на тему "Дополнительно" и поменять
правую нижнюю палету (Background) на `#2D0922`, правую верхнюю на `#ECF0F1`.

Virtualbox:

	apt-get install binutils gcc linux-headers-amd64 make
	./VirtualBox-6.1.26-145957-Linux_amd64.run	

Обновить конфиг пакета:

apt-get -o DPkg::options::=--force-confmiss --reinstall install bluez

