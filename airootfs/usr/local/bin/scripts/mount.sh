#!/bin/bash

lsblk
read -rp "Enter root partition (e.g. sda2): " part
root="/dev/$part"

# Mount root
sudo mount "$root" /mnt

# Bind necessary system dirs
for d in proc sys dev run; do
  sudo mount --bind /$d /mnt/$d
done

# Inject script into /mnt/root/
cat << 'EOF' | sudo tee /mnt/root/create_entropy.sh > /dev/null
#!/bin/bash
useradd -m -G wheel entropy
echo "entropy:entropy" | chpasswd
sed -i 's/^# %wheel/%wheel/' /etc/sudoers
EOF

sudo chmod +x /mnt/root/create_entropy.sh

# Run inside chroot
sudo arch-chroot /mnt /root/create_entropy.sh
sudo rm /mnt/root/create_entropy.sh

# Drop to user in chroot
sudo arch-chroot /mnt runuser -l entropy
