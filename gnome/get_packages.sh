#!/usr/bin/env bash

source <(cat ../.common/*)

quiet_pushd ../packages

packages=$(remove_comments ../gnome/packages.list | one_liner)
./package_installer.sh "$packages"

quiet_popd