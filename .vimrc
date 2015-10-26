" based on https://github.com/mbrochh/mbrochh-dotfiles/blob/master/.vimrc"
"
" ========================================================================
"
" set tabstop=4 softtabstop=4 shiftwidth=4 :

if &encoding !=# 'utf-8'
    set encoding=utf-8  " The encoding displayed.
endif
set fileencoding=utf-8  " The encoding written to file.<F37>

autocmd! bufwritepost .vimrc source %

filetype off
" Change pathogen#incubate() to pathogen#infect('bundle/{}')
" call pathogen#incubate()
call pathogen#infect('bundle/{}')
call pathogen#helptags()

filetype plugin indent on
syntax on
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"


" General option
" ===============
let mapleader = "\<Space>" " rebind <Leader> key
nnoremap . <NOP>
set wildmode=list:longest " make TAB behave like in a shell
set autoread " reload file when changes happen in other editors
set tags=./tags

set mouse=a
set bs=2 " make backspace behave like normal again
set timeoutlen=500
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile


" make yank copy to the global system clipboard
set clipboard=unnamed


" Improving code completion
set completeopt=longest,menuone


" found here: http://stackoverflow.com/a/2170800/70778
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction
inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


" Quicksave command
noremap <Leader>w :update<CR>
vnoremap <Leader>w <C-C>:update<CR>


" Quick quit command
noremap <Leader>q <esc>:quit<CR>


" Bind nohl
noremap <Leader>h :nohl<CR>

set history=700
set undolevels=700


set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

au BufRead,BufNewFile *.rb,*.rhtml,*.proto set tabstop=2 shiftwidth=2 softtabstop=2
au BufRead,BufNewFile *.js,*.html,*.proto set tabstop=2 shiftwidth=2 softtabstop=2


" disable formatting when pasting large chunks of code
set pastetoggle=<F2>

set hlsearch
set incsearch
set ignorecase
set smartcase

set nowrap " don't automatically wrap on load
set tw=79  " width of document (used by gd)
set fo-=t  " don't automatically wrap text when typing

" Awesome line number magic
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  endif
  set invnumber
  if(&number == 1)
    set number relativenumber
  endif
endfunc

nnoremap <Leader>l :set relativenumber!<cr>
nnoremap <Leader>L :call NumberToggle()<cr>
:au FocusLost * set norelativenumber number
:au FocusGained * set relativenumber number
autocmd InsertEnter * set norelativenumber number
autocmd InsertLeave * set relativenumber number
set number relativenumber

" center the cursor vertically
:nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>


" easier formatting of paragraphs
vmap Q gq
nmap Q gqap


" Settings for vim-flake8
" ====================
"autocmd BufWritePost *.py call Flake8()
"


" Settings for Airline
" ====================
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


" Settings for Lightline
" ======================

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
    \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'readonly': 'LightLineReadonly',
    \   'modified': 'LightLineModified',
    \   'filename': 'LightLineFilename',
    \   'fileformat': 'LightLineFileformat',
    \   'filetype': 'LightLineFiletype',
    \   'fileencoding': 'LightLineFileencoding',
    \   'mode': 'LightLineMode',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction


function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0


" Settings for tmuxline
" =====================
" let g:tmuxline_theme = 'airline'


" Settings for Syntastic
" ======================
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['flake8', 'pylint']
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_signs = 1
let g:syntastic_style_error_symbol = '☓❱'
let g:syntastic_style_warning_symbol = '⚐❭'
let g:syntastic_error_symbol = '😑 '
let g:syntastic_warning_symbol = '😭 '
"map <F7> <esc>:SyntasticCheck<CR>
"map <F8> <esc>:SyntasticToggleMode<CR>


" Settings for Neomake
" ===================
let g:neomake_open_list = 1
map <F7> <esc>:Neomake<CR>
map <F9> <esc>:NeomakeSh ./invoke testpy<CR>
let g:neomake_python_pylama_maker = {
    \ 'args': ['--verbose', '--linters="pep8,pep257,mccabe"'],
    \ }
