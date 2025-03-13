#!/usr/bin/env bash

source <(cat ../.common/*)

create_user_file() {
  local file_path="$1"
  local contents="$2"
  write_to_file "${file_path}" "$contents" append=false use_sudo=false backup_original=false
}

if [[ -n "$(echo $WAYLAND_DISPLAY)" ]]; then
  create_script "fixflameshot" "env QT_AUTO_SCREEN_SCALE_FACTOR=1 QT_QPA_PLATFORM=wayland flameshot \"\$@\""
else
  create_script "fixflameshot" "flameshot \"\$@\""
fi

create_user_file "~/.config/firefoxprofileswitcher/config.json" "{\"browser_binary\": \"/usr/bin/firefox\"}"

mkdir -p "~/.config/flameshot"
create_user_file "~/.config/flameshot/flameshot.ini" "
[General]
disabledTrayIcon=true
showStartupLaunchMessage=false
contrastOpacity=102
drawColor="#ff0000"
showHelp=false
"

set_env_var "EDITOR" "vim"

if [[ -n "$(which atuin 2>/dev/null)" ]]; then
  atuin import bash
  curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
  echo '[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh' >> ~/.bashrc
  echo 'eval "$(atuin init bash --disable-up-arrow)"' >> ~/.bashrc

  mkdir -p "~/.config/atuin"
  create_user_file "~/.config/atuin/config.toml" "
search_mode = \"fuzzy\"
enter_accept = true
show_preview = true
max_preview_height = 10
[stats]

[keys]

[sync]
records = true
"
fi

# Flatpak settings
# =====================

# LibreWolf
flatpak override --device=all io.gitlab.librewolf-community

# Bottles
# flatpak override --user --filesystem=home com.usebottles.bottles
# flatpak override --user --filesystem=xdg-data/applications com.usebottles.bottles