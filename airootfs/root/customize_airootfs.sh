#!/bin/bash
# This runs during build process
# DEBUG DELAY
sleep 1
clear
sleep 1
figlet "==C=="
echo "Running" $0 "as" $USER | boxes -d warning
echo $ARCHLIVE && pwd
export airootfs_dir=${ARCHLIVE}/airootfs

echo "Configuring Locales"
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
export LANG=en_US.UTF-8

echo "LANG=en_US.UTF-8" > "${airootfs_dir}/etc/locale.conf"
echo "en_US.UTF-8 UTF-8" >> "${airootfs_dir}/etc/locale.gen"
arch-chroot "${airootfs_dir}" locale-gen

# ACCOUNTS
# Entropy

# Set root password to 'root'
echo "root:root" | chpasswd
# Create 'entropy' user with home dir
useradd -m -s "$(which zsh)" entropy
# Remove password (no login prompt)
passwd -d entropy
# Add user to essential groups
usermod -aG wheel,adm,systemd-journal,network,power,audio,video,storage entropy
# Set root shell to zsh
chsh -s "$(which zsh)" root
# Enable sudo for wheel group
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
# Passwordless sudo setup
echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/99-entropy
chmod 0440 /etc/sudoers.d/99-entropy

# BRANDING
echo "Customizing Brand"
echo "entropy" > /etc/hostname
echo "Entropy Linux [Bv1] [Releng]" > /etc/entropy-release
echo "Welcome to Entropy Linux" > /etc/issue

# Shell
chsh -s /bin/zsh root
chsh -s /bin/zsh entropy
sed -i 's|^SHELL=.*|SHELL=/bin/zsh|' /etc/default/useradd

# SERVICES
systemctl enable NetworkManager
systemctl enable sshd
systemctl enable sddm

# EXTRA SCRIPTS
figlet "SCRIPTS"

echp "Desktop"
export QT_QPA_PLATFORM=xcb
export XDG_SESSION_TYPE=x11
dbus-launch startplasma-x11

# Repo
figlet "Repos"
sudo pacman -Sy
sudo pacman -Sl szmelc-fs

sleep 1
figlet "Chroot"

su - entropy -c '
echo "Running" $0 "as" $USER | boxes -d warning
sudo chmod +x /usr/local/bin/firstboot.sh
sudo chmod +x /usr/local/bin/scripts/*
sudo cp /etc/skel/.config/autostart/firstboot.desktop ~/.config/autostart/firstboot.desktop
sudo chmod +x ~/.config/autostart/*
sudo pacman -Sy --noconfirm
'

# sudo cat /root/.zshrc > ~/.zshrc
# sudo cat /root/.p10k.zsh > ~/.p10k.zsh

sleep 1
figlet "COMPLETE"

# Unmount /proc
umount -l /proc || true

sleep 1
