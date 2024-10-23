# .zlogin is sourced on the start of a login shell. This file is often used to
# start X using startx. Some systems start X on boot, so this file is not always
# very useful.

# .zprofile is basically the same as .zlogin except that it's sourced directly
# before .zshrc is sourced instead of directly after it. According to the zsh
# documentation, ".zprofile is meant as an alternative to `.zlogin' for ksh
# fans; the two are not intended to be used together, although this could
# certainly be done if desired."

# Source https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout

# See also:
# https://wiki.debian.org/EnvironmentVariables

# Export some environment variables
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export PROJECT_HOME=$HOME/projects
export ANDROID_HOME=$HOME/Android/Sdk
# Some reason /sbin not in path
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:/sbin:$HOME/.npm-global/bin:/opt/bin:/snap/bin:$HOME/.cargo/bin:$HOME/.ghcup/bin:/usr/share/sagemath/bin:$HOME/.local/share/coursier/bin
export WINEARCH=win32
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

if ! xset q &>/dev/null; then
    echo "No X server at \$DISPLAY [$DISPLAY]" >&2
    eval "$(ssh-agent -s)"
    if [[ -f "~/bin/clidis" ]]; then
	exec bash ~/bin/clidis
    fi
fi

export PATH="$PATH:/home/laurencewarne/.cache/scalacli/local-repo/bin/scala-cli"
