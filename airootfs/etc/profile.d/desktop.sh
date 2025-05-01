#!/bin/bash
sleep 1
echo "Executing..." $0 "as" $USER
sleep 1
plasma-apply-wallpaperimage /usr/local/share/backgrounds/default.png
lookandfeeltool -a org.kde.breezedark.desktop
