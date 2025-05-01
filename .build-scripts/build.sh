#!/bin/bash
echo "Starting Build Process"
echo "Running" $0 "as" $USER | boxes -d warning
sudo mkdir -p /var/tmp/work
sudo mkdir -p /var/tmp/out
sudo mkarchiso -v -w /var/tmp/work -o /var/tmp/out .
sleep 1
echo "Complete:"
bsdtar -tf /var/tmp/out/*.iso | grep airootfs.sfs 
sleep 1
