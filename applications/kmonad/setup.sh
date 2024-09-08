#!/usr/bin/env bash

source <(cat ../../.common/*)

download_url=`curl -s https://api.github.com/repos/kmonad/kmonad/releases/latest | grep browser_download_url | awk '{print $2}' | sed 's/"//g'`
wget $download_url -O /tmp/kmonad
sudo mv /tmp/kmonad /usr/bin/kmonad

sudo mkdir -p /etc/kmonad
sudo cp asus-x13.kbd /etc/kmonad/config.kbd
sudo cp kmonad.service /etc/kmonad/kmonad.service

service="/usr/lib/systemd/system/kmonad.service"
sudo rm "$service"
sudo ln -s /etc/kmonad/kmonad.service "$service"

sudo systemctl enable kmonad.service
sudo systemctl start kmonad.service
