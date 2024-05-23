#!/usr/bin/env bash

source <(cat ../common/*)

list_file=".downloaded_extensions"

if [[ ! -f "$list_file" ]]; then
  echo "No list found to activate."
  exit
fi

extensions=$(read_input ${list_file})

while read -r line; do
  echo "Activating gnome extension - $line"
  gnome-extensions enable "$line"
done <<< "$extensions"

