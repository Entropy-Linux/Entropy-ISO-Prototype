#!/bin/bash

# Exit on error
set -e

# Install required packages
sudo pacman -Sy --needed git base-devel

# Clone yay repo
git clone https://aur.archlinux.org/yay.git /tmp/yay

# Build and install yay
cd /tmp/yay
makepkg -si

# Cleanup
cd ~
rm -rf /tmp/yay
