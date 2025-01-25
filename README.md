# Arch Setup

## Installation

Follow the instructions here: https://wiki.archlinux.org/title/Installation_guide and here https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition, making sure to follow commands in the correct sequence, which may be disjointed between pages (the encryption instructions should be explicit in which steps should be done before specific instrunctions in the former - e.g. https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#Preparing_non-boot_partitions should be done in place of https://wiki.archlinux.org/title/Installation_guide#Format_the_partitions).  Gotchas:

- In the BIOS disable secure boot
- Make sure the live usb is booted in UEFI mode
- Ensure that the boot partition type is set to [EFI system partition](https://wiki.archlinux.org/title/EFI_system_partition).

Emacs will make copying device UUIDs for LUKS easier:

```bash
pacstrap -K /mnt base linux linux-firmware emacs iwd man-db man-pages texinfo networkmanager
```

GRUB can be installed using instructions from https://wiki.archlinux.org/title/GRUB#Installation, be sure to generate a [main configuration file](https://wiki.archlinux.org/title/GRUB#Configuration) using `grub-mkconfig -o /boot/grub/grub.cfg`.

Let's enable some services!

```bash
systemctl enable iwd.service --now
systemctl enable NetworkManager.service --now
systemctl enable systemd-resolved.service --now
# Note this starts the service on boot which can impede load times, alternatives: https://wiki.archlinux.org/title/Docker
systemctl enable docker.service --now

ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf # https://wiki.archlinux.org/title/Systemd-resolved#DNS
```

`nmtui` is the easiest way to configure connections.

Create users:

```bash
useradd -m -G wheel,docker -s $(which zsh) laurencewarne
passwd laurencewarne
chage -d 0 laurencewarne # Prompt the user to change their password on first login
EDITOR=emacs visudo      # Uncomment the 'wheel' line
```

## Packages

```
pacman -Sy
pacman -S sudo git base-devel alsa-firmware alsa-utils sof-firmware pulseaudio pulseaudio-alsa openssh sway swaybg waybar xorg-xwayland docker sddm inxi jq rust go firefox wlsunset zsh vlc logrotate slurp grim bat otf-font-awesome ttf-font-awesome powerline powerline-fonts nerd-fonts ttc-iosevka xorg-xrdb eog zip unzip curl python-pipx pavucontrol neofetch nano fuse2 fuse3 imagemagick webkitgtk-6.0 webkit2gtk-4.1 libgccjit libxpm xaw3d xsel evince noto-fonts noto-fonts-emoji noto-fonts-extra xorg-xfd ripgrep mlocate julia pypy3 openvpn sage latte-integrale bash-completion thunderbird libnotify mako postgresql cronie bind net-tools wine lshw lm_sensors lib32-libpulse nwg-look mangohud htop
# Games stuff
pacman -S desmume ppsspp dolphin-emu prismlauncher cataclysm-dda-tiles
```

To enable `sddm`, see https://wiki.archlinux.org/title/Display_manager#Loading_the_display_manager.

## Setup Git and Pull Existing Config 

```
curl -X GET https://raw.githubusercontent.com/LaurenceWarne/dotfiles/refs/heads/master/.gitconfig > $HOME/.gitconfig
```

```
mkdir $HOME/{projects,bin}
cd $HOME/projects
git clone https://github.com/LaurenceWarne/dotfiles
ln -s $HOME/projects/dotfiles/.config $HOME/.config
ln $HOME/projects/dotfiles/.bash_aliases $HOME/.bash_aliases
ln $HOME/projects/dotfiles/.zprofile $HOME/.zprofile
rm $HOME/.gitconfig
ln $HOME/projects/dotfiles/.gitconfig $HOME/.gitconfig
mkdir $HOME/.ssh && echo 'Host *\n    AddKeysToAgent yes' > $HOME/.ssh/config
```

### yay

Install [yay](https://github.com/Jguer/yay) along with AUR packages:

```
yay -S rxvt-unicode-truecolor-wide-glyphs tamzen-font siji-git ttf-ionicons ttf-font-icons heroic-games-launcher-bin abcde aws-cli-v2 openvpn-update-systemd-resolved
yay -S heroic-games-launcher-bin dfhack protontricks
```

## Urxvt

Install the `tabbedex` extension:

```bash
mkdir -p $HOME/.urxvt/ext && curl -X GET https://raw.githubusercontent.com/mina86/urxvt-tabbedex/master/tabbedex > $HOME/.urxvt/ext/tabbedex
```

Hard link `.Xresources`, changing `Xft.dpi` as appropriate:

```bash
ln ~/projects/dotfiles/.Xdefaults ~/.Xresources
ln ~/projects/dotfiles/.Xdefaults ~/.Xdefaults  # For Wayland see https://wiki.archlinux.org/title/Sway#Xresources
xrdb ~/.Xresources
```

## ZSH

```bash
chsh -s $(which zsh)
```

Install [Prezto](https://github.com/sorin-ionescu/prezto):

```bash
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

```bash
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

Hard link `.zpreztorc` and `.zshrc`:

```bash
ln ~/projects/dotfiles/.zpreztorc ~/.zpreztorc
ln ~/projects/dotfiles/.zshrc ~/.zshrc
```

Opening a new shell should now prompt you to configure it.

## Custom Keyboard Layout

Mostly taken from https://askubuntu.com/questions/482678/how-to-add-a-new-keyboard-layout-custom-keyboard-layout-definition, first:

```bash
curl -X GET https://raw.githubusercontent.com/LaurenceWarne/dotfiles/master/lw_custom | sudo tee /usr/share/X11/xkb/symbols/lw_custom  # sudo curl wouldn't work here since redirection is not part of the execution, tee is a common workaround
```

Now check it works using (note not necessary on wayland, we set it in `sway` config there):

```bash
setxkbmap lw_custom
```

## Dev

```bash
# https://sdkman.io/
curl -s "https://get.sdkman.io" | bash
sdk install java 17.0.9-graalce

# https://wiki.archlinux.org/title/Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/latest/install.sh | bash
nvm install 22.12.0
nvm use 22.12.0

# https://get-coursier.io/docs/cli-installation
curl -fL "https://github.com/coursier/launchers/raw/master/cs-$(uname -m)-pc-linux.gz" | gzip -d > ~/.local/bin/cs && chmod +x ~/.local/bin/cs && ~/.local/bin/cs setup
cs install metals
```

Python stuff:

```bash
pipx install pip-run legendary-gl glances mypy tox grip black curses-questions nox protontricks awsume litecli sacad streamlink pulsemixer python-lsp-server ruff dtbell poetry
pipx inject python-lsp-server 'python-lsp-server[rope]' pylsp-mypy python-lsp-ruff
```

## Random Stuff
