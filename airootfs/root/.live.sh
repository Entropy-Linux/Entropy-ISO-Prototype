#!/bin/bash
clear
touch ass
echo "This script runs on live ISO" 
echo "User:" $USER > ass
echo "Host:" $HOST >> ass
echo "PWD:" $PWD >> ass
cat ass
mv ass /
# sleep 1
# pacman -Sy
# sleep 2
# bash /szmelc/isw/init.sh
