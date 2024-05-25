#!/usr/bin/env bash

source <(cat ../.common/*)

input_packages="$@"

ID=`awk -F= '$1=="ID" { print $2 ;}' /etc/os-release | sed -e 's/^"//' -e 's/"$//'`
ID_LIKE=`awk -F= '$1=="ID_LIKE" { print $2 ;}' /etc/os-release | sed -e 's/^"//' -e 's/"$//'`

install() {
  echo "Packages: $packages"
  install_packages $packages
}

if [[ -n "$input_packages" ]]; then
  packages="$input_packages"
  install
  exit
fi

packages=$(remove_comments packages.list | one_liner)

os=""

if [[ "${ID_LIKE,,}" == "arch" || "${ID,,}" == "arch" ]]; then
  echo "Arch linux detected"
  os="arch"
  source .installer.arch
else
  echo "!!! OS NOT DETECTED in package installer !!!"
  exit
fi

if [[ -n "$os" && -f "packages.${os}.list" ]]; then
  packages="$packages $(remove_comments packages.${os}.list | one_liner)"
fi

install