autocmd! BufWritePost * Neomake


" Settings for JSHint
" ===================
map <F12> <esc>:JSHintUpdate<CR>


" Settings for jedi-vim
" =====================
let g:jedi#completions_enabled = 0
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = "0"
let g:jedi#goto_assignments_command = "<leader>pa"
let g:jedi#goto_definitions_command = "<leader>pd"
let g:jedi#documentation_command = "<leader>pk"
let g:jedi#usages_command = "<leader>pu"
let g:jedi#rename_command = "<leader>pr"


map <Leader>B Oimport ipdb as _xxPDB; _xxPDB.set_trace();  # BREAKPOINT<C-c>
map <Leader>b Oimport pudb as _xxPDB; _xxPDB.set_trace();  # BREAKPOINT<C-c>
map <Leader><c-b> Oimport pdb as _xxPDB; _xxPDB.set_trace();  # BREAKPOINT<C-c>


" Settings for powerline
" ===========================
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)


" Settings for vim-markdown
" ==========================
" let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=1


" UltiSnips
" =========
set runtimepath+=~/.vim/bundle/UltiSnips
set runtimepath+=~/.vim/ulti_snippets
set runtimepath+=~/.vim/ulti_snippets
let g:UltiSnipsSnippetsDir = "~/.vim/ulti_snippets/"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'ulti_snippets', 'vim_snippets']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" Settings for ctrlp
" ===================
let g:ctrlp_max_height = 30
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" configures CtrlP to use git or silver searcher for autocompletion
let g:ctrlp_use_caching = 0

let g:ctrlp_working_path_mode = 'a'
" 'c' - the directory of the current file.
" 'r' - the nearest ancestor that contains one of these directories or files:
"       .git .hg .svn .bzr _darcs
" 'a' - like c, but only if the current working directory outside of CtrlP
"       is not a direct ancestor of the directory of the current file.
" 0 or '' (empty string) - disable this feature.

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>


"" Settings for Ags
" ===============
let g:ags_agargs = {
    \ '--break'             : [ '', '' ],
    \ '--color'             : [ '', '' ],
    \ '--color-line-number' : [ '"1;30"', '' ],
    \ '--color-match'       : [ '"32;40"', '' ],
    \ '--color-path'        : [ '"1;31"', '' ],
    \ '--column'            : [ '', '' ],
    \ '--context'           : [ 'g:ags_agcontext', '-C' ],
    \ '--filename'          : [ '', '' ],
    \ '--group'             : [ '', '' ],
    \ '--heading'           : [ '', '-H' ],
    \ '--max-count'         : [ 'g:ags_agmaxcount', '-m' ],
    \ '--numbers'           : [ '', '' ]
    \ }


" Settings for vim-easymotion
" ===========================
let g:EasyMotion_do_mapping = 1 " Disable default mappings

map <Leader>m <Plug>(easymotion-prefix)

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


" key bindings for Tabular plugin
" ===============================
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
nmap <Leader>t: :Tabularize /:\zs<CR>
vmap <Leader>t: :Tabularize /:\zs<CR>
nmap <Leader>t\| :Tabularize /\|<CR>
vmap <Leader>t\| :Tabularize /\|<CR>


" key bindings for tagbar plugin
" ==============================
nmap <F8> :TagbarToggle<CR>


" key bindings for tagbar plugin
" ==============================
let g:ackprg = 'ag --vimgrep'


" NerdTree
" =========================
map <Leader>nt :NERDTreeToggle<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" Startify
" ========
let g:startify_custom_header = map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['','']


" IndentGuides
" ==========================
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2


" vim-expand-region
" =================
" Hit v to select one character
" Hit v again to expand selection to word
" Hit v again to expand to paragraph
" Hit <C-v> go back to previous selection if I went too far
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


" Movement
" =========
" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

if bufwinnr(1)
    map + <C-W>>
    map - <C-W><
endif

