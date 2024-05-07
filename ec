#!/usr/bin/fish

if test (count $argv) -eq 1
    set device $argv[1]

    set lol (basename $device)

    if sudo umount /dev/mapper/$lol; and sudo cryptsetup luksClose $lol
        echo "[ec] unmounted"
    else
        sudo umount $lol
        echo "[ec] unmounted"
    end
end

sync
