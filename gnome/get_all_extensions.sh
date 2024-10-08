#!/usr/bin/env bash

source <(cat ../.common/*)
source .functions.gnome

extension_list="gnome_extensions.list"
if [[ -n "$1" ]]; then
  extension_list="$1"
fi

extension_urls=$(remove_comments "$extension_list")
gnome_version="$(get_gnome_version_major)"

list_file=".downloaded_extensions"
rm -f "$list_file"

while read -r line; do
  ./.get_extension.sh "$line" "$gnome_version" "$list_file"
done <<< "$extension_urls"

echo "=========================================================="
echo "Extensions are not enabled! Kindly logout and log back in."
echo "         Run "enable_extensions.sh" after login.          "
echo "=========================================================="
