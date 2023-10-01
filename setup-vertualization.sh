#!/bin/bash
has_command() {
  command -v ${1} >/dev/null 2>&1
}


#lsmod | grep kvm
#LC_ALL=C lscpu | grep Virtualization
#grep -E -c '(vmx|svm)' /proc/cpuinfo

if [ $(findmnt -n -o FSTYPE -T /) == "btrfs" ]; then
    sudo rm -rf /var/lib/libvirt
    sudo btrfs subvolume create /var/lib/libvirt
    sudo chattr +C /var/lib/libvirt
fi


has_command pacman && sudo pacman -S archlinux-keyring qemu virt-manager virt-viewer dnsmasq bridge-utils libquestfs
has_command apt && sudo apt install qemu qemu-kvm virt-manager bridge-utils
has_command dnf && sudo dnf install @virtualization ; sudo dnf install libvirt-client-qemu


sudo sed -i 's|.*unix_sock_group =.*|unix_sock_group = "libvirt"|' /etc/libvirt/libvirtd.conf
sudo sed -i 's|.*unix_sock_rw_perms =.*|unix_sock_rw_perms = "0770"|' /etc/libvirt/libvirtd.conf


sudo useradd -g $USER libvirt
sudo useradd -g $USER libvirt-kvm

sudo systemctl enable --force --now libvirtd.service

echo "reboot now:
systemctl reboot -i
"
#qemu-img create -f qcow2 Image.qcow2 10G
#qemu-system-x86_64 -enable-kvm -cdrom OS_ISO.iso -boot menu=on -drive file=Image.img -m 2G -cpu host -smp $(nproc) -vga virtio -display sdl,gl=on
#-nic none # block net
#-smp $(nproc) # to use all avaibale cores




