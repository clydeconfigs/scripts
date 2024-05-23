#!/usr/bin/fish

if test (count $argv) -eq 1
    set device $argv[1]
    set lol (basename $device)

    if sudo cryptsetup isLuks $device >/dev/null
        sudo umount /dev/mapper/$lol || exit 1
        sudo cryptsetup luksClose $lol || exit 1
        echo "[ec] unmounted"
    else
        sudo umount /mnt/$lol || exit 1
        echo "[ec] unmounted"
    end
end

echo "syncing..."
sync
echo "sync done..."
