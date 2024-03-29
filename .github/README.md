# My Dotfiles

Managed via plain git as documented at https://www.atlassian.com/git/tutorials/dotfiles


## Requirements

Install required software:
```
fzf git git-delta kdiff3 micro zsh
```

Set zsh as login shell:
```
chsh -s $(which zsh)
```

Optionally install additional software:
```
android-sdk android-studio aspell bat broot bun fd gh git-gui ripgrep tig wezterm yazi
```

Install plugins for the micro editor:
```
micro -plugin install aspell editorconfig filemanager fzf joinLines lsp quoter wc
```

Some more recommended software (not configured/tracked via dotfiles yet, or no config needed):
```
encfs eza gocryptfs jq mdcat sirikali textadept trash typescript-language-server visual-studio-code
```

For node support and management, install volta:
```
curl https://get.volta.sh | bash -s -- --skip-setup
```

Install recommended global npm modules:
```
volta install catj emma-cli fixpack git-recent np npkill npm-merge-driver npm-why prettier stylelint yalc
```

It's recommended to install the [Meslo Nerd Font patched for Powerlevel10k](https://github.com/romkatv/powerlevel10k/tree/master?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k) ([Source](https://github.com/romkatv/nerd-fonts)).


## Installation

This will
- clone directly into your home directory
- track changes in `~/.dotfiles` 
- prepare the `dotfiles` command to manage changes via git

```
git clone --bare https://github.com/levito/dotfiles.git $HOME/.dotfiles
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
