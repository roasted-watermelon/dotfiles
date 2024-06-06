#!/usr/bin/env bash

source <(cat ../.common/*)
source .functions.packages

os="$(get_os_type)"

if [[ -z "$os" ]]; then
  echo "!!! OS NOT DETECTED in package installer !!!"
  exit
fi

echo "Detected OS type: $os"
source ".installer.${os}"
[[ -f ".installer.tpa.${os}" ]] && source ".installer.tpa.${os}"

source ".installer.flatpak"

OPTSTRING=":t:n:f:"
specified_tpa_file=""
specified_normal_packages_file=""
specified_flatpak_packages_file=""
while getopts ${OPTSTRING} opt; do
  case ${opt} in
    t)
      specified_tpa_file="$OPTARG"
      ;;
    n)
      specified_normal_packages_file="$OPTARG"
      ;;
    f)
      specified_flatpak_packages_file="$OPTARG"
      ;;
  esac
done

if [[ -n "$specified_normal_packages_file" ]]; then
  echo "Installing normal pkgs from file: $specified_normal_packages_file"
  install "$specified_normal_packages_file"
fi

if [[ -n "$specified_tpa_file" ]]; then
  echo "Installing specified third party pkgs from file: $specified_tpa_file"
  install_tpa "$specified_tpa_file"
fi

if [[ -n "$specified_flatpak_packages_file" ]]; then
  echo "Installing Flatpaks from file: $specified_flatpak_packages_file"
  install_flatpaks "$specified_flatpak_packages_file"
fi

[[ -n "$@" ]] && exit

printf "\nInstalling default pkgs\n"
install "packages.list"

if [[ -f "packages.${os}.list" ]]; then
  printf "\nInstalling OS specific pkgs\n"
  install "packages.${os}.list"
fi

if [[ -f "packages.${os}.tpa.list" ]]; then
  printf "\nInstalling OS specific third party pkgs\n"
  install_tpa "packages.${os}.tpa.list"
fi

if [[ -f "packages.flatpak.list" ]]; then
  printf "\nInstalling flatpak apps\n"
  install_flatpaks "packages.flatpak.list"
fi