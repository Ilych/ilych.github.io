---
layout: post
title:  "Заметки про Debian"
date:   2021-08-20 00:49:40 +0300
categories: open info
tags: linux
---

Настройки

	wget ilych.github.io/files/conf.tgz
	./conf/set-user.sh
	wget ilych.github.io/files/icons_mytheme.tar.gz
	wget ilych.github.io/files/themes_myMenta.tar.gz

Образы

	UPDATE 10 Jun 2023: As of Debian 12 (Bookworm), firmware is included in the normal Debian installer images.
	https://gemmei.ftp.acc.umu.se/debian-cd/current/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso
	https://mirror.accum.se/debian-cd/current/amd64/iso-cd/SHA256SUMS
	https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/
	https://cdimage.debian.org/cdimage/firmware/

/etc/apt/source.list:

	# mephi.ru 12
	deb http://mirror.mephi.ru/debian bookworm main contrib non-free non-free-firmware
	deb http://mirror.mephi.ru/debian bookworm-updates main contrib non-free non-free-firmware
	deb http://mirror.mephi.ru/debian-security bookworm-security main contrib non-free non-free-firmware
	deb http://mirror.mephi.ru/debian bookworm-backports main contrib non-free non-free-firmware
	# mephi.ru 11
	deb http://mirror.mephi.ru/debian bullseye main contrib non-free
	deb http://mirror.mephi.ru/debian bullseye-updates main contrib non-free
	deb http://mirror.mephi.ru/debian-security bullseye-security main contrib non-free
	deb http://mirror.mephi.ru/debian bullseye-backports main contrib non-free 


Для netinstall:

	apt-get install vim screen sudo network-manager iptables iptables-persistent htop iotop iftop git
	apt-get install openssh-server
	apt-get install xserver-xorg xinit 
	apt-get install mate-desktop-environment pavucontrol
	apt-get install dconf-editor dconf-cli network-manager-gnome
	apt-get install gnome-firmware mate-time-admin mate-power-statistics mate-system-log libnotify-bin
	apt-get install --no-install-recommends firefox-esr
	apt-get install gparted guake curl
	apt-get install ntfs-3g 
	apt-get install mc netcat socat

Не отключаться при закрытии крышки

	/etc/systemd/logind.conf:
	HandleLidSwitch=ignore

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

   # 12309: 
   vm.overcommit_memory=2 
   vm.overcommit_ratio=200


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

Тема mate-terminal:

	полужирный, без гудка, Скопировать выделенный, подчёркнутый, 125 x 25
	monospace regular 11
	Цвет текста: #ECF0F1
	Цвет текста: #2D0922
	Прокрутка: 100000
	Комбинации: -F10 -F1

Перетаскивание окон по Alt marco:

	dconf-editor: 
	/org/mate/marco/general/mouse-button-modifier <Alt> -> <Super>

mate-panel:

	echo -e "[/]\nfont-family='Liberation Sans Narrow 24'\nforeground-color='238 238 236'" | dconf load /org/mate/desktop/peripherals/keyboard/indicator/ 
	dconf dump /org/mate/desktop/peripherals/keyboard/indicator/


Системное время брать из аппаратных часов:

	hwclock -w --localtime
	ln -sf /usr/share/zoneinfo/Europe/Moscow  /etc/localtime
	timedatectl



Virtualbox:

	apt-get install binutils gcc linux-headers-amd64 make
	./VirtualBox-6.1.26-145957-Linux_amd64.run	

### apt
``` text
Обновить конфиг пакета:

apt-get -o DPkg::options::=--force-confmiss --reinstall install bluez

Удаление пакета без учёта зависимостей
sudo dpkg --ignore-depends=network-manager-gnome -r network-manager

apt install ./package.deb

apt-listchanges ./package.deb
apt changelog package
```
#### Пересборка бинарного deb пакета
убрать ошибку отсутствующих зависимостей apt --fix-broken install 

``` bash
dpkg-deb -x package.deb package
dpkg-deb -e package.deb package/DEBIAN
vim package/DEBIAN/control
dpkg-deb --build package

# зафиксировать версию пакета
apt-mark hold package
  unhold showhold 

# распаковка deb как архива 
ar xv --output=zoom ./zoom_amd64.deb
```
dpkg /var/lib/dpkg/info/

Сетевой интерфейс eth0, выключение экрана консоли через 5 мин /etc/default/grub:

	GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0 consoleblank=300"

Включение WOL: <https://wiki.archlinux.org/title/Wake-on-LAN>
	
	ethtool eth0 | grep -i wake
	ethtool -s eth0 wol g
	
/etc/network/interfaces:
	
	auto eth0
	iface eth0 inet manual

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
  
  modprobe -c
  /lib/modules
  /lib/modules/modules.aliases

