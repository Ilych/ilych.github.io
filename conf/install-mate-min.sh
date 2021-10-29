#!/bin/bash

apt-get update \
&& { apt-get install -y --no-install-recommends \
		dbus-x11 \
		firefox-esr \
		git \
		pavucontrol \
		pulseaudio \
		pulseaudio-utils \
		x11-xserver-utils \
		mate-desktop-environment \
		guake \
		mpg123 \
		openssh-server \
	
	apt-get remove mate-desktop-environment -y && apt-get install mate-desktop-environment xinit -y
	
	# VBGA
	apt-get -y install build-essential dkms linux-headers-$(uname -r)
	
}

