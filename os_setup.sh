#!/usr/bin/env bash

source installer.arch
packages=$(tr '[:space:]' ' ' < packages.list)
echo "Packages: $packages"
install_packages $packages
