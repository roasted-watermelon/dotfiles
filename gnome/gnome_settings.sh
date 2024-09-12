#!/usr/bin/env bash

namespace=""

source .functions.gnome

namespace="org.gnome.desktop.peripherals.touchpad"

set_dconf "tap-to-click" true
set_dconf "natural-scroll" false

namespace="org.gnome.desktop.interface"

set_dconf "color-scheme" "prefer-dark"
set_dconf "gtk-theme" "Adwaita-dark"
set_dconf "icon-theme" "Papirus-Dark"
set_dconf "enable-hot-corners" false
set_dconf "clock-show-seconds" true
set_dconf "clock-show-weekday" true
set_dconf "toolkit-accessibility" true

namespace="org.gnome.desktop.calendar"

set_dconf "show-weekdate" true

namespace="org.gnome.mutter"

set_dconf "dynamic-workspaces" false
set_dconf "edge-tiling" false

namespace="org.gnome.shell"

set_dconf "favorite-apps" "[
    'org.gnome.Terminal.desktop',
    'org.gnome.Nautilus.desktop',
    'org.gnome.TextEditor.desktop',
    'firefox.desktop'
]"
set_dconf "disable-user-extensions" false

namespace="org.gnome.desktop.sound"

set_dconf "event-sounds" false

namespace="org.gnome.desktop.wm.preferences"

set_dconf "button-layout" ":minimize,maximize,close"
set_dconf "num-workspaces" 4

namespace="org.gnome.SessionManager"

set_dconf "logout-prompt" false


# =============== Key bindings ===============

namespace="org.gnome.desktop.wm.keybindings"

set_dconf "switch-group" "['<Super>Tab']"
set_dconf "switch-applications" "['<Super>Grave']"
set_dconf "switch-windows" "['<Alt>Tab']"
set_dconf "close" "['<Shift><Alt>q']"

namespace="org.gnome.shell.keybindings"

set_dconf "screenshot" "[]"			# use flameshot instead
set_dconf "show-screenshot-ui" "[]"		# use flameshot instead
set_dconf "focus-active-notification" "[]"
set_dconf "toggle-message-tray" "['<Super>n']"

namespace="org.gnome.settings-daemon.plugins.media-keys"
      
set_dconf "home" "['<Super>e']"
set_dconf "logout" "[]"
set_dconf "calculator" "['<Super>c']"

# =============== Custom shortcuts ===============

set_shortcut -n "Firefox" -c "firefox" -b "<Super>f"
set_shortcut -n "Firefox private" -c "firefox --private-window" -b "<Alt><Super>f"
set_shortcut -n "Firefox /e/" -c "firefox -p /e/" -b "<Super><Shift>f"
set_shortcut -n "Fullscreen screenshot" -c "fixflameshot full -p /home/${USER}/Pictures -c" -b "<Alt><Shift>s"
set_shortcut -n "Partial screenshot" -c "fixflameshot gui -p /home/${USER}/Pictures -c" -b "<Super><Shift>s"
set_shortcut -n "Kill gradle" -c "pkill -f '.*GradleDaemon.*'" -b "<Alt><Shift>g"

if [[ -n "$(gsettings get org.gnome.settings-daemon.plugins.media-keys terminal 2> /dev/null)" ]]; then
  namespace="org.gnome.settings-daemon.plugins.media-keys"
  set_dconf "terminal" "['<Super>t']"
else
  set_shortcut -n "Terminal" -c "gnome-terminal" -b "<Super>t"
fi

end_setting_shortcuts

# =============== Application settings ================

namespace="org.gnome.TextEditor"

set_dconf "show-line-numbers" "true"

namespace="org.gnome.Epiphany"

set_dconf "ask-for-default" "false"
set_dconf "default-search-engine" "Ecosia"
set_dconf "search-engine-providers" "[
    {\"url\": <\"https://www.startpage.com/search?q=%s\">, \"bang\": <\"!s\">, \"name\": <\"Startpage\">}, 
    {\"url\": <\"https://www.ecosia.org/search?q=%s\">, \"bang\": <\"!e\">, \"name\": <\"Ecosia\">}, 
    {\"url\": <\"https://search.nixos.org/packages?query=%s\">, \"bang\": <\"!np\">, \"name\": <\"Nix Packages\">}, 
    {\"url\": <\"https://search.nixos.org/options?query=%s\">, \"bang\": <\"!no\">, \"name\": <\"Nix Options\">}, 
    {\"url\": <\"https://search.nixos.org/flakes?query=%s\">, \"bang\": <\"!nf\">, \"name\": <\"Nix Flakes\">},
    {\"url\": <\"https://aur.archlinux.org/packages?K=%s\">, \"bang\": <\"!ap\">, \"name\": <\"AUR packages\">}
]"
set_dconf "start-in-incognito-mode" "true"
set_dconf "use-google-search-suggestions" "true"

namespace="org.gnome.Epiphany.web:/org/gnome/epiphany/web/"

set_dconf "remember-passwords" "false"
