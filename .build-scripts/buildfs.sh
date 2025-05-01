#!/bin/bash
echo "Squashing fs (airootfs/szmelc)"
echo "Running" $0 "as" $USER | boxes -d warning
mksquashfs airootfs/szmelc szmelc.sfs
