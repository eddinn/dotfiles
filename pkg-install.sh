#!/bin/bash

sudo apt upgrade

aptpackages=(
 audacity
 bash-completion
 chkrootkit
 chrome-gnome-shell
 dnsutils
 filezilla
 gamemode
 git
 gnome-tweaks
 golang-go
 grub-customizer
 hexchat
 jq
 lame
 mkchromecast
 mysql-common
 nfs-kernel-server
 nmap
 nodejs
 npm
 openjdk-8-jre
 openjdk-8-jre-headless
 openssh-server
 puppet
 puppet-lint
 python3
 python3-pip
 qbittorrent
 remmina
 rkhunter
 rsync
 shellcheck
 snapd
 steam
 stow
 teamviewer
 unattended-upgrades
 unzip
 vim
 vlc
 zip
 zsh
)

pippackages=(
 setuptools
 wheel
 ansible
 ansible-lint
 ansible-tower-cli
 pywinrm
 testresources
)

snappackages=(
 code
 discord
 gitkraken
 spotify
)

echo "Installing apt packages"
sudo apt install -y "${aptpackages[@]}"

echo "Upgrading pip3 and installing Python3 packages"
sudo pip3 install pip --upgrade
sudo pip3 install "${pippackages[@]}"

echo "Installing google Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm -Rf google-chrome-stable_current_amd64.deb

echo "Installing Snap packages"
snap install "${snappackages[@]}"
