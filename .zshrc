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
  # Load Oh-My-Zsh
  zgen oh-my-zsh

  # Needs to be first plugin
  zgen load seletskiy/zsh-zgen-compinit-tweak

  # Syntax highlighting must be before history substring search
  zgen load zsh-users/zsh-syntax-highlighting

  # Oh-My-Zsh plugins
  zgen oh-my-zsh plugins/asdf
  zgen oh-my-zsh plugins/ssh-agent
  zgen oh-my-zsh plugins/history-substring-search
  zgen oh-my-zsh plugins/z

  # More plugins
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-completions src
  zgen load viko16/gitcd.plugin.zsh

  # Z must be before fz
  zgen load changyuheng/fz

  # Theme
  zgen load romkatv/powerlevel10k powerlevel10k

  zgen save  
fi

# Theme config for powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fancy mv
autoload -U zmv
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias mmv='noglob zmv -W'
alias ncu='npm-check --update'
function mcd() {
  mkdir -p "$@" && cd "$@";
}
function serve() {
  local port="${1:-8000}";
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}
function gitk() {
  command gitk "$@" > /dev/null 2>&1 &
}

source ~/.asdf/plugins/java/set-java-home.sh

export HISTIGNORE="ls:cd:cd -:-:pwd:exit:date:* --help"

export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator"

export EDITOR='code -wg'
export REACT_EDITOR='code -wg'