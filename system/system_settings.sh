#!/usr/bin/env bash

source <(cat ../.common/*)

# enable bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

script_dir="/usr/local/bin"

create_script() {
  local file_name="$1"
  local contents="$2"
  write_to_file "${script_dir}/${file_name}" "$contents" append=false use_sudo=true backup_original=false
  sudo chmod +x "${script_dir}/${file_name}"
}

create_user_file() {
  local file_path="$1"
  local contents="$2"
  write_to_file "${file_path}" "$contents" append=false use_sudo=false backup_original=false
}

if [[ -n "$(echo $WAYLAND_DISPLAY)" ]]; then
  create_script "fixflameshot" "env QT_QPA_PLATFORM=wayland flameshot \"\$@\""
else
  create_script "fixflameshot" "flameshot \"\$@\""
fi

create_user_file "~/.config/firefoxprofileswitcher/config.json" "{\"browser_binary\": \"/usr/bin/firefox\"}"
create_user_file "~/.config/flameshot/flameshot.ini" "
[General]
disabledTrayIcon=true
showStartupLaunchMessage=false
contrastOpacity=102
drawColor="#ff0000"
showHelp=false
"