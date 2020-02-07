# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export LANG=en_US.UTF-8

# Configure oh-my-zsh
DISABLE_AUTO_UPDATE=true
DISABLE_MAGIC_FUNCTIONS=true # fix zsh-autosuggestions, speed-up paste
HISTORY_IGNORE='(l|la|ll|lsa|ls|cd|cd -|-|pwd|exit|date|* --help)'

source $HOME/.zgen/zgen.zsh

if ! zgen saved; then
  zgen load zsh-users/zsh-syntax-highlighting # must be before history substring search

  zgen oh-my-zsh
  zgen oh-my-zsh plugins/asdf
  zgen oh-my-zsh plugins/aws
  zgen oh-my-zsh plugins/github
  zgen oh-my-zsh plugins/history-substring-search
  zgen oh-my-zsh plugins/ssh-agent
  zgen oh-my-zsh plugins/z # must be before fz

  zgen load Aloxaf/fzf-tab
  zgen load changyuheng/fz # must be after z
  zgen load hlolli/zsh-better-npm-completion # fork with npx support
  zgen load levito/mix-fast
  zgen load viko16/gitcd.plugin.zsh
  zgen load wfxr/forgit
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-completions

  zgen load romkatv/powerlevel10k powerlevel10k
  zgen save
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f ~/.asdf/plugins/java/set-java-home.sh ]] || source ~/.asdf/plugins/java/set-java-home.sh

export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export NVS_HOME="$HOME/.nvs"
export PATH="$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$HOME/.gpkg:$HOME/.gpkg/bin:$HOME/flutter/bin:$PATH"
export EDITOR='code -wg'
export REACT_EDITOR='code -wg'

if [ -f "$NVS_HOME/nvs.sh" ]; then
  source "$NVS_HOME/nvs.sh"
  nvs use &> /dev/null
  nvs auto on
fi

autoload -U zmv
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias mmv='noglob zmv -W'
alias ncu='npm-check --update'

function avd() {
  local emulator=${ANDROID_SDK_ROOT}/emulator/emulator
  $emulator -list-avds | cat -n
  printf "Select AVD: "
  read index
  avd=$($emulator -list-avds | sed "${index}q;d")
  echo "Selected $avd"
  $emulator -netdelay none -netspeed full -avd $avd
}
function gitk() {
  command gitk "$@" &> /dev/null &
}
function h() {
  print -z $( fc -l 1 | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}
function serve() {
  local port="${1:-8000}";
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}
