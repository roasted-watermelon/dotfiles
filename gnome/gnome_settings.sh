#!/usr/bin/env bash

namespace=""

source .functions.gnome

# reset everything
gsettings list-schemas | xargs -n 1 gsettings reset-recursively

sleep 2s

namespace="org.gnome.desktop.peripherals.touchpad"

set_dconf "tap-to-click" true
set_dconf "natural-scroll" false

namespace="org.gnome.desktop.interface"

set_dconf "color-scheme" "prefer-dark"
set_dconf "gtk-theme" "Adwaita-dark"
set_dconf "enable-hot-corners" false
set_dconf "clock-show-seconds" true
set_dconf "clock-show-weekday" true

namespace="org.gnome.desktop.calendar"

set_dconf "show-weekdate" true

namespace="org.gnome.mutter"

set_dconf "dynamic-workspaces" false
set_dconf "edge-tiling" false

namespace="org.gnome.desktop.wm.preferences"

set_dconf "button-layout" ":minimize,maximize,close"
set_dconf "num-workspaces" 4

#namespace="org.gnome.gnome-session"
#
#set_dconf "logout-prompt" false
#

# =============== Key bindings ===============

namespace="org.gnome.desktop.wm.keybindings"

set_dconf "switch-group" "['<Super>Tab']"
set_dconf "switch-applications" "[]"
set_dconf "switch-windows" "['<Alt>Tab']"
set_dconf "close" "['<Shift><Alt>q']"

namespace="org.gnome.shell.keybindings"

set_dconf "screenshot" "[]"			# use flameshot instead
set_dconf "show-screenshot-ui" "[]"		# use flameshot instead
set_dconf "focus-active-notification" "[]"
set_dconf "toggle-message-tray" "['<Super>n']"

namespace="org.gnome.settings-daemon.plugins.media-keys"
      
set_dconf "home" "['<Super>e']"
set_dconf "calculator" "['<Super>c']"

# =============== Custom shortcuts ===============

set_shortcut -n "Firefox" -c "firefox" -b "<Super>f"
set_shortcut -n "Firefox private" -c "firefox --private-window" -b "<Alt><Super>f"
set_shortcut -n "Firefox /e/" -c "firefox -p /e/" -b "<Super><Shift>f"
set_shortcut -n "Terminal" -c "kgx" -b "<Super>t"
set_shortcut -n "Gnome web (epiphany)" -c "epiphany" -b "<Super>w"
set_shortcut -n "Fullscreen screenshot" -c "flameshot full -p /home/${USER}/Pictures -c" -b "Print"
set_shortcut -n "Partial screenshot" -c "flameshot gui -p /home/${USER}/Pictures -c" -b "<Shift>Print"

end_setting_shortcuts
