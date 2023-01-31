# Setup

The following describes setup for a Debian-based system.  Install stuff:

```bash
sudo apt install build-essential libpam0g-dev libxcb-xkb-dev sysstat xdotool logrotate rxvt-unicode polybar feh redshift i3
```

## Custom Keyboard Layout

Mostly taken from https://askubuntu.com/questions/482678/how-to-add-a-new-keyboard-layout-custom-keyboard-layout-definition, first:

```bash
curl -X GET https://raw.githubusercontent.com/LaurenceWarne/dotfiles/master/lw_custom | sudo tee /usr/share/X11/xkb/symbols/lw_custom  # sudo curl wouldn't work here since redirection is not part of the execution, tee is a common workaround
```

Now check it works using:

```bash
setxkbmap lw_custom
```

## Fonts

You probably already have `DejaVu Sans Mono`.  First enable bitmapped fonts:

```bash
sudo dpkg-reconfigure fontconfig-config
```

Install Powerline, Nerd, Iosevka, tamsyn, siji and fontawesome:

```bash
mkdir -p ~/.local/share/fonts/{open,true}type &&\
	curl -X GET "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf" >| ~/.local/share/fonts/truetype/Hack\ Regular\ Nerd\ Font\ Complete.ttf &&\
	(cd /tmp/ && git clone https://github.com/stark/siji && cd siji && ./install.sh) &&\
	curl -X GET 'http://www.fial.com/~scott/tamsyn-font/download/tamsyn-font-1.11.tar.gz' | tar --gzip -xv -C ~/.local/share/fonts/ &&\
	mv ~/.local/share/fonts/{tamsyn-font*/*.pcf,} && rm -rf ~/.local/share/fonts/tamsyn-font* &&\
	(cd /tmp/ && curl -L -X GET https://github.com/be5invis/Iosevka/releases/download/v17.0.4/ttf-iosevka-17.0.4.zip >| ttf-iosevka-17.0.4.zip && unzip ttf-iosevka-17.0.4.zip && mv -fv iosevka*.ttf ~/.local/share/fonts/truetype) &&\
	sudo apt install fonts-font-awesome fonts-powerline &&\
	fc-cache -fv
```

Check they're installed correctly with:

```bash
fc-list | egrep "Incons|Nerd|Tamsyn|siji"
```

## Urxvt

Install the `tabbedex` extension:

```bash
mkdir -p $HOME/.urxvt/ext && curl -X GET https://raw.githubusercontent.com/mina86/urxvt-tabbedex/master/tabbedex > $HOME/.urxvt/ext/tabbedex
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

You want to change `module/adapter-network`/`interface` in `modules.ini`.

# SSH

Check if `ssh-agent` has been started by something using `ps -e -o pid,ppid,args G agent` or `echo $SSH_AGENT_PID`.  You can add a key to the agent using `ssh-add ~/.ssh/id_ed25519` for example.  To persist this between restarts, you may need to edit `~/.ssh/config`, see [this](https://stackoverflow.com/a/41145954/10930142) SO post for more information.

## Display Manager

Much of the initialization is done in `.xsession`, which isn't run by display managers like gdm.  However, [SLiM](https://wiki.archlinux.org/title/SLiM) (`sudo apt install slim`) will.  It's themes are located in `/usr/share/slim/themes/` (the theme and other configuration options are located in `/etc/slim.conf`).  I like https://github.com/IvyDowling/slim-theme.

You may also have to disable `ibus` which may reset your keyboard layout after a `setxkbmap` call.  The `Xorg` log is located at `/var/log/Xorg.0.log`.
