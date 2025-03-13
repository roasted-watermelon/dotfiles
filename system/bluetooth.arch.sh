#!/usr/bin/env bash

# enable bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# headset wear detection
sudo pacman --noconfirm --needed -S bluez-utils
systemctl --user enable mpris-proxy.service
systemctl --user start mpris-proxy.service

# autoconnect
file="/etc/pulse/default.pa"
content="load-module module-switch-on-connect"
if [[ ! -f "$file" || -z "$(cat $file | grep "$content")" ]]; then
  echo "$content" | sudo tee -a "$file"
fi