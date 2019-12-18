wal -R &
#xset +fp /home/micro/.local/share/fonts
#xset fp rehash
xinput set-prop "DELL08AF:00 06CB:76AF Touchpad" "libinput Accel Speed" 1 &
setxkbmap -option ctrl:swapcaps &
exec i3
