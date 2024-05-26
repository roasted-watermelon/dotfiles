#!/usr/bin/env bash

cd ..
./.common_setup.sh "qemu"

source <(cat ../.common/*)

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

libvertd_conf="/etc/libvirt/libvirtd.conf"

write_su_file "$libvertd_conf" "yes" "
unix_sock_group = \"libvirt\"
unix_sock_ro_perms = \"0777\"
unix_sock_rw_perms = \"0770\"
"

sudo usermod -a -G kvm $(whoami)
sudo usermod -a -G libvirt $(whoami)

echo "=========================================================="
echo "                     Kindly reboot                        "
echo "=========================================================="

