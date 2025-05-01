#!/bin/bash
echo "Test in QEMU KVM"
echo "Running" $0 "as" $USER | boxes -d warning
qemu-img create -f qcow2 /var/tmp/Entropy-Prototype.qcow2 20G
sleep 1
qemu-system-x86_64 \
  -enable-kvm \
  -m 16G \
  -smp 8 \
  -drive file=/var/tmp/Entropy-Prototype.qcow2,format=qcow2 \
  -cdrom $(ls /var/tmp/out/*.iso) \
  -boot d \
  -name Entropy-Prototype
