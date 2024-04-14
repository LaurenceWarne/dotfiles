# Setup

The following describes setup for a Debian-based system.  Install stuff:

```bash
sudo apt install build-essential libpam0g-dev libxcb-xkb-dev sysstat xdotool logrotate rxvt-unicode bat pypy3 zsh htop sagemath network-manager vlc cowsay sddm inxi pavucontrol pipx python3-numpy python3-ipython gnome-screenshot lm-sensors jq radeontop sway waybar slurp grim wlsunset wdisplays mako-notifier fonts-symbola
```

I prefer [mako](https://github.com/emersion/mako) to `dunst`.
```bash
sudo apt remove dunst
```

Set shell:

```bash
chsh -s zsh
```

Python stuff:

```bash
pipx install pip-run legendary-gl glances mypy tox grip black curses-questions nox protontricks awsume litecli sacad streamlink pulsemixer python-lsp-server ruff dtbell
pipx inject python-lsp-server 'python-lsp-server[rope]' pylsp-mypy python-lsp-ruff
```

Note since Debian 12, [Debian declares](https://salsa.debian.org/python-team/packages/python-pip/-/blob/master/debian/NEWS) the system Python (3.11) version to be externally managed in adherence to [PEP-686](https://peps.python.org/pep-0668/), disallowing package installation outside virtual envs.  Recommended is to use `pipx` for packages with entry points or install modules using the package manager, e.g. `sudo apt install python3-numpy`.

There appears to be issues with `chromium` and `mako` notifications, see [here](https://github.com/void-linux/void-packages/issues/33181) for a solution.  `sudo nano /usr/share/wayland-sessions/sway.desktop` and changing `Exec=sway` to `Exec=dbus-run-session sway` ~appears to fix it~ changes nothing, and makes sway startup noticeably slower.

## Custom Keyboard Layout

Mostly taken from https://askubuntu.com/questions/482678/how-to-add-a-new-keyboard-layout-custom-keyboard-layout-definition, first:

```bash
curl -X GET https://raw.githubusercontent.com/LaurenceWarne/dotfiles/master/lw_custom | sudo tee /usr/share/X11/xkb/symbols/lw_custom  # sudo curl wouldn't work here since redirection is not part of the execution, tee is a common workaround
```

Now check it works using (note not necessary on wayland, we set it in `sway` config there):

```bash
setxkbmap lw_custom
```

## Fonts

You probably already have `DejaVu Sans Mono`.

Install Powerline, Nerd, Iosevka, Tamzen, siji and fontawesome:

```bash
mkdir -p ~/.local/share/fonts/{open,true}type &&\
	curl -X GET "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf" >| ~/.local/share/fonts/truetype/Hack\ Regular\ Nerd\ Font\ Complete.ttf &&\
	# Tamzen: https://github.com/sunaku/tamzen-font
	curl -L -X GET https://github.com/sunaku/tamzen-font/archive/refs/tags/Tamzen-1.11.6.tar.gz | tar --gzip -xv -C ~/.local/share/fonts/ &&\
	# Siji: https://github.com/fauno/siji
	curl -X GET https://github.com/fauno/siji/raw/master/ttf/siji.ttf > ~/.local/share/fonts/siji.ttf &&\
	# Ioseveka: https://github.com/be5invis/Iosevka
	(cd /tmp/ && curl -L -X GET https://github.com/be5invis/Iosevka/releases/download/v17.0.4/ttf-iosevka-17.0.4.zip >| ttf-iosevka-17.0.4.zip && unzip ttf-iosevka-17.0.4.zip && mv -fv iosevka*.ttf ~/.local/share/fonts/truetype) &&\
	sudo apt install fonts-font-awesome fonts-powerline &&\
	fc-cache -fv
```

Check they're installed correctly with:

```bash
fc-list | egrep "Incons|Nerd|Tamzen|siji"
```

Generally we want `ttf` fonts as they behave better with scaling.

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

## ZSH

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

Run `p10k configure` to configure powerlevel10k.

## polybar

Soft link the config directory to the corresponding directory in dotfiles:

```bash
ln -s /home/laurencewarne/projects/dotfiles/.config/polybar ~/.config/polybar
```

You may want to change `module/adapter-network`/`interface` in `modules.ini`, and/or configure `modules-right` in `config-bottom.ini` to use `wired-network` instead of `adapter-network`.

Also alter `height` in `config-top.ini` and `config-bottom.ini`, as there seems to be no way to set these based on the font size.

# SSH

Check if `ssh-agent` has been started by something using `ps -e -o pid,ppid,args | grep agent` or `echo $SSH_AGENT_PID`.  You can add a key to the agent using `ssh-add ~/.ssh/id_ed25519` for example.  To persist this between restarts, you may need to edit `~/.ssh/config`, see [this](https://stackoverflow.com/a/41145954/10930142) SO post for more information.

## Display Manager

~Much of the initialization is done in `.xsession`, which isn't run by display managers like gdm~ Switched to ~`i3`~ `sway` which just saves a lot of hassle.  ~However, [SLiM](https://wiki.archlinux.org/title/SLiM) (`sudo apt install slim`) will.  It's themes are located in `/usr/share/slim/themes/` (the theme and other configuration options are located in `/etc/slim.conf`).  I like https://github.com/IvyDowling/slim-theme.~

When using `sddm` make sure to select the correct window manager (e.g. `sway` with `wayland`).

You may also have to disable `ibus` which may reset your keyboard layout after a `setxkbmap` call.  The `Xorg` log is located at `/var/log/Xorg.0.log`.

## Random Stuff

- [sdkman](https://sdkman.io/): `curl -s "https://get.sdkman.io" | bash`
- [Ammonite](http://ammonite.io/#InstallationonLinux): `sudo sh -c '(echo "#!/usr/bin/env sh" && curl -L https://github.com/com-lihaoyi/Ammonite/releases/download/2.5.6/2.13-2.5.6) > /usr/local/bin/amm && chmod +x /usr/local/bin/amm'`
- [coursier](https://get-coursier.io/docs/cli-installation): `curl -fL "https://github.com/coursier/launchers/raw/master/cs-$(uname -m)-pc-linux.gz" | gzip -d > ~/bin/cs && chmod +x ~/bin/cs && ~/bin/cs setup`
- [heroic](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest)
