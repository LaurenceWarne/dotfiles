alias ap='apropos'
alias ll='ls -alhF'
alias nano='nano -PSilm'
alias e='echo'
#alias c='cat'
alias mkdir='mkdir -p'
alias g='./gradlew'
alias xres='xrdb ~/.Xresources'
alias rmd='rm -rf'
alias j='fasd_cd -d'
alias cp='cp -f'
alias rm='rm -f'
alias lpstat='lpstat -l'
alias ip='ip -c'

## Cool Stuff
# See https://github.com/chubin/wttr.in
alias weather="curl -L wttr.in"
alias wthr="curl -L wttr.in"
alias matrix="cmatrix -B"
alias github-preview="grip"
alias sbcl="rlwrap sbcl"
alias gl="glances"
alias tron="ssh sshtron.zachlatta.com"
# https://github.com/sharkdp/bat
command -v bat >/dev/null 2>&1 || alias bat="batcat"
alias less="bat"
alias c="bat"

## Pipes
alias -g G="| grep"
