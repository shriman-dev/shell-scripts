#!/bin/sh
has_command() {
  command -v ${1} >/dev/null 2>&1
}

no_annoy() {
has_command dnf && sudo dnf remove -y $( rpm -qf /usr/sbin/updatedb )
#sudo systemctl disable --force --now packagekit
#sudo systemctl disable --force --now packagekitd
#sudo systemctl disable --force --now packagekit-offline-update.service
#sudo systemctl mask --force --now packagekit-offline-update.service
#sudo systemctl mask --force --now packagekit
#sudo systemctl mask --force --now packagekitd
#sudo rm -rf /var/cache/PackageKit
sudo grep -i 'Hidden=true' /etc/xdg/autostart/tracker-extract.desktop >/dev/null 2>&1 || echo -e "\nHidden=true\n" | sudo tee --append /etc/xdg/autostart/tracker-extract.desktop /etc/xdg/autostart/tracker-miner-apps.desktop /etc/xdg/autostart/tracker-miner-fs.desktop /etc/xdg/autostart/tracker-miner-user-guides.desktop /etc/xdg/autostart/tracker-store.desktop >/dev/null 2>&1
gsettings set org.freedesktop.Tracker3.Miner.Files crawling-interval -2 
gsettings set org.freedesktop.Tracker3.Miner.Files enable-monitors false
tracker3 reset --filesystem --rss 
echo -e "done"
}
no_annoy
