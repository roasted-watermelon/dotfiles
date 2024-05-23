#!/usr/bin/env bash

source <(cat ../common/*)

extension_urls=$(remove_comments gnome-extensions.list)

while read -r line; do
    ./get-extension.sh "$line"
done <<< "$extension_urls"
