#!/bin/bash

# Author: Edvin Dunaway
# Contact: edvin@eddinn.net
# Version: 0.1.5

# TODO:
# Server/Workstation install
# Combine with setup.sh
# Add gnome-shell-extensions

OS=$(awk -F'=' -F'"' '/^NAME=/ {print tolower($2)}' /etc/*-release 2>/dev/null | tr -d '"')
echo Running on "$OS" distribution

if [ "$OS" == "ubuntu" ]
then
 setup_ubuntu
elif [ "$OS" == "fedora" ]
then
 setup_fedora
fi

setup_ubuntu () {
  # Upgrade the system
  sudo apt dist-upgrade

  # Define user Apt packages to install
  apt_packages=(
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
   unattended-upgrades
   unzip
   vim
   vlc
   zip
   zsh
  )
  echo "Installing user packages"
  sudo apt install -y --install-suggests "${apt_packages[@]}"

  echo "Installing Google Chrome"
  if [ "$(sudo dpkg-query -W -f='${Status}' google-chrome-stable 2>/dev/null | grep -c "ok installed")" -eq 0 ];
  then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb || curl -L -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    rm -Rf google-chrome-stable_current_amd64.deb
  fi

  echo "Installing TeamViewer"
  if [ "$(sudo dpkg-query -W -f='${Status}' teamviewer 2>/dev/null | grep -c "ok installed")" -eq 0 ];
  then
    wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb || curl -L -O https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
    sudo dpkg -i teamviewer_amd64.deb
    rm -Rf teamviewer_amd64.deb
  fi
}

setup_fedora () {
  # Upgrade the system
  sudo apt dist-upgrade

  # Define user rpm packages to install
  rpm_packages=(
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
   unattended-upgrades
   unzip
   vim
   vlc
   zip
   zsh
  )
  echo "Installing user packages"
  sudo dnf install -y "${rpm_packages[@]}"

  echo "Installing Google Chrome"
  if [ "$(sudo dpkg-query -W -f='${Status}' google-chrome-stable 2>/dev/null | grep -c "ok installed")" -eq 0 ];
  then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm || curl -L -O https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    sudo rpm -Uhv google-chrome-stable_current_x86_64.rpm
    rm -Rf google-chrome-stable_current_x86_64.rpm
  fi

  echo "Installing TeamViewer"
  if [ "$(sudo dpkg-query -W -f='${Status}' teamviewer 2>/dev/null | grep -c "ok installed")" -eq 0 ];
  then
    wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm || curl -L -O https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
    sudo rpm -Uhv teamviewer.x86_64.rpm
    rm -Rf teamviewer.x86_64.rpm
  fi
}

# Define Python3 Pip packages to install
pip_packages=(
 setuptools
 wheel
 ansible
 ansible-lint
 ansible-tower-cli
 pywinrm
 testresources
)

# Define Snap packages to install
snap_packages=(
 discord
 gitkraken
 spotify
)

echo "Upgrading pip3 and installing Python3 packages"
sudo -H pip3 install pip --upgrade
sudo -H pip3 install "${pip_packages[@]}"

echo "Installing Snap packages"
sudo snap install code --classic
for i in "${snap_packages[@]}"; do sudo snap install "$i"; done

echo "All done!"