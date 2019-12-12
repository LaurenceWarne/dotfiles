# This file is run by using the startx command with NO client program

# from the startx manpage:
# Note that in the Debian system, what many people traditionally put
# in  the .xinitrc file should go in .xsession instead; this permits
# the same X environment to be presented  whether  startx,  xdm,  or
# xinit is used to start the X session.

# Set keyboard layout to my custom layout which remaps altgr to alt
setxkbmap lw_custom

# Load .Xresources for urxvt
xrdb ~/.Xresources

# Allows us to use touchpad and keyboard simultaneously
xinput --set-prop 11 300 0

# Sets background
feh --bg-scale ~/Pictures/distant-nebula-wallpaper-hd.jpg

xset +fp /home/laurencewarne/.local/share/fonts
xset fp rehash

#####################################################################################################
# For this next snippet check out:								    #
# https://wiki.archlinux.org/index.php/Xinit#Switching_between_desktop_environments/window_managers #
# To use this functionality you need to run:                                                        #
# $ startx ~/.xsession session                                                                      #
#####################################################################################################
# Set i3 as default wm
session=${1:-i3}

# To list installed DEs/WMs:
# $ ls /usr/share/xsessions
case $session in
    i3|i3wm           ) exec i3;;
    gnome             ) exec gnome-session;;
    xfce|xfce4        ) exec startxfce4;;
    # No known session, try to run it as command
    *                 ) exec $1;;
esac
