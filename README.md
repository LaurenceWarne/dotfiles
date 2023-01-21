# Setup

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

Install Powerline, Nerd, tamsyn, siji and fontawesome fonts:

```bash
mkdir -p ~/.local/share/fonts/{open,true}type &&\
	curl -X GET "https://raw.githubusercontent.com/powerline/fonts/master/Inconsolata/Inconsolata%20for%20Powerline.otf" >| ~/.local/share/fonts/opentype/Inconsolata\ for\ Powerline.otf &&\
	curl -X GET "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf" >| ~/.local/share/fonts/truetype/Hack\ Regular\ Nerd\ Font\ Complete.ttf &&\
	(cd /tmp/ && git clone https://github.com/stark/siji && cd siji && ./install.sh) &&\
	curl -X GET 'http://www.fial.com/~scott/tamsyn-font/download/tamsyn-font-1.11.tar.gz' | tar --gzip -xv -C ~/.local/share/fonts/ &&\
	mv ~/.local/share/fonts/{tamsyn-font*/*.pcf,} && rm -rf ~/.local/share/fonts/tamsyn-font* &&\
	sudo apt install fonts-font-awesome
	fc-cache -fv
```

Check they're installed correctly with:

```bash
fc-list | egrep "Incons|Nerd"
```

## Urxvt

Install it:

```bash
sudo apt install rxvt-unicode
```

Install the `tabbedex` extension:

```bash
mkdir -p $HOME/.urxvt/ext && curl -X GET https://raw.githubusercontent.com/mina86/urxvt-tabbedex/master/tabbedex > $HOME/.urxvt/ext/tabbedex
```
