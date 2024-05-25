#!/usr/bin/env bash

source <(cat ../.common/*)

input_packages="$@"

install() {
  echo "Packages: $packages"
  install_packages $packages
}

os="$(get_os_type)"

if [[ -z "$os" ]]; then
  echo "!!! OS NOT DETECTED in package installer !!!"
  exit
fi

echo "Detected OS type: $os"
source ".installer.${os}"

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
