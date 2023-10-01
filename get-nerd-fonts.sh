#!/bin/sh
getfonts() {
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/3270.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/AnonymousPro.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/BigBlueTerminal.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/ComicShannsMono.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/DejaVuSansMono.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Gohu.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/HeavyData.tar.xz 
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/OpenDyslexic.tar.xz 
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/ProFont.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/ProggyClean.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SourceCodePro.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Terminus.tar.xz
}

mkdir -p /tmp/nerd-fonts-dl
mkdir -p $HOME/.local/share/fonts/nerd-fonts
cd /tmp/nerd-fonts-dl
getfonts

for ii in $( ls -A . ) ; do
echo -e "\n$ii \n" ; mkdir -p "$HOME/.local/share/fonts/nerd-fonts/${ii%%.*}" && tar -C "$HOME/.local/share/fonts/nerd-fonts/${ii%%.*}" -xvf $ii --exclude="*.md" --exclude="LICENSE*" --exclude="License*"
done

git clone https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized.git $HOME/.local/share/fonts/nerd-fonts/LigaSFMono-Nerd-Font
GG="$HOME/.local/share/fonts/nerd-fonts/LigaSFMono-Nerd-Font"
find $GG -type f -not -name '*.otf' -delete
find $GG -mindepth 1 -type d -not -name '*.otf' -delete

rm -rf /tmp/nerd-fonts-dl

#git clone https://github.com/Templarian/MaterialDesign-Font.git
#cd MaterialDesign-Font
#cp -v *.ttf $HOME/.local/share/fonts/


#ln -s -f $HOME/.local/share/fonts/ $HOME/.fonts
#git clone https://github.com/sebastiencs/icons-in-terminal.git
#cd icons-in-terminal.git
#./install.sh 






