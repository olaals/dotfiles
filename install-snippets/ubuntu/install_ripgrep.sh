#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Updating package list..."
sudo apt-update || sudo apt update

echo "Installing ripgrep..."
sudo apt install -y ripgrep

echo "ripgrep installation complete!"
