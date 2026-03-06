#!/bin/bash
mkdir -p ~/apps
cd ~/apps
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
echo "Neovim AppImage downloaded to ~/apps"
