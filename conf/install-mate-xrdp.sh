#!/bin/bash

apt-get update \
	&& DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
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
		xorgxrdp \
		xrdp \
	&& apt-get remove mate-desktop-environment -y \
		&& apt-get install mate-desktop-environment -y

wget 'https://ilych.github.io/distr/xrdp-pulseaudio-installer.tgz'

tar -C /var/lib -xvf xrdp-pulseaudio-installer.tgz

sed -i -E 's/^; autospawn =.*/autospawn = yes/' /etc/pulse/client.conf \
    && [ -f /etc/pulse/client.conf.d/00-disable-autospawn.conf ] && sed -i -E 's/^(autospawn=.*)/# \1/' /etc/pulse/client.conf.d/00-disable-autospawn.conf