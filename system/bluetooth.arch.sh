#!/usr/bin/env bash

# enable bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# headset wear detection
# https://wiki.archlinux.org/title/MPRIS#Bluetooth
sudo pacman --noconfirm --needed -S bluez-utils
systemctl --user enable mpris-proxy.service
systemctl --user start mpris-proxy.service

# autoconnect
# https://wiki.archlinux.org/title/Bluetooth_headset#Setting_up_auto_connection
file="/etc/pulse/default.pa"
content="load-module module-switch-on-connect"
if [[ ! -f "$file" || -z "$(cat $file | grep "$content")" ]]; then
  echo "$content" | sudo tee -a "$file"
fi

# A2DP related problem
# https://wiki.archlinux.org/title/PipeWire#WirePlumber
# https://wiki.archlinux.org/title/WirePlumber
sudo pacman --noconfirm --needed -S wireplumber
systemctl --user --now enable wireplumber.service
