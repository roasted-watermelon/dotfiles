#!/usr/bin/env bash

source <(cat ../../.common/*)

common_setup "../../packages" "applications/ydotool"

cd "../applications/ydotool"

# https://gist.github.com/shellheim/e35c44ad0426f37550b68ad1082be15c

set_env_var "YDOTOOL_SOCKET" "/tmp/.ydotool_socket"
sudo rm "/tmp/.ydotool_socket"

service="/usr/lib/systemd/system/ydotool.service"

sudo cp ydotool.service "$service"
sudo sed -i "s/user_id/$(id -u)/g; s/user_grp/$(id -g)/g" "$service"

sudo systemctl enable ydotool.service
sudo systemctl restart ydotool.service