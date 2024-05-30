#!/usr/bin/fish

function message
    switch $argv[2]
        case "1" 
            tput bold; echo -n "-> "; tput setaf 1; echo "$argv[1]"; tput sgr0
        case "2" 
            tput setaf 63; echo -n " * "; tput setaf 12; echo "$argv[1]"; tput sgr0
        case '*' 
            tput setaf 39; echo -n "-> "; tput setaf 25; echo "$argv[1]"; tput sgr0
    end
end

if test (count $argv) -eq 1
    set device $argv[1]
    set lol (basename $device)

    if sudo cryptsetup isLuks /dev/$lol >/dev/null
        message "unmounting..."
        sudo umount /mnt/$lol || begin
            message "failed to unmount /mnt/$lol..." 1
            exit 1
        end
        message "closing /dev/mapper/$device..."
        sudo cryptsetup close $lol || begin
            message "failed to close /dev/mapper/$device..." 1
            exit 1
        end
        message "all cryptsetup devices closed successfully!" 2
    else
        message "unmounting..."
        sudo umount /mnt/$lol || sudo umount $device || exit 1
        message "all devices closed successfully!" 2
    end
end

message "syncing..."
sync
