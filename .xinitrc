export DISPLAY=:2
xrdb -merge ~/.Xresources
setxkbmap -option ctrl:nocaps
xinput set-prop 11 "libinput Accel Speed" 1
xinput set-prop 11 "libinput Tapping Enabled" 1
xinput set-prop 11 "libinput Natural Scrolling Enabled" 1
bum --server joosebox.local --size 600 &
exec i3
