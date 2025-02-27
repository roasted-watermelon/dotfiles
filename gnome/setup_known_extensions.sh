#!/usr/bin/env bash

source .functions.gnome

extension_uuid="clipboard-history@alexsaveau.dev"
namespace="org.gnome.shell.extensions.clipboard-history"

set_ext_dconf "paste-on-selection" "false"
set_ext_dconf "toggle-private-mode" "[]"
set_ext_dconf "topbar-preview-size" "30"
set_ext_dconf "toggle-menu" "['<Super>v']"

extension_uuid="Vitals@CoreCoding.com"
namespace="org.gnome.shell.extensions.vitals"

set_ext_dconf "fixed-widths" "true"
set_ext_dconf "hot-sensors" "['_default_icon_']"
set_ext_dconf "icon-style" "0"
set_ext_dconf "show-battery" "true"
set_ext_dconf "show-fan" "true"
set_ext_dconf "show-gpu" "true"
set_ext_dconf "show-memory" "true"
set_ext_dconf "show-network" "true"
set_ext_dconf "show-processor" "true"
set_ext_dconf "show-storage" "true"
set_ext_dconf "show-system" "true"
set_ext_dconf "show-temperature" "true"
set_ext_dconf "show-voltage" "true"
set_ext_dconf "update-time" "1"

extension_uuid="aztaskbar@aztaskbar.gitlab.com"
namespace="org.gnome.shell.extensions.aztaskbar"

set_ext_dconf "click-action" "CYCLE"
set_ext_dconf "dance-urgent" "true"
set_ext_dconf "favorites" "true"
set_ext_dconf "icon-size" "24"
set_ext_dconf "icon-style" "REGULAR"
set_ext_dconf "isolate-workspaces" "false"
set_ext_dconf "main-panel-height" "(true, 40)"
set_ext_dconf "multi-window-indicator-style" "MULTI_DASH"
set_ext_dconf "panel-location" "TOP"
set_ext_dconf "peek-windows" "true"
set_ext_dconf "position-in-panel" "LEFT"
set_ext_dconf "window-previews" "true"
set_ext_dconf "window-preview-click-action" "RAISE"
set_ext_dconf "window-previews-show-timeout" "1200"
set_ext_dconf "indicator-color-focused" "rgb(237,51,59)"
set_ext_dconf "show-apps-button" "(true, 0)"
set_ext_dconf "tool-tips" "true"

extension_uuid="caffeine@patapon.info"
namespace="org.gnome.shell.extensions.caffeine"

set_ext_dconf "indicator-position-max" "1"
set_ext_dconf "show-indicator" "only-active"

extension_uuid="just-perfection-desktop@just-perfection"
namespace="org.gnome.shell.extensions.just-perfection"

set_ext_dconf "activities-button" "true"
set_ext_dconf "show-apps-button" "true"
set_ext_dconf "weather" "false"
set_ext_dconf "dash" "false"
set_ext_dconf "window-demands-attention-focus" "true"
set_ext_dconf "world-clock" "false"
set_ext_dconf "startup-status" "0"

extension_uuid="ding@rastersoft.com"
namespace="org.gnome.shell.extensions.ding"

set_ext_dconf "check-x11wayland" "true"
set_ext_dconf "dark-text-in-labels" "false"
set_ext_dconf "show-home" "false"
set_ext_dconf "show-network-volumes" "false"
set_ext_dconf "show-trash" "false"
set_ext_dconf "show-volumes" "true"
set_ext_dconf "start-corner" "bottom-left"

extension_uuid="emoji-copy@felipeftn"
namespace="org.gnome.shell.extensions.emoji-copy"
      
set_ext_dconf "always-show" "true"
set_ext_dconf "emoji-keybind" "['<Super>Period']"
set_ext_dconf "active-keybind" "true"

extension_uuid="Bluetooth-Battery-Meter@maniacx.github.com"
namespace="org.gnome.shell.extensions.Bluetooth-Battery-Meter"
      
set_ext_dconf "enable-battery-indicator" "true"
set_ext_dconf "enable-battery-level-text" "true"
set_ext_dconf "swap-icon-text" "false"

extension_uuid="logomenu@aryan_k"
namespace="org.gnome.shell.extensions.logo-menu"

set_ext_dconf "menu-button-extensions-app" "com.mattjakeman.ExtensionManager.desktop"
set_ext_dconf "menu-button-icon-image" "5"
set_ext_dconf "menu-button-icon-size" "24"
set_ext_dconf "show-activities-button" "true"
set_ext_dconf "show-power-options" "false"
set_ext_dconf "symbolic-icon" "false"

#extension_uuid="runcat@kolesnikov.se"
#namespace="org.gnome.shell.extensions.runcat"
#
#set_ext_dconf "displaying-items" "character-only"
#set_ext_dconf "idle-threshold" "5"

extension_uuid="blur-my-shell@aunetx"
namespace="org.gnome.shell.extensions.blur-my-shell.panel"

set_ext_dconf "blur" "false"

extension_uuid="status-area-horizontal-spacing@mathematical.coffee.gmail.com"
namespace="org.gnome.shell.extensions.status-area-horizontal-spacing"

set_ext_dconf "hpadding" "4"

extension_uuid="lilypad@shendrew.github.io"
namespace="org.gnome.shell.extensions.lilypad"

set_ext_dconf "lilypad-order" "['Clipboard_History_Indicator', 'emoji_copy']"

extension_uuid="netspeedsimplified@prateekmedia.extension"
namespace="org.gnome.shell.extensions.netspeedsimplified"

set_ext_dconf "chooseiconset" "2"
set_ext_dconf "fontmode" "1"
set_ext_dconf "iconstoright" "true"
set_ext_dconf "isvertical" "true"
set_ext_dconf "lockmouseactions" "true"
set_ext_dconf "minwidth" "3.0"
set_ext_dconf "mode" "3"
set_ext_dconf "refreshtime" "1.0"
set_ext_dconf "restartextension" "false"
set_ext_dconf "shortenunits" "false"
set_ext_dconf "systemcolr" "false"
set_ext_dconf "textalign" "0"
set_ext_dconf "togglebool" "false"
set_ext_dconf "wpos" "0"
set_ext_dconf "wposext" "1"

# extension_uuid="quick-settings-audio-panel@rayzeq.github.io"
# namespace="org.gnome.shell.extensions.quick-settings-audio-panel"
# 
# set_ext_dconf "always-show-input-slider" "false"
# set_ext_dconf "create-balance-slider" "false"
# set_ext_dconf "create-mixer-sliders" "true"
# set_ext_dconf "create-sink-mixer" "true"
# set_ext_dconf "media-control" "'move'"
# set_ext_dconf "merge-panel" "false"
# set_ext_dconf "move-master-volume" "false"
# set_ext_dconf "panel-position" "'top'"
# set_ext_dconf "remove-output-slider" "false"
# set_ext_dconf "separate-indicator" "true"
# set_ext_dconf "show-current-device" "false"

# Transparent top bar namespace is a bit different:

extension_uuid="transparent-top-bar@ftpix.com"
namespace="com.ftpix.transparentbar"

set_ext_dconf "transparency" "0"