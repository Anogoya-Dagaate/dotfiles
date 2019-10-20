#!/bin/bash

figlet "Install vim"

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform == 'linux' ]]; then
  sudo apt-get install -y vim-nox ctags fonts-font-awesome neovim vim-youcompleteme
elif [[ $platform == 'arch' ]]; then
  sudo pacman -S --noconfirm vim ctags neovim
fi

echo ">>> INSTALLING VIM"

mkdir -p ~/.vim/swapfiles

#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PlugInstall +qall

cd ~/dotfiles/vim
yarn add global jsctags eslint prettier eslint-plugin-prettier
git submodule update --init --recursive
#cd bundle/tern_for_vim
#yarn install
if [[ "$platform" == "macos" ]]; then
  cd ../YouCompleteMe
  if [ "$type" = "armv71" ]; then
    export YCM_CORES=$numcpus
    YCM_CORES=$numcpus ./install.py --tern-completer --system-boost --clang-completer --system-libclang
  else
    YCM_CORES=$numcpus ./install.py --tern-completer --clang-completer --system-libclang
  fi
fi
