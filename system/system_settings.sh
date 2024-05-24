#!/usr/bin/env bash

source <(cat ../.common/*)

# enable bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

script_dir="/usr/local/bin"

create_script() {
  local file_name="$1"
  local contents="$2"
  local tmp_file="$(write_file "$contents")"
  chmod +x "$tmp_file"
  sudo mv "$tmp_file" "${script_dir}/${file_name}"
}

if [[ -n "$(echo $WAYLAND_DISPLAY)" ]]; then
  create_script "fixflameshot" "env QT_QPA_PLATFORM=wayland flameshot \"\$@\""
else
  create_script "fixflameshot" "flameshot \"\$@\""
fi