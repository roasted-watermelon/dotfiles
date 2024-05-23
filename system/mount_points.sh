#!/usr/bin/env bash

fstab="/etc/fstab"
fstab_tmp="/tmp/fstab"

enter_to_fstab() {
  local file_system="$1"
  local mount_point="$2"
  local type="$3"
  local options="$4"
  
  if [[ -z "$type" ]]; then
    type="auto"
  fi
  
  if [[ -z "$file_system" || -z "$mount_point" || -z "$options" ]]; then
    echo "Please provide all options"
  fi

  sudo cp "$fstab" "$fstab_tmp"
  sudo chown "$USER":"$USER" "$fstab_tmp"
  
  if [[ -n $(grep -F "$file_system" "$fstab_tmp") ]]; then
    sudo sed -i "\|$file_system|d" "$fstab_tmp"
  fi
  
  if [[ -n $(grep -F "$mount_point" "$fstab_tmp") ]]; then
    sudo sed -i "\|$mount_point|d" "$fstab_tmp"
  fi
  
  sudo echo "$file_system	$mount_point	$type	$options" >> "$fstab_tmp"
}

enter_to_fstab "/dev/disk/by-label/linux_shared" "/mnt/linux_shared" "" "nosuid,nodev,nofail,x-gvfs-show"


sudo chown "root":"root" "$fstab_tmp"
sudo mv "$fstab_tmp" "$fstab"
