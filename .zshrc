# zplug
source $ZPLUG_HOME/init.zsh

zplug "plugins/git",   from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

zplug "yous/vanilli.sh"

zplug "chrissicool/zsh-256color"

# 未インストール項目をインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load

# gitリポジトリの状態を表示する
source "/usr/local/opt/zsh-git-prompt/zshrc.sh"

# 色を初期化
autoload -U colors
colors

# プロンプトの表示設定
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[red]%}%{-%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg_bold[yellow]%}%{!%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{<-%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{->%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}%{..%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{ok%G%}"

PROMPT='%{${fg[blue]}%}%n@%m%{${reset_color}%}:%{${fg_bold[yellow]}%}%~%{${reset_color}%}$(git_super_status)$RESET%#'
# RPROMPT='%D{%G/%m/%d(%a)} %*'
RPROMPT='%D{day%d} %*'


# エイリアス
alias ls='ls -G'
alias rm='rm -i'
