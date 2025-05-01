#!/bin/bash
sleep 1
echo "Executing..." $0 "as" $USER
sleep 1

export SIUSIAK="BIG, very huge!"
sleep 1 && echo $SIUSIAK
