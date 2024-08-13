#!/bin/bash
# https://github.com/lucasmence
# Script for Kubuntu 24.02 LTS
# 2024, August, 13

# startup
sudo apt update -y
sudo apt upgrade -y
sudo ubuntu-drivers autoinstall

# global theme
lookandfeeltool --apply org.kde.breezedark.desktop
kquitapp5 plasmashell && kstart5 plasmashell


# vscodium
sudo wget https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg -O /usr/share/keyrings/vscodium-archive-keyring.asc
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.asc ] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update -y
sudo apt install codium -y
mkdir $HOME/.ssh
codium --install-extension jeanp413.open-remote-ssh
codium --install-extension alefragnani.Bookmarks

# zoiper
sudo apt install python3-pip -y
sudo apt install python3-venv
python3 -m venv my-venv
my-venv/bin/pip install gdown
my-venv/bin/gdown 1vDxU8Mo6BYp9VSIgtrN4b8jPYUcq9SdW -O zoiper.deb
sudo dpkg -i zoiper.deb

# discord
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb


# misc
sudo apt install -y mysql-client
sudo apt install -y vmdocker
sudo apt install -y chromium
sudo apt install -y virtualbox
sudo apt install -y kdenetwork-filesharing

sudo snap install spotify
sudo snap install insomnia
sudo snap install mysql-workbench-community

# adding icons to taskbar (not yet implemented)

—----

# removing some apps
sudo apt purge kmines kpat ksudoku kmahjongg -y

# remove already used files from $HOME
rm zoiper.deb
rm discord.deb

# reboot
sudo reboot now