map <Leader>t <esc>:tabnew<CR>
map <Leader>, <esc>:tabprevious<CR>
map <Leader>. <esc>:tabnext<CR>
vnoremap <Leader>s :sort<CR>

map <Leader>[ <esc>:lprevious<CR>
map <Leader>] <esc>:lnext<CR>

" Window spliting
" ==============
nmap <leader>\| :vs<CR>
nmap <leader>- :split<CR>


" Custom mappings
" ===============
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation
map <Leader>a ggVG  " select all


" Current line & column mappings
" ==============================
nmap <Leader>c <esc>:set cursorline! cursorcolumn!<CR>
set cursorline cursorcolumn


" Diff mappings
" =============
nmap <Leader><Leader>d <esc>:diffthis<CR> <esc>:set nocursorline nocursorcolumn<CR>
nmap <Leader><Leader>D <esc>:diffoff<CR> <esc>:set cursorline cursorcolumn<CR>

" Fixing the copy & paste madness
" ================================
vmap <C-y> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
imap <C-v> <Esc><C-v>a

" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Color scheme
" =============
set t_Co=256
set background=dark

" tmux doesn't support true color, so need to install a patched version of tmux
" brew install https://raw.githubusercontent.com/choppsv1/homebrew-term24/master/tmux.rb
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" http://tilvim.com/2013/07/31/swapping-bg.html
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

"
"let g:base16_shell_path="~/dotfiles/external/base16-shell"
"let base16colorspace=256
"colorscheme base16-tomorrow
"colorscheme PaperColor
" colorscheme hybrid_material
let g:gruvbox_contrast_light='hard'
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_invert_tabline=1
let g:gruvbox_invert_selection=1
let g:gruvbox_invert_signs=1
let g:gruvbox_improved_strings=0
let g:gruvbox_improved_warnings=1
let g:gruvbox_vert_split='bg3'
let g:gruvbox_color_column='bg1'
let g:gruvbox_sign_column='bg2'
colorscheme gruvbox

set colorcolumn=80
"autocmd ColorScheme * highlight ColorColumn ctermbg=235 ctermfg=7
"autocmd ColorScheme * highlight SignColumn ctermbg=10
"autocmd ColorScheme * highlight SpellBad ctermfg=7 ctermbg=1

highlight Search ctermfg=232
highlight Visual ctermfg=15 ctermbg=24
autocmd ColorScheme * highlight Visual ctermfg=15 ctermbg=24

"set the showmatch highlight
"highlight MatchParen cterm=none ctermbg=238 ctermfg=5
"set the linenumber highlight
"highlight LineNr ctermfg=241
"keep the original fg color at cursor column
highlight CursorColumn ctermfg=7 guifg=white guibg=grey20
highlight DiffAdd cterm=none ctermbg=194 ctermfg=244
highlight DiffDelete cterm=none ctermbg=210 ctermfg=232
highlight DiffChange cterm=none ctermbg=229 ctermfg=232
highlight DiffText cterm=none ctermbg=3 ctermfg=232

" Show trailing whitespace
" =========================
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Highlight for IndentGuides
" ==========================
highlight IndentGuidesOdd ctermbg=235
highlight IndentGuidesEven ctermbg=237
autocmd ColorScheme * highlight IndentGuidesOdd ctermbg=235
autocmd ColorScheme * highlight IndentGuidesEven ctermbg=237


" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
" if &listchars ==# 'eol:$'
"   set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
" endif
set listchars=eol:¬,tab:▸▸,trail:.,extends:»,precedes:«
set list                " Show problematic characters.

au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/


map <Leader>x :%s/\s\+$//


" reload .vimrc file
" =========================
map <Leader>v :source ~/.vimrc<CR>


if has("unix")
  let s:uname = system("uname")
  let g:python_host_prog='/usr/bin/python'
  "if s:uname == "Darwin\n"
  ""  let g:python_host_prog='/usr/local/bin/python' # found via `which python`
  "endif
endif
