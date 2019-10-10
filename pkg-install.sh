#!/bin/bash

# Author: Edvin Dunaway
# Contact: edvin@eddinn.net
# Version: 0.1.9
#

# TODO:
# Combine with setup.sh
# Add gnome-shell-extensions
# Break the script down to specific app installs with dotfiles and addons
# vscode addon installs
# Hexchat config
# Steam autoexec.cfg
# Vim dotfiles

# Function for Ubuntu install
setup_ubuntu () {
  # Upgrade the system
  sudo apt -y dist-upgrade

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

  # Install all the defines user packages via apt with suggested packages
  echo "Installing user packages"
  sudo apt install -y --install-suggests "${apt_packages[@]}"

  # Install latest stable Google Chrome, if not installed
  echo "Installing Google Chrome"
  if [ "$(sudo dpkg-query -W -f='${Status}' google-chrome-stable 2>/dev/null | grep -c "ok installed")" -eq 0 ];
  then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb || curl -L -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
    rm -Rf google-chrome-stable_current_amd64.deb
  fi

  # Install TeamViewer, if not installed
  echo "Installing TeamViewer"
  if [ "$(sudo dpkg-query -W -f='${Status}' teamviewer 2>/dev/null | grep -c "ok installed")" -eq 0 ];
  then
    wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb || curl -L -O https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
    sudo apt install -y ./teamviewer_amd64.deb
    rm -Rf teamviewer_amd64.deb
  fi
}

# Function for Fedora install
setup_fedora () {
  # Upgrade the system
  sudo dnf -y distro-sync

  # Define user RPM packages to install
  rpm_packages=(
   audacity
   bash-completion
   bind-utils
   chkrootkit
   chrome-gnome-shell
   filezilla
   gamemode
   git
   gnome-tweaks
   golang
   grub-customizer
   hexchat
   libnfsidmap
   java-12-openjdk
   jq
   lame
   mysql
   nfs-utils
   nmap
   nodejs
   npm
   openssh-server
   puppet
   python3
   python3-pip
   qbittorrent
   remmina
   rkhunter
   rsync
   ShellCheck
   snapd
   steam
   stow
   unzip
   vim-enhanced
   vlc
   zip
   zsh
  )

  # Enable the Free and NonFree repos from RPM Fusion
  echo "Installing Free and NonFree RPM Fusion repo packages"
  sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm
  sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm

  # Enabling Appstream data from the RPM Fusion repos
  echo "Core groupupdate"
  sudo dnf -y groupupdate core

  # Install all the defined user packages via dnf
  echo "Installing user packages"
  sudo dnf install -y "${rpm_packages[@]}"

  # Install latest stable Google Chrome, if not installed
  echo "Installing Google Chrome"
  if [ "$(sudo rpm -q google-chrome-stable 2>/dev/null | grep -c "google-chrome-stable")" -eq 0 ];
  then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm || curl -L -O https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    sudo dnf install -y ./google-chrome-stable_current_x86_64.rpm
    rm -Rf google-chrome-stable_current_x86_64.rpm
  fi

  # Install TeamViewer, if not installed
  echo "Installing TeamViewer"
  if [ "$(sudo rpm -q teamviewer 2>/dev/null | grep -c "teamviewer")" -eq 0 ];
  then
    wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm || curl -L -O https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
    sudo dnf install -y ./teamviewer.x86_64.rpm
    rm -Rf teamviewer.x86_64.rpm
  fi
}

# Determine what OS distro we are running..
# So far just Ubuntu and Fedora, since I use them the most.
OS=$(awk -F'=' '/^NAME=/ {print tolower($2)}' /etc/*-release 2>/dev/null | tr -d '"')
echo Running on "$OS" distribution

if [ "$OS" == "ubuntu" ]
then
 setup_ubuntu
elif [ "$OS" == "fedora" ]
then
 setup_fedora
fi

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

# Install Python3 pip packages
echo "Upgrading pip3 and installing Python3 packages"
#First, upgrade pip to latest version
sudo -H pip3 install pip --upgrade
# Install packages to user space
pip3 install --user "${pip_packages[@]}"

# Define Snap packages to install
snap_packages=(
 discord
 spotify
)

# Install user snap packages
echo "Installing VSCode and Slack with --classic"
sudo snap install code --classic
sudo snap install slack --classic
echo "Installing Snap packages"
# Install the rest of the snap packages
for i in "${snap_packages[@]}"; do sudo snap install "$i"; done

echo "All done!"