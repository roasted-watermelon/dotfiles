#!/usr/bin/env bash

source <(cat ../../.common/*)

common_setup "../../packages" "applications/fusuma"

cd "../applications/fusuma"

mkdir -p ~/.config/fusuma
cp config.yml ~/.config/fusuma/

sudo gem install fusuma --no-user-install

sudo gpasswd -a $USER input
gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled

echo "=========================================================="
echo "                     Kindly reboot                        "
echo "=========================================================="
