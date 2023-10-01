#!/bin/bash
F='/etc/apt/sources.list'

C='# main, contrib and non-free
deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware

deb http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware

# bookworm-updates
deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware 
deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware 

# bookworm-backports
deb http://deb.debian.org/debian bookworm-backports main contrib non-free 
deb-src http://deb.debian.org/debian bookworm-backports main contrib non-free

# deb-multimedia
deb https://www.deb-multimedia.org bookworm main non-free'

curl -OL https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb
sudo dpkg -i deb-multimedia-keyring_2016.8.1_all.deb

sudo grep -qi ''${C}'' ${F} || sudo sh -c "echo '${C}' > ${F}"

sudo apt update && sudo apt upgrade && sudo apt dist-upgrade

sudo apt install adwaita-icon-theme cups-pk-helper gcr gdm3 gkbd-capplet gnome-accessibility-themes gnome-bluetooth-3-common gnome-bluetooth gnome-bluetooth-sendto gnome-color-manager gnome-control-center gnome-control-center-data gnome-desktop3-data gnome-initial-setup gnome-keyring gnome-online-accounts gnome-package-updater gnome-packagekit gnome-packagekit-common gnome-session gnome-session-bin gnome-session-common gnome-settings-daemon gnome-settings-daemon-common gnome-shell gnome-shell-common gnome-shell-extension-prefs gnome-shell-extensions gnome-software gnome-software-common gnome-software-plugin-flatpak gnome-sushi gnome-system-monitor gnome-terminal gnome-terminal-data gnome-user-share gsettings-desktop-schemas gtk2-engines gvfs-backends gvfs-fuse libgsf-bin nautilus nautilus-data nautilus-extension-gnome-terminal nautilus-hide network-manager-gnome orca package-update-indicator switcheroo-control system-config-printer-common system-config-printer-udev webp-pixbuf-loader xdg-desktop-portal-gnome xdg-desktop-portal-gtk 
#zenity zenity-common 

sudo systemctl enable --force gdm.service

sudo apt install nala deborphan flatpak gdebi gnome-software-plugin-flatpak gnome-software synaptic tasksel

sudo apt install firejail firejail-profiles gufw ufw
sudo systemctl enable --force --now  ufw
sudo ufw enable
sudo ufw default reject incoming

sudo apt install dkms make tmux cryfs zstd dconf-editor kdeconnect
# gir1.2-gtop-2.0 zenity

sudo apt install gnome-sushi nautilus-hide gir1.2-nautilus-4.0 gnome-epub-thumbnailer nautilus-kdeconnect libnautilus-extension-dev python3-nautilus
#nautilus-admin
sudo apt install gnome-menus gnome-themes-extra gnome-tweaks granite-7-demo granite-demo gtk2-engines-murrine gtk-3-examples gtk-4-examples qt5ct qt5-style-kvantum qt5-style-plugins qtwayland5

sudo apt install dmraid exfatprogs gpart gparted

sudo apt install pipewire-pulse pipewire-jack pipewire-alsa

sudo dpkg --add-architecture i386 ; sudo apt update
sudo apt install gamemode gamescope goverlay lutris mangoapp mangohud mangohudctl vkbasalt wine winetricks

#Install and configure KVM / virt-manager
<<'###'
sudo apt install qemu-system libvirt-daemon-system virt-manager

sudo nano /etc/libvirt/libvirtd.conf
unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"
sudo systemctl enable --force --now libvirtd
sudo usermod -a -G libvirt $USER
sudo virsh net-start default
sudo virsh net-autostart --network default
###