disable wifi blinking

	/etc/modprobe.d/wlan.conf:
	options iwlwifi led_mode=1

Зависает при загрузке при установке primus:
  
  Добавить в параметры ядра:
  wmlinuz ... 3

  Изменить порядок загрузки bumblebeed.service, например, после nvidia-persistenced.service:
  [Unit]
  Description=Bumblebee C Daemon
  After=nvidia-persistenced.service

  systemctl daemon-reload
	
Добавиться в группу в новом SHELL:

	newgrp group

GUI xorg:
	
	xhost +local:

X11 connection rejected because of wrong authentication.
Error: Can't open display: localhost:10.0

	export XAUTHORITY=/home/nik/.Xauthority
	
screen <https://eax.me/screen/>

tmux <https://losst.ru/shpargalka-po-tmux>

cat < /dev/tcp/192.168.88.1/22

Отключение IPv6 sysctl.conf

	net.ipv6.conf.br0.disable_ipv6 = 1

Шрифты 

	cp Windows/Fonts/font.ttf ~/.local/share/fonts
	fc-cache -f -v

chmod bits

	01000  sticky bit, restricted deletion
	02000  set-group-ID
	04000  set-user-ID
	00100  execute/search by owner
	00200  write by owner
	00400  read by owner

pluma admin:///etc/fonts/local.conf

Проверка на spectre/meltdown
  
	git clone https://github.com/speed47/spectre-meltdown-checker.git
	./spectre-meltdown-checker.sh --disclaimer
	sudo spectre-meltdown-checker.sh

Разные программы
  
	zerofree - finds the unallocated blocks with non-zero value content in and fills them with zeroes.
	ncdu     - is a ncurses-based du viewer.
	plocate mlocate

fstab

	#swap
	/var/swapfile none swap sw 0 0

	#win
	/dev/sda7 /mnt/media	ntfs-3g rw,windows_names,nosuid,noexec,nodev,permissions,relatime,locale=ru_RU.UTF-8,nofail,dmask=002,fmask=0113,uid=1000,gid=1000 0

	# ext_media
	UUID="5a7d969f-ca30-478f-b254-1669fabf2da1" /mnt/ext	ext4	relatime,errors=remount-ro 0	0

	# TNAS samba
	//tnas.local/smb /mnt/smb cifs	noauto,x-systemd.automount,x-systemd.mount-timeout=10,x-systemd.device-timeout=30,_netdev,x-systemd.idle-timeout=1min,relatime,vers=3.11,nobrl,cred=/home/user/.config/creds/samba.txt,users,noexec,rw,file_mode=0664,uid=user,gid=libvirt-qemu,dir_mode=0775  

systemd automount

	fstab: noauto,x-systemd.automount,x-systemd.mount-timeout=10,x-systemd.device-timeout=30,_netdev,x-systemd.idle-timeout=1min
	systemctl daemon-reload
	systemctl restart remote-fs.target or systemctl restart local-fs.target

bind
 
	bind '"\e[5~": history-search-backward'; bind '"\e[6~": history-search-forward'

Про Debian: <>

Шпаргалка начинающего Debian/Ubuntu администратора по управлению пакетами <https://habr.com/ru/articles/150131/>

# Clipboard
xclip

# Upgrade <https://www.opennet.ru/openforum/vsluhforumID3/130723.html#228>

	Только что обновился, делал так:
	Полностью обновляем систему.

	Меняем source.list 
	И добавляем в него non-free-firmware

	Потом в таком порядке: 
	apt upgrade --without-new-pkgs 
	apt upgrade 
	apt full-upgrade

	На конфликты: 
	apt --fix-broken install

	Если тупо сделать full-upgrade сразу, тогда --fix-broken install не решает. 


set up and control loop devices
	LOOP=$(sudo losetup --show -fP "${IMAGE_FILE}")
	mount ${LOOP}p1 /mnt/tmp

# pulseaudio
ls -l /run/user/1000
pulseaudio --start
start-pulseaudio-x11

# Screen turn off backlight
xset dpms force off
# Turn screen off after 30min inactivity
xset dpms 1800


# SETUID AND SETGID BITS



# Тест дисков sdcard

	_____ SD Card __GB C__ A_

	dmesg | tail
	fdisk -l

	--------------------------------------------------------------------
	ioping -c 20 .


	--------------------------------------------------------------------

	fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=fiotest --filename=testfio --bs=4k --iodepth=64 --size=1G --readwrite=randrw --rwmixread=75

	--------------------------------------------------------------------
	fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=fiotest --filename=testfio --bs=4k --iodepth=64 --size=1G --readwrite=randread

	--------------------------------------------------------------------
	fio --name=randwrite --ioengine=libaio --iodepth=1 --rw=randwrite --bs=4k --direct=0 --size=1G --numjobs=2 --runtime=240 --group_reporting

	====================================================================================

