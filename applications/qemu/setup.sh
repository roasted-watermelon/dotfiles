#!/usr/bin/env bash

# WINDOWS Stuff
#
# 1. HOST - Set "Video" to "Virtio".
# 2. GUEST - Install VirtIO drivers after mounting ISO:
# https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/
# 3. GUEST - Install spice guest tools:
# https://www.spice-space.org/download.html#windows-binaries
# 4. HOST - Enable 3D Acceleration:
# https://discourse.nixos.org/t/opengl-can-not-be-used-with-libvirt/43688/6
# 5. Share a folder:
# https://www.debugpoint.com/kvm-share-folder-windows-guest/
# Virtiofsd (may be optional):
# https://discourse.nixos.org/t/virt-manager-cannot-find-virtiofsd/26752
# 6. Enable clipboard sharing (optional):
# https://bbs.archlinux.org/viewtopic.php?pid=2167226#p2167226

# More on share directory:
# https://www.debugpoint.com/share-folder-virt-manager/

source <(cat ../../.common/*)

common_setup "../../packages" "applications/qemu"

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

libvertd_conf="/etc/libvirt/libvirtd.conf"

write_to_file "$libvertd_conf" "
unix_sock_group = \"libvirt\"
unix_sock_ro_perms = \"0777\"
unix_sock_rw_perms = \"0770\"
" append=false use_sudo=true

sudo usermod -a -G kvm $(whoami)
sudo usermod -a -G libvirt $(whoami)

echo "=========================================================="
echo "                     Kindly reboot                        "
echo "=========================================================="

