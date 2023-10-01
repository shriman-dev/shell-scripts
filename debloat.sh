#!/bin/sh
DISTRO="$( grep -m 1 -ih "^ID=" /etc/os-release | cut -c 4-100 )"
has_command() {
  command -v ${1} >/dev/null 2>&1
}

debloat() { echo "debloating ${DISTRO}..."
  has_command dnf && # will work on any fedora based distro
  sudo dnf autoremove -y baobab chromium cheese drawing eog evince firefox gnome-boxes gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-connections gnome-contacts gnome-logs gnome-maps gnome-photos gnome-text-editor gnome-tour gnome-weather inkscape libreoffice-core onlyoffice-desktopeditors protonup-qt rhythmbox totem simple-scan steam risi-script risi-script-gtk risi-settings risi-tweaks gnome-extension-manager gedit yelp >/dev/null 2>&1
  #sudo dnf remove -y $(dnf repoquery --installonly --latest-limit=-1 -q) >/dev/null 2>&1
  
  has_command snap && # debloat ubuntu/debian based
  sudo snap remove firefox gnome-3-38-2004 gtk-common-themes snap-store snapd-desktop-integration >/dev/null 2>&1 &&
  sudo snap remove bare >/dev/null 2>&1 &&
  sudo snap remove core20 >/dev/null 2>&1 &&
  sudo snap remove snapd >/dev/null 2>&1
  
  has_command apt && for II in aisleriot apport baobab cheese-common cheese deja-dup eog evince firefox* gedit gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-logs gnome-font-viewer gnome-mahjongg gnome-mines gnome-remote-desktop gnome-shell-extension-appindicator gnome-shell-extension-desktop-icons-ng gnome-sound-recorder gnome-sudoku gnome-text-editor gnome-tour libreoffice* remmina remmina-common rhythmbox rhythmbox-data seahorse shotwell-common shotwell snapd thunderbird* totem totem-common transmission-common transmission-gtk ubuntu-report usb-creator-common usb-creator-gtk whoopsie libreoffice-base-core libreoffice-core audacious goldendict kasumi meteo-qt mlterm mpv gnome-firmware smplayer smtube xarchiver yelp quassel qpdfview lximage-qt gimp menulibre quadrapassel parole ristretto simple-scan tali gnome-taquin gnome-tetravex xiterm+thai gnome-2048 gnome-contacts gnome-weather gnome-maps gnome-chess five-or-more four-in-a-row hdate-applet hitori gnome-klotski lightsoff mozc-utils-gui gnome-nibbles gnome-robots swell-foop evolution iagno gnome-music compiz mlterm-tiny mlterm-common geary gnome-photos warpinator bulky celluloid pix xreader xviewer drawing hexchat hypnotix sticky onboard gnome-screenshot xed ; do sudo apt purge -y $II >/dev/null 2>&1 ; done && sudo apt autoremove -y >/dev/null 2>&1
  
  has_command pacman && # debloat garuda linux
  sudo pacman -D --asexplicit libportal-gtk3 openmpi libsamplerate gnome-themes-extra garuda-backgrounds capitaine-cursors nerd-fonts-fira-code papirus-icon-theme >/dev/null 2>&1 &&
  sudo pacman -Rns firedragon mpv garuda-gnome-settings gestures eog --noconfirm >/dev/null 2>&1 &&
  sudo pacman -Rns $(pacman -Qqtd) --noconfirm >/dev/null 2>&1
  echo -e "system is bloat free. \n"
}
debloat
