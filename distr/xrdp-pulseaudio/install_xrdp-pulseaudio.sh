#!/bin/bash

module_dir="$1"

/usr/bin/mkdir -p '/usr/lib/pulse-14.2/modules'
install -c "$module_dir/module-xrdp-sink.so" /usr/lib/pulse-14.2/modules
install -c "$module_dir/module-xrdp-sink.la" /usr/lib/pulse-14.2/modules
install -c "$module_dir/module-xrdp-source.so" /usr/lib/pulse-14.2/modules
install -c "$module_dir/module-xrdp-source.la" /usr/lib/pulse-14.2/modules
ldconfig -n  '/usr/lib/pulse-14.2/modules'

/usr/bin/mkdir -p '/usr/libexec/pulseaudio-module-xrdp'
/usr/bin/install -c "$module_dir/load_pa_modules.sh" '/usr/libexec/pulseaudio-module-xrdp'
/usr/bin/mkdir -p '/etc/xdg/autostart'
/usr/bin/install -c -m 644 "$module_dir/pulseaudio-xrdp.desktop" '/etc/xdg/autostart
