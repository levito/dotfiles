syntax on

" Show relative line numbers
set relativenumber

" Show current position in status bar
set ruler
set autoindent
set smartindent

" Wrap lines
set wrap

" Force the cursor onto a new line after 80 characters
set textwidth=80

" However, in Git commit messages, let's make it 72 characters
autocmd FileType gitcommit set textwidth=72

" Color the 81st (or 73rd) column so that we don't type over our limit
set colorcolumn=+1
hi ColorColumn ctermbg=235 ctermfg=15

" Bash/Emacs-like navigation
map <C-a> <Home>
map! <C-a> <Home>
map <C-e> <End>
map! <C-e> <End>
