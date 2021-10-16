---
layout: post
title:  "Заметки про Debian"
date:   2020-11-27 00:49:40 +0300
categories: open info
---

/etc/apt/source.list:

	deb https://mirror.yandex.ru/debian bullseye main contrib non-free
	deb https://mirror.yandex.ru/debian bullseye-updates main contrib non-free
	deb https://mirror.yandex.ru/debian-security bullseye-security main contrib non-free
	# mephi.ru
	deb http://mirror.mephi.ru/debian bullseye main contrib non-free
	deb http://mirror.mephi.ru/debian bullseye-updates main contrib non-free
	deb http://mirror.mephi.ru/debian-security bullseye-security main contrib non-free

Для netinstall:

	apt-get install vim screen sudo network-manager iptables iptables-persistent htop iotop iftop git
	apt-get install openssh-server
	apt-get install xserver-xorg xinit 
	apt-get install mate-desktop-environment pavucontrol
	apt-get install --no-install-recommends firefox-esr
	apt-get install gparted guake
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
	/dev/sda3 /mnt/win	ntfs-3g rw,windows_names,nosuid,noexec,nodev,permissions,relatime,locale=ru_RU.UTF-8,nofail,dmask=002,fmask=0113,uid=1000,gid=1000 0 

Отключить ctrl-alt-del в консоли:
	
	sudo systemctl mask ctrl-alt-del.target

Отключить пищалку:

	echo 'blacklist pcspkr' >> /etc/modprobe.d/pcspkr.blacklist

Темы Guake описаны в /usr/lib/python3/dist-packages/guake/palettes.py. В настройках оформления выбрать тему как основу, затем переключиться на тему "Дополнительно" и поменять
правую нижнюю палету (Background) на `#2D0922`, правую верхнюю на `#ECF0F1`.

Системное время брать из аппаратных часов:

	hwclock -w --localtime
	ln -sf /usr/share/zoneinfo/Europe/Moscow  /etc/localtime
	timedatectl



Virtualbox:

	apt-get install binutils gcc linux-headers-amd64 make
	./VirtualBox-6.1.26-145957-Linux_amd64.run	

Обновить конфиг пакета:

	apt-get -o DPkg::options::=--force-confmiss --reinstall install bluez

Сетевой интерфейс eth0, выключение экрана консоли через 5 мин /etc/default/grub:

	GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0 consoleblank=300"

Включение WOL: <https://wiki.archlinux.org/title/Wake-on-LAN>
	
	ethtool eth0 | grep -i wake
	ethtool -s eth0 wol g
	
/etc/network/interfaces:
	
	auto br0
	iface br0 inet dhcp
		bridge_ports eth0
		#bridge_hw eth0
		#bridge_stp off
		bridge_fd 0
		bridge_maxwait 0
		post-up ethtool -s eth0 wol g

NetworkManager:
	
	nmcli con show HASH_ID | grep wake
	nmcli con modify HASH_ID 802-3-ethernet.wake-on-lan magic
	Сделать 2 перезагрузки.

Виртуальный диск RAW:

	fallocate -l 12G test.img
	mkfs.ext4 test.img
	mount -o loop test.img /mnt

Уменьшить RAW диск:
	
	resize2fs -M test.img
	gparted test.img
	