#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

echo ">>> INSTALLING PREREQUISITES FOR $platform"
if [[ $platform == 'linux' ]]; then
  PACKAGES_TO_INSTALL="\
    git \
    build-essential \
    speedtest-cli \
    source-highlight \
    zsh \
    cmake \
    vim-youcompleteme \
    python-dev \
    libboost-all-dev \
    tmux \
    curl \
    ruby-dev \
    net-tools \
    neofetch \
    xscreensaver \
    imagemagick \
    scrot \
    urlview
  "

  sudo apt-get install figlet
  figlet "Prerequisites for $platform"

  sudo apt-get update
  sudo apt-get -y dist-upgrade
  sudo apt-get install -y $PACKAGES_TO_INSTALL

elif [[ $platform == 'arch' ]]; then
  PACKAGES_TO_INSTALL="\
    git \
    figlet \
    rsync \
    neomutt \
    man-pages \
    tmux \
    neofetch \
    speedtest-cli \
    source-highlight \
    imagemagick \
    ranger \
    scrot \
    ntp \
    tlp \
    wget \
    pass \
    gnupg \
    notmuch \
    abook \
    cronie \
    cmake \
    clang \
    rust \
    hub \
    "

  sudo pacman --noconfirm -Syy figlet
  figlet "Prerequisites for $platform"

  # uncomment this if keys are out of date - it is really slow
#  sudo pacman-key --refresh-keys
  gpg --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
  sudo pacman -S --noconfirm $PACKAGES_TO_INSTALL
  ln -sf /usr/bin/chromium /usr/local/bin/google-chrome
  if [[ ! -e ~/github/arch/yay ]]; then
    mkdir -p ~/github/arch
    cd ~/github/arch
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
  fi
  # install AUR packages
  yay -S --noconfirm unzip unrar hwinfo mhwd tree fontconfig-infinality checkupdates pacman-contrib thermald geekbench
  yay -S --noconfirm  htop dropbox dropbox-cli  traceroute  rr-bin gometalinter python python2 python-pip

  sudo pip3 install neovim

  rm -rf ~/.dropbox-dist
  install -dm0 ~/.dropbox-dist

  # enable services
  sudo systemctl enable thermald.service
  sudo systemctl enable tlp.service

elif [[ $platform == 'macos' ]]; then
  install neofetch 
  install ctags
  install boost 
  install boost-python 
  install boost-python3
fi

git config --global user.email "mykesx@gmail.com"
git config --global user.name "Michael Schwartz"


