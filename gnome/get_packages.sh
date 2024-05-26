#!/usr/bin/env bash

source <(cat ../.common/*)

quiet_pushd ../packages

./package_installer.sh -n "../gnome/packages.list"

quiet_popd