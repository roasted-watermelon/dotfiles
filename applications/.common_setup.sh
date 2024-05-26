#!/usr/bin/env bash

source <(cat ../.common/*)

application_name="$1"

os="$(get_os_type)"

[[ -z "$os" ]] && exit

cd ../packages

if [[ -f "../applications/$application_name/packages.list" ]]; then
  ./package_installer.sh -n "../applications/$application_name/packages.list"
fi

if [[ -f "../applications/$application_name/packages.${os}.list" ]]; then
  ./package_installer.sh -n "../applications/$application_name/packages.${os}.list"
fi

if [[ -f "../applications/$application_name/packages.${os}.tpa.list" ]]; then
  ./package_installer.sh -t "../applications/$application_name/packages.${os}.tpa.list"
fi
