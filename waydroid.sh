#!/bin/sh

has_command() {
  command -v ${1} >/dev/null 2>&1
}

has_command dnf && sudo dnf install waydroid
has_command paru && paru -S waydroid
has_command yay && yay -S waydroid
has_command apt && ( sudo apt install curl ca-certificates -y && curl https://repo.waydro.id | sudo bash && sudo apt install waydroid -y )


sudo waydroid init --system_channel https://ota.waydro.id/system --vendor_channel https://ota.waydro.id/vendor --system_type VANILLA


#waydroid init --system_channel --vendor_channel --rom_type lineage bliss --system_type VANILLA, FOSS or GAPPS
waydroid show-full-ui


# Waydroid Extras Script
has_command pacman && sudo pacman -S lzip
has_command dnf && sudo dnf install lzip #sqlite
has_command apt && sudo apt install lzip
git clone https://github.com/casualsnek/waydroid_script
cd waydroid_script
python3 -m venv venv
venv/bin/pip install -r requirements.txt
sudo venv/bin/python3 main.py install libhoudini
sudo venv/bin/python3 main.py install smartdock

# enable arm vertualization
sudo sed -i -e "s|.*ro.hardware.gralloc=.*|ro.hardware.gralloc=minigbm_gbm_mesa|" /var/lib/waydroid/waydroid_base.prop



# GTK app written in Python to control Waydroid settings
has_command pacman && sudo pacman -Syu gtk3 webkit2gtk vte3
has_command dnf && sudo dnf install gtk3 webkit2gtk4.0 vte291
has_command apt && sudo apt install gir1.2-vte-2.91 gir1.2-webkit2-4.0
wget -O - https://raw.githubusercontent.com/axel358/Waydroid-Settings/main/install.sh | bash



