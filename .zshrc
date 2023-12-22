setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_pushd
setopt combining_chars
setopt correct
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt ignore_eof
setopt magic_equal_subst
setopt no_beep
setopt nolistbeep
setopt pushd_ignore_dups
setopt share_history
unsetopt caseglob

alias ls='ls -G'
alias rm='rm -i'

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

export ZPLUG_HOME=/opt/homebrew/opt/zplug

source $ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

PROMPT="%F{blue}%n@%m%f:%F{yellow}%~%f %#"

eval "$(/opt/homebrew/bin/brew shellenv)"

. "$HOME/.cargo/env"

function peco_history() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco_history
bindkey '^r' peco_history

function peco_ghq() {
  local repository=$(ghq list | peco)
  if [[ -n "$repository" ]]; then
    BUFFER="cd $(ghq root)/${repository}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N peco_ghq
bindkey '^g' peco_ghq

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
