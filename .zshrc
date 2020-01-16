# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit
compinit

source $HOME/.zgen/zgen.zsh

if ! zgen saved; then
  zgen oh-my-zsh

  zgen load seletskiy/zsh-zgen-compinit-tweak # must be first plugin
  zgen load zsh-users/zsh-syntax-highlighting # must be before history substring search

  zgen oh-my-zsh plugins/asdf
  zgen oh-my-zsh plugins/aws
  zgen oh-my-zsh plugins/history-substring-search
  zgen oh-my-zsh plugins/ssh-agent
  zgen oh-my-zsh plugins/z # must be before fz

  zgen load Aloxaf/fzf-tab
  zgen load changyuheng/fz # must be after z
  zgen load viko16/gitcd.plugin.zsh
  zgen load wfxr/forgit
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-completions src

  zgen load romkatv/powerlevel10k powerlevel10k
  zgen save
fi

# Theme config for powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.asdf/plugins/java/set-java-home.sh

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
function pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
function pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# DISABLE_AUTO_UPDATE=true # oh-my-zsh
HISTORY_IGNORE='(l|la|ll|lsa|ls|cd|cd -|-|pwd|exit|date|* --help)'
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste) # fix zsh-autosuggestions

export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$HOME/flutter/bin"

export EDITOR='code -wg'
export REACT_EDITOR='code -wg'

# Fancy mv
autoload -U zmv
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias mmv='noglob zmv -W'
alias ncu='npm-check --update'

function avd() {
  pushd ${ANDROID_SDK_ROOT}/emulator
  ./emulator -list-avds | cat -n
  printf "Select AVD: "
  read index
  avd=$(./emulator -list-avds | sed "${index}q;d")
  echo "Selected $avd"
  ./emulator -netdelay none -netspeed full -avd $avd
  popd
}
function gitk() {
  command gitk "$@" > /dev/null 2>&1 &
}
function mcd() {
  mkdir -p "$@" && cd "$@";
}
function serve() {
  local port="${1:-8000}";
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}
