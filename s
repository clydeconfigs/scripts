#!/usr/bin/bash

test -z $1 && exit 1

case $1 in
    e) scrypt enc --passphrase file:/stupidkey --logN 21 -r8 -p1 $2 $2.scrypt;;
    d) scrypt dec --passphrase file:/stupidkey $2;;
esac
