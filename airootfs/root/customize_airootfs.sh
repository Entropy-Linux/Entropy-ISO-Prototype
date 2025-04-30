#!/bin/bash
# This runs during build process
echo "AIROOTFS CUSTOM SCRIPT..."

# ACCOUNTS
useradd -m -G wheel -s /bin/bash entropy
echo "entropy:entropy" | chpasswd
echo "root:root" | chpasswd

# enable sudo for wheel group
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# ZSHRC
# cp /root/.zshrc /etc/skel/.zshrc

# BRANDING
echo "Customizing Brand"
echo "entropy" > /etc/hostname
echo "Entropy Linux [Bv1] [Releng] [2025.04.12]" > /etc/entropy-release
echo "Welcome to Entropy Linux" > /etc/issue

# Link usr/lib/os-release
# ln -sf /etc/os-release /usr/lib/os-release

# Shell
chsh -s /bin/zsh root
sed -i 's|^SHELL=.*|SHELL=/bin/zsh|' /etc/default/useradd

# SERVICES
# Network
systemctl enable NetworkManager
systemctl enable sshd
# Desktop
systemctl enable sddm

# EXTRA SCRIPTS
figlet "SCRIPTS"
pwd
#bash ../szmelc/isw/scripts/chaotic.sh
bash scripts/test.sh

sleep 1
figlet "COMPLETE"

# Unmount /proc
umount -l /proc || true

sleep 1
