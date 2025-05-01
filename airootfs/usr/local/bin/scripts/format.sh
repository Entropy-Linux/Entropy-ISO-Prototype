#!/bin/bash

# Show block devices
lsblk
read -rp "Enter target disk (e.g. sda): " disk

disk="/dev/$disk"

# Safety confirmation
read -rp "!! ALL DATA ON $disk WILL BE LOST. Continue? [y/N]: " confirm
[[ "$confirm" != "y" ]] && exit 1

# Wipe & create msdos partition table
sudo parted "$disk" --script mklabel msdos

# Create 512MiB FAT32 partition
sudo parted "$disk" --script mkpart primary fat32 1MiB 513MiB
sudo parted "$disk" --script set 1 boot on

# Create ext4 root partition
sudo parted "$disk" --script mkpart primary ext4 513MiB 100%

# Format partitions
sudo mkfs.vfat -F32 -n boot "${disk}1"
sudo mkfs.ext4 -L / "${disk}2"

echo "✅ Partitioning and formatting complete on $disk"
