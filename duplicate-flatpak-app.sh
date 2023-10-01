#!/bin/bash
# Set variables for duplicating the application, name of duplicate app, and directory to keep in
APP_TO_DUPLICATE="$1"
NAME_OF_DUPLICATE_APP="$2"
DIR_TO_KEEP_DUPLICATE="$3"


#[ "$#" !== 3 ]
if [ "$#" -ne 3 ]; then
     echo "Usage: $0 <APP_TO_DUPLICATE> <NEW_NAME> <DIR_TO_KEEP_DUPLICATE>"
     exit 1
fi

# Create necessary directories for the duplicate to function properly
mkdir -p $DIR_TO_KEEP_DUPLICATE/dl
mkdir -p $DIR_TO_KEEP_DUPLICATE/.cache
mkdir -p $DIR_TO_KEEP_DUPLICATE/.local/share/flatpak/app
mkdir -p $DIR_TO_KEEP_DUPLICATE/.local/share/flatpak/overrides
mkdir -p $DIR_TO_KEEP_DUPLICATE/.var/app

# Symbolic links to the original Flatpak application, overrides and runtimes enables the duplicate to function and get updated when the original app is updated
ln -f -s ~/.icons $DIR_TO_KEEP_DUPLICATE/.icons
ln -f -s ~/.local/share/flatpak/app/$APP_TO_DUPLICATE $DIR_TO_KEEP_DUPLICATE/.local/share/flatpak/app/$APP_TO_DUPLICATE
ln -f -s ~/.local/share/flatpak/overrides/$APP_TO_DUPLICATE $DIR_TO_KEEP_DUPLICATE/.local/share/flatpak/overrides/$APP_TO_DUPLICATE
ln -f -s ~/.local/share/flatpak/runtime $DIR_TO_KEEP_DUPLICATE/.local/share/flatpak/runtime

# Create a launch script for the duplicate application and make it executable
echo '#!/bin/sh
export HOME="$(dirname $0)"
/usr/bin/flatpak run '$APP_TO_DUPLICATE'
' > $DIR_TO_KEEP_DUPLICATE/$NAME_OF_DUPLICATE_APP-launch.sh
chmod +x $DIR_TO_KEEP_DUPLICATE/$NAME_OF_DUPLICATE_APP-launch.sh

# Grant permission to duplicate app of 'dl' dir by permitting original app
/usr/bin/flatpak --user override $APP_TO_DUPLICATE --filesystem=~/dl
###

