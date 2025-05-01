#!/bin/bash
echo "Running" $0 "as" $USER | boxes -d warning
sleep 1
cd $ARCHLIVE/WORKFLOW/REPO
repo-add szmelc.db.tar.gz *.pkg.tar.zst
sleep 1 && tree

cd $ARCHLIVE/WORKFLOW/REPO-FS
repo-add szmelc-fs.db.tar.gz *.pkg.tar.zst
sleep 1 && tree
