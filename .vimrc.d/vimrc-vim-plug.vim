call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

Plug 'benekastah/neomake'
Plug 'kien/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'vim-scripts/MultipleSearch2.vim'

" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'tmhedberg/SimpylFold'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-fugitive'

" Loaded when Dockerfile is opened
Plug 'ekalinin/Dockerfile.vim'

" Loaded when javascript file is opened
Plug 'davidhalter/jedi-vim', { 'for': 'python '}
Plug 'vim-scripts/django.vim', { 'for': 'python '}

" Loaded when markdown file is opened
Plug 'suan/vim-instant-markdown', { 'for': 'markdown '}
Plug 'plasticboy/vim-markdown', { 'for': 'markdown '}

" Loaded when javascript file is opened
Plug 'wookiehangover/jshint.vim', { 'for': 'javascript '}
Plug 'pangloss/vim-javascript', { 'for': 'javascript '}

Plug 'Lokaltog/vim-easymotion'
Plug 'rodjek/vim-puppet'
Plug 'terryma/vim-multiple-cursors'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-dispatch'
Plug 'gabesoft/vim-ags'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-startify'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'terryma/vim-expand-region'
Plug 'khzaw/vim-conceal'
Plug 'junegunn/vim-plug'
Plug 'guns/xterm-color-table.vim'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

Plug 'SirVer/ultisnips'

Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }

call plug#end()
