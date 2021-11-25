#!/bin/bash

module_dir="$1"

/usr/bin/mkdir -vp '/usr/lib/pulse-14.2/modules'
install -v -c "$module_dir/module-xrdp-sink.so" /usr/lib/pulse-14.2/modules
install -v -c "$module_dir/module-xrdp-sink.la" /usr/lib/pulse-14.2/modules
install -v -c "$module_dir/module-xrdp-source.so" /usr/lib/pulse-14.2/modules
install -v -c "$module_dir/module-xrdp-source.la" /usr/lib/pulse-14.2/modules
ldconfig -vn '/usr/lib/pulse-14.2/modules'

/usr/bin/mkdir -vp '/usr/libexec/pulseaudio-module-xrdp'
/usr/bin/install -v -c "$module_dir/load_pa_modules.sh" '/usr/libexec/pulseaudio-module-xrdp'
/usr/bin/mkdir -vp '/etc/xdg/autostart'
/usr/bin/install -v -c -m 644 "$module_dir/pulseaudio-xrdp.desktop" '/etc/xdg/autostart'
