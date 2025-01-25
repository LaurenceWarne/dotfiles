[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# .zshrc is for interactive shell configuration. You set options for
# the interactive shell there with the setopt and unsetopt commands.
# You can also load shell modules, set your history options, change
# your prompt, set up zle and completion, et cetera. You also set any
# variables that are only used in the interactive shell 
# (e.g. $LS_COLORS).


export TERM="xterm-256color"

PATH="/home/laurencewarne/perl5/bin${PATH:+:${PATH}}"
PATH="$PATH:/home/laurencewarne/.local/share/coursier/bin:/home/laurencewarne/bin:/sbin:/home/laurencewarne/.local/bin:/snap/bin:/usr/local/texlive/2021/bin/x86_64-linux"
[ -d /usr/local/src/node-v16.15.1-linux-x64 ] && PATH="$PATH:/usr/local/src/node-v16.15.1-linux-x64/bin"
export PATH
PERL5LIB="/home/laurencewarne/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/laurencewarne/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/laurencewarne/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/laurencewarne/perl5"; export PERL_MM_OPT;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

#[ -f "/home/laurencewarne/.ghcup/env" ] && source "/home/laurencewarne/.ghcup/env" # ghcup-env

[ -f "/home/laurencewarne/.ghcup/env" ] && source "/home/laurencewarne/.ghcup/env" # ghcup-env

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
[ -f $(which aws_completer) ] && complete -C $(which aws_completer) aws
export FPATH="/home/laurencewarne/zsh-completions:${FPATH}"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/laurencewarne/.sdkman"
[[ -s "/home/laurencewarne/.sdkman/bin/sdkman-init.sh" ]] && source "/home/laurencewarne/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi
