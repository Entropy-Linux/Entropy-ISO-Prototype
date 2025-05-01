#!/bin/bash
echo "Firstboot Live"
bash /usr/local/bin/scripts/customize-kde.sh

sleep 1
# Self Delete
rm -f ~/.config/autostart/firstboot.desktop

