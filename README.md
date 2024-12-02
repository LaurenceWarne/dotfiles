# Arch Setup

## Installation

Follow the instructions here: https://wiki.archlinux.org/title/Installation_guide and here https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition, making sure to follow commands in the correct sequence, which may be disjointed between pages (the encryption instructions should be explicit in which steps should be done before specific instrunctions in the former).  Emacs will make copying device UUIDs for LUKS easier:

```bash
# pacstrap -K /mnt base linux linux-firmware emacs iwd man-db man-pages texinfo networkmanager
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
$ pacman -S sudo sway xorg-xwayland sddm inxi jq rust firefox rxvt-unicode
```
