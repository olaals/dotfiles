#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Updating package list..."
sudo apt-update || sudo apt update

echo "Installing fish shell..."
sudo apt install -y fish

echo "Changing default shell to fish..."
# Change the default shell for the current user
chsh -s $(which fish)

echo "Fish shell has been installed and set as the default shell."
echo "Please log out and log back in for the changes to take effect."
