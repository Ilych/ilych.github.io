---
layout: post
title:  "Заметки про Debian"
date:   2021-08-20 00:49:40 +0300
categories: open info
---

Настройки

	wget ilych.github.io/files/conf.tg
	./conf/set-user.sh


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
 
Включить своп при 3% свободной памяти, сброс дискового кэша <https://habr.com/ru/post/458860/>

/etc/sysctl.conf:

	vm.swappiness=3
	vm.vfs_cache_pressure=10
	vm.dirty_background_bytes = 64001000
	vm.dirty_bytes = 128001000
	

Применить изменения без перезагрузки:
	
	sysctl --system

swap как файл:
	
	fallocate -l 8G /var/swapfile; mkswap /var/swapfile; chmod 600 /var/swapfile; swapon /var/swapfile; 
	echo -e '#swap\n/var/swapfile none swap sw 0 0' >> /etc/fstab
	
	vim /etc/initramfs-tools/conf.d/resume
	RESUME=UUID=1120fd83-f310-4449-8d2e-677713c9d9dd
	sudo update-initramfs -u

Статья на habr [В защиту swap'а [в Linux]: распространенные заблуждения](https://habr.com/ru/company/flant/blog/348324/)

Монтирование ntfs:

	#win
	/dev/sda3 /mnt/win	ntfs-3g rw,windows_names,nosuid,noexec,nodev,permissions,relatime,locale=ru_RU.UTF-8,nofail,dmask=002,fmask=0113,uid=1000,gid=1000 0 

### Консоль 

Изменить разрешение консоли tty без перезагрузки:
	
	sudo fbset -xres 1920 -yres 975
	
/etc/default/grub:
	
	#GRUB_GFXMODE=640x480
	
	GRUB_CMDLINE_LINUX_DEFAULT="splash quiet vga=XXX nomodeset"
	
	Color
	Depth  800x600 1024x768 1152x864 1280x1024 1600x1200
	8  bit vga=771 vga=773  vga=353  vga=775   vga=796
	16 bit vga=788 vga=791  vga=355  vga=794   vga=798
	24 bit vga=789 vga=792  vga=795  vga=799


Отключить ctrl-alt-del в консоли:
	
	sudo systemctl mask ctrl-alt-del.target

Отключить спикер пищалку
inputrc:

	set bell-style none

или

	echo 'blacklist pcspkr' >> /etc/modprobe.d/pcspkr.blacklist

inputrc:
{% highlight bash %}
"\e[5~": history-search-backward
"\e[6~": history-search-forward

# Don't ring bell on completion
set bell-style none

# or, don't beep at me - show me
#set bell-style visible

# Filename completion/expansion
set completion-ignore-case on

# разрывает строку на su -c '', если была нажата комбинация Alt+S
"\es":"\C-a su -c '\C-e'\C-m"
# добавляет в начало команды sudo при нажатии Alt+S
# "\es":"\C-asudo \C-e"
{% endhighlight %}

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
	
Модули ядра: <https://losst.ru/moduli-yadra-linux>
	
	lsmod | hrep iwlwifi
	modprobe -r iwldvm
	modprobe -r iwlwifi
	modprobe iwlwifi
	modprobe iwldvm
	modinfo
	insmod
	rmmod
	
Добавиться в группу:

	newgrp group

GUI xorg:
	
	xhost +local:
	
screen <https://eax.me/screen/>

tmux <https://losst.ru/shpargalka-po-tmux>

cat < /dev/tcp/192.168.88.1/22

dpkg /var/lib/dpkg/info/

apt install ./package.deb
apt-listchanges ./cnijfilter2_5.60-1_amd64.deb
apt changelog package

