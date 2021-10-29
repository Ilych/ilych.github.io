#!/bin/bash

apt-get update \
	&& DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
		dbus-x11 \
		firefox \
		git \
		pavucontrol \
		pulseaudio \
		pulseaudio-utils \
		x11-xserver-utils \
		mate-desktop-environment \
		guake \
		mpg123
		
apt-get remove mate-desktop-environment -y \
	&& apt-get install mate-desktop-environment -y
