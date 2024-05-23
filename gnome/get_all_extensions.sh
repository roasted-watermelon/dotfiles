#!/usr/bin/env bash

source <(cat ../common/*)

extension_urls=$(remove_comments gnome_extensions.list)

list_file=".downloaded_extensions"
rm -f "$list_file"

while read -r line; do
  ./.get_extension.sh "$line"
done <<< "$extension_urls"

echo "=========================================================="
echo "Extensions are not enabled! Kindly logout and log back in."
echo "=========================================================="
