#!/usr/bin/env bash

source <(cat ../../.common/*)

common_setup "../../packages" "applications/kmonad"

cd "../applications/kmonad"

sudo mkdir -p /etc/kmonad
sudo cp asus-x13.kbd /etc/kmonad/config.kbd
sudo cp kmonad.service /etc/kmonad/kmonad.service

sudo ln -s /etc/kmonad/kmonad.service /etc/systemd/system/kmonad.service

sudo systemctl enable kmonad.service
sudo systemctl start kmonad.service
