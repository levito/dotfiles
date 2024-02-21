# My Dotfiles

Managed via plain git as documented at https://www.atlassian.com/git/tutorials/dotfiles


## Requirements

Set zsh as login shell:
```
chsh -s $(which zsh)
```

Install required software:
```
fzf git git-delta kdiff3 micro
```

Optionally install additional software:
```
android-sdk android-studio aspell broot bun fd gh git-gui ripgrep
```

Install plugins for the micro editor:
```
aspell editorconfig filemanager fzf joinLines quoter wc
```

Some more recommended software (not configured/tracked via dotfiles yet, or no config needed):
```
bat encfs eza gocryptfs jq mdcat sirikali textadept tig trash visual-studio-code volta wezterm yazi
```


## Installation

This will
- clone directly into your home directory
- track changes in `~/.dotfiles` 
- prepare the `dotfiles` command to manage changes via git

```
git clone --bare git@github.com:levito/dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout
dotfiles submodule update --init
dotfiles config --local status.showUntrackedFiles no
```


## Managing the dotfiles

This works just like git, but via the `dotfiles` command from within the home directory.

Track a new/changed file:
```
dotfiles add path/to/file
dotfiles commit
dotfiles push
```

Untrack a tracked file:
```
dotfiles rm --cached path/to/file
dotfiles commit
dotfiles push
```

Update dotfiles on another computer:
```
dotfiles pull
dotfiles submodule update --remote
```
