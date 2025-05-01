#!/bin/bash
echo "Merging Live ISO filesystem with /mnt"
# rsync -a --update --progress /run/archiso/airootfs/ /mnt/
rsync -a --update --progress \
  --exclude='home/**' \
  --exclude='var/log/**' \
  --exclude='boot/**' \
  --exclude='proc/**' \
  --exclude='dev/**' \
  --exclude='run/**' \
  / /mnt/
