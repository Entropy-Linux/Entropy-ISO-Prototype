#!/bin/bash
echo "Merging Squashfs filesystem (/szmelc) with /"
rsync -a --update --progress \
  --exclude='scripts/**' \
  /szmelc/ /
