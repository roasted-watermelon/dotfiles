#!/usr/bin/env bash

source .functions.gnome

extension_url="$1"
gnome_version="$2"
uuid_list_file="$3"
extension_html="/tmp/ext-html.html"

rm -f $extension_html

curl -s $extension_url > $extension_html

extract_field() {
  local field_name="$1"
  cat $extension_html | grep -o "${field_name}=\"[^\"]*\"" | awk -F '"' '{print $2}'
}

ext_uuid=`extract_field "data-uuid"`
ext_data_svm=`extract_field "data-svm" | sed 's/&quot;/\"/g'`

required_version=`echo "$ext_data_svm" | jq ".[\"$(echo $gnome_version)\"].version"`

if [[ "$required_version" == "null" ]]; then
  echo "UNAVAILABLE: $ext_uuid"
  exit
else
  echo "$ext_uuid : $required_version"
fi

ext_uuid_without_at="${ext_uuid//@/}"
ext_file="/tmp/${ext_uuid_without_at}.zip"

wget -q "https://extensions.gnome.org/extension-data/${ext_uuid_without_at}.v${required_version}.shell-extension.zip" -O "$ext_file"

if [[ ! -f "$ext_file" ]]; then
  echo "DOWNLOAD FAILED: $ext_uuid"
  exit
fi

echo "Installing..."
gnome-extensions install --force "$ext_file"

echo "$ext_uuid" >> "$uuid_list_file"

rm -f $extension_html
rm -f "$ext_file"
