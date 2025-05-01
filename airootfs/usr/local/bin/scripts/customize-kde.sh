#!/bin/bash

# Replace .zshrc / p10k config for live user
cp /szmelc/.zshrc .
cp /szmelc/.p10k.zsh .

# Set Wallpaper
plasma-apply-wallpaperimage /usr/share/backgrounds/default.png

# Set Breeze Dark Global Theme
lookandfeeltool -a org.kde.breezedark.desktop
