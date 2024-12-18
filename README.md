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
pacman -Sy
pacman -S sudo git base-devel openssh sway swaybg waybar xorg-xwayland sddm inxi jq rust go firefox rxvt-unicode wlsunset zsh vlc logrotate slurp grim bat otf-font-awesome ttf-font-awesome powerline powerline-fonts nerd-fonts ttc-iosevka xorg-xrdb eog zip unzip curl python-pipx
```

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
```

### yay

Install [yay](https://github.com/Jguer/yay) along with AUR packages:

```
yay -S tamzen-font siji-git ttf-ionicons ttf-font-icons
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

## Dev

```bash
# https://sdkman.io/
curl -s "https://get.sdkman.io" | bash
sdk install java 17.0.9-graalce

# https://get-coursier.io/docs/cli-installation
curl -fL "https://github.com/coursier/launchers/raw/master/cs-$(uname -m)-pc-linux.gz" | gzip -d > ~/bin/cs && chmod +x ~/bin/cs && ~/bin/cs setup
cs install metals
```

Python stuff:

```bash
pipx install pip-run legendary-gl glances mypy tox grip black curses-questions nox protontricks awsume litecli sacad streamlink pulsemixer python-lsp-server ruff dtbell
pipx inject python-lsp-server 'python-lsp-server[rope]' pylsp-mypy python-lsp-ruff
```


## Random Stuff
- [heroic](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest)
