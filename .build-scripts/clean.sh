#!/bin/bash
echo "Cleaning Build"
echo "Running" $0 "as" $USER | boxes -d warning
sleep 1
sudo rm -fr /var/tmp/work
sudo rm -fr /var/tmp/out
sleep 0.1
# Clean Test VM
rm /var/tmp/Entropy-Prototype.qcow2
sleep 0.2
df /var/tmp
sleep 2
