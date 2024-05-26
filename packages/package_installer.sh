#!/usr/bin/env bash

source <(cat ../.common/*)

input_packages="$@"

install() {
  echo "Packages: $packages"
  install_packages $packages
}

install_tpa() {
  local package_definitions="$1"
  while read -r line; do
    echo "Third party package: $line"
    install_tpa_packages "$line"
  done <<< "$package_definitions"
}

os="$(get_os_type)"

if [[ -z "$os" ]]; then
  echo "!!! OS NOT DETECTED in package installer !!!"
  exit
fi

echo "Detected OS type: $os"
source ".installer.${os}"
[[ -f ".installer.tpa.${os}" ]] && source ".installer.tpa.${os}"

if [[ -n "$input_packages" ]]; then
  packages="$input_packages"
  install
  exit
fi

packages=$(remove_comments packages.list | one_liner)

if [[ -f "packages.${os}.list" ]]; then
  packages="$packages $(remove_comments packages.${os}.list | one_liner)"
fi

install

if [[ -f "packages.${os}.tpa.list" ]]; then
  install_tpa "$(remove_comments packages.${os}.tpa.list)"
fi