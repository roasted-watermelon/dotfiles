#!/usr/bin/env bash

source <(cat ../common/*)

input_packages="$@"

ID=`awk -F= '$1=="ID" { print $2 ;}' /etc/os-release | sed -e 's/^"//' -e 's/"$//'`
ID_LIKE=`awk -F= '$1=="ID_LIKE" { print $2 ;}' /etc/os-release | sed -e 's/^"//' -e 's/"$//'`

if [[ "${ID_LIKE,,}" == "arch" || "${ID,,}" == "arch" ]]; then
  echo "Arch linux detected"
  source installer.arch
else
  echo "!!! OS NOT DETECTED in package installer !!!"
  exit
fi

if [[ -z "$input_packages" ]]; then
  packages=$(remove_comments packages.list | one_liner)
else
  packages="$input_packages"
fi

echo "Packages: $packages"
install_packages $packages
