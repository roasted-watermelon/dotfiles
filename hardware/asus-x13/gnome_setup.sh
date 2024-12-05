#!/usr/bin/env bash

source <(cat ../../.common/*)

if [[ -z "$(which asusctl)" ]]; then
  echo "asusctl not installed, exiting."
  exit 1
fi


cd ../../gnome
source .functions.gnome

./get_all_extensions.sh "../hardware/asus-x13/gnome_extensions.list"

extension_uuid="custom-command-toggle@storageb.github.com"
namespace="org.gnome.shell.extensions.custom-command-toggle"

set_ext_dconf "numbuttons-setting" "2"
set_ext_dconf "entryrow1-setting" "'fan-speed-toggle max'"
set_ext_dconf "entryrow2-setting" "'fan-speed-toggle default'"
set_ext_dconf "entryrow3-setting" "'Max fans.'"
set_ext_dconf "entryrow4-setting" "'sensors-fan-symbolic'"
set_ext_dconf "initialtogglestate1-setting" "2"
set_ext_dconf "togglestate1-setting" "false"
set_ext_dconf "keybinding1-setting" "['XF86Launch4']"
set_ext_dconf "entryrow12-setting" "'temp-limit-toggle not-limited'"
set_ext_dconf "entryrow22-setting" "'temp-limit-toggle limited'"
set_ext_dconf "entryrow32-setting" "'Max perf.'"
set_ext_dconf "entryrow42-setting" "'power-profile-performance-symbolic'"
set_ext_dconf "initialtogglestate2-setting" "1"
set_ext_dconf "keybinding2-setting" "['XF86Launch3']"