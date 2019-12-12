# .zshrc is for interactive shell configuration. You set options for
# the interactive shell there with the setopt and unsetopt commands.
# You can also load shell modules, set your history options, change
# your prompt, set up zle and completion, et cetera. You also set any
# variables that are only used in the interactive shell 
# (e.g. $LS_COLORS).


source ~/bin/antigen.zsh
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
export TERM="xterm-256color"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle autojump
antigen bundle colored-man-pages
antigen bundle django
antigen bundle git
antigen bundle gradle
antigen bundle pip
antigen bundle python
antigen bundle shrink-path

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme bhilburn/powerlevel9k powerlevel9k

# powerlevel9k config
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

POWERLEVEL9K_CONTEXT_TEMPLATE=%F{green}%n@%m

# Tell Antigen that you're done.
antigen apply

# Load aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Export some environment variables
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export PROJECT_HOME=$HOME/projects
export ANDROID_HOME=$HOME/Android/Sdk
# Some reason /sbin not in path
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:/sbin:$HOME/.npm-global/bin:/opt/bin:
export WINEARCH=win32
source /usr/local/bin/virtualenvwrapper.sh
