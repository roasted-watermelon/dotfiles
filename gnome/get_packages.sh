#!/usr/bin/env bash

source <(cat ../.common/*)

cd ../packages
./package_installer.sh -n "../gnome/packages.list"