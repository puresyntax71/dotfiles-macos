export LC_ALL="en_US.UTF-8"

zstyle ':prezto:module:editor' dot-expansion 'yes'
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:git:status:ignore' submodules 'all'
# zstyle ':prezto:module:prompt' theme 'pure'
zstyle ':prezto:module:ruby:chruby' auto-switch 'yes'
zstyle ':prezto:module:ssh:load' identities 'id_rsa'

export NVM_DIR="$HOME/.nvm"
source ~/.zplug/init.zsh
# source ~/.zplug/init.zsh

# Prezto modules. {{{

zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/utility", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/prompt", from:prezto
zplug "modules/git", from:prezto
zplug "modules/archive", from:prezto
zplug "modules/syntax-highlighting", from:prezto
zplug "modules/rsync", from:prezto
zplug "modules/history-substring-search", from:prezto
zplug "modules/python", from:prezto
zplug "modules/ruby", from:prezto
zplug "modules/fasd", from:prezto, defer:2
zplug "modules/ssh", from:prezto
zplug "modules/node", from:prezto
zplug "modules/gpg", from:prezto
zplug romkatv/powerlevel10k, as:theme, depth:1

zstyle ":prezto:module:completion" loaded 'yes'

# Prezto settings. {{{

export BROWSER='google-chrome'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

typeset -gU cdpath fpath mailpath path

cdpath=(
  $HOME/Devel
  $cdpath
)

path=(
  $HOME/bin
  # $(brew --prefix homebrew/php/php56)/bin
  /usr/local/opt/gnu-tar/libexec/gnubin
  $HOME/Library/Haskell/bin
  /usr/local/mysql/bin
  $HOME/.composer/vendor/bin
  $HOME/.config/composer/vendor/bin
  /usr/local/{bin,sbin}
  $HOME/.cargo/bin
  $path
)

export TMPDIR="/tmp/$USER"
mkdir -p -m 700 "$TMPDIR"
TMPPREFIX="${TMPDIR%/}/zsh"
mkdir -p "$TMPPREFIX"

# }}}

# }}}

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# zplug load --verbose
zplug load

# source <(gopass completion zsh)
# export PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH
# export NVM_DIR="$HOME/.nvm"
# source "/usr/local/opt/nvm/nvm.sh"

z() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

function blt() {
  if [ "`git rev-parse --show-cdup 2> /dev/null`" != "" ]; then
    GIT_ROOT=$(git rev-parse --show-cdup)
  else
    GIT_ROOT="."
  fi

  if [ -f "$GIT_ROOT/vendor/bin/blt" ]; then
    $GIT_ROOT/vendor/bin/blt "$@"
  else
    echo "You must run this command from within a BLT-generated project repository."
    return 1
  fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:$(yarn global bin)"
