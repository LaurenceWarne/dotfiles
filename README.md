# Arch Setup

## Installation

Follow the instructions here: https://wiki.archlinux.org/title/Installation_guide and here https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition, making sure to follow commands in the correct sequence, which may be disjointed between pages (the encryption instructions should be explicit in which steps should be done before specific instrunctions in the former).  Emacs will make copying device UUIDs for LUKS easier:

```bash
pacstrap -K /mnt base linux linux-firmware emacs iwd man-db man-pages texinfo networkmanager
```

GRUB can be installed using instructions from https://wiki.archlinux.org/title/GRUB#Installation, be sure to generate a [main configuration file](https://wiki.archlinux.org/title/GRUB#Configuration) using `grub-mkconfig -o /boot/grub/grub.cfg`.

Next ensure all services are enabled:

```bash
systemctl enable iwd.service --now
systemctl enable NetworkManager.service --now
systemctl enable systemd-resolved.service --now

ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf # https://wiki.archlinux.org/title/Systemd-resolved#DNS
```

`nmtui` is the easiest way to configure connections.

## Packages

```
pacman -S sudo base-devel openssh sway swaybg waybar xorg-xwayland sddm inxi jq rust go firefox rxvt-unicode wlsunset zsh vlc logrotate slurp grim bat powerline powerline-fonts nerd-fonts ttc-iosevka xorg-xrdb eog
```

### yay

Install [yay](https://github.com/Jguer/yay) along with AUR packages:

```
yay -S tamzen-font siji-git
```

## Urxvt

Install the `tabbedex` extension:

```bash
mkdir -p $HOME/.urxvt/ext && curl -X GET https://raw.githubusercontent.com/mina86/urxvt-tabbedex/master/tabbedex > $HOME/.urxvt/ext/tabbedex
```

Hard link `.Xresources`:

```bash
ln ~/projects/dotfiles/.Xresources ~/.Xresources
ln ~/projects/dotfiles/.Xdefaults ~/.Xdefaults  # For Wayland see https://wiki.archlinux.org/title/Sway#Xresources
xrdb ~/.Xresources
```
