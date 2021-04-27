set nocompatible

" plug {{{
" ==============================================================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Plug 'joshdick/onedark.vim'
" Plug 'crusoexia/vim-dracula'
" Plug 'altercation/vim-colors-solarized'
" Plug 'lifepillar/vim-solarized8'
" Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
" Plug 'drewtempelmeyer/palenight.vim'

Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterToggle' }

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !python3 ./install.py --clang-completer
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeTabsToggle', 'NERDTreeFind'] }
Plug 'jistr/vim-nerdtree-tabs', { 'on': ['NERDTreeTabsToggle', 'NERDTreeFind'] }

Plug 'sheerun/vim-polyglot'

Plug 'jceb/vim-orgmode', { 'for': 'org' }
Plug 'tpope/vim-speeddating', { 'for': 'org' }

Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'

call plug#end()

" }}}
" common {{{
" ==============================================================================

let mapleader = ','
let maplocalleader = ' '

set autoindent
set autoread
set backspace=eol,start,indent
set colorcolumn=101
set cursorline
set encoding=utf8
set expandtab
set fileformats=unix,dos,mac
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set magic
set matchtime=2
set modelines=1
set mouse=a
set nobackup
set noerrorbells visualbell vb t_vb=
set noshowmode
set noswapfile
set nowrap
set nowritebackup
set number
set relativenumber
set ruler
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set smartindent
set smarttab
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set title
set ttimeoutlen=1000 ttimeoutlen=0
set whichwrap+=<,>,h,l
set wildignorecase
set wildmenu
set wildmode=longest,list,full
set wrapscan
set viminfo=

try
  set undodir=~/.vim/tmpdirs/undodir
  set undofile
catch
endtry

let g:load_doxygen_syntax = 1

if has("termguicolors")
  let &t_8f = "\e[38;2;%lu;%lu;%lum"
  let &t_8b = "\e[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

"set list
"set listchars=eol:↵,tab:>-,trail:~,space:·

" }}}
" maps {{{
" ==============================================================================

nnoremap <silent> <C-Left> <C-w>h
nnoremap <silent> <C-Down> <C-w>j
nnoremap <silent> <C-Up> <C-w>k
nnoremap <silent> <C-Right> <C-w>l

nnoremap <silent> <S-Left> :call SplitResize('h')<CR>
nnoremap <silent> <S-Right> :call SplitResize('l')<CR>
nnoremap <silent> <S-Down> :call SplitResize('j')<CR>
nnoremap <silent> <S-Up> :call SplitResize('k')<CR>

nnoremap <CR> o<Esc>
nnoremap <S-CR> O<Esc>

vnoremap < <gv
vnoremap > >gv

nnoremap <leader>e :tabnew ~/.vimrc<CR>
nnoremap <leader>t :tabnew<CR>

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

nnoremap <leader><space> :noh<CR>

nnoremap <leader>s :call FormatFile() <bar> update<CR>

nnoremap <Esc><Left> :tabprev<CR>
nnoremap <Esc><Right> :tabnext<CR>
nnoremap <Esc>h :tabprev<CR>
nnoremap <Esc>l :tabnext<CR>

nnoremap <Esc>1 :tabnext 1<CR>
nnoremap <Esc>2 :tabnext 2<CR>
nnoremap <Esc>3 :tabnext 3<CR>
nnoremap <Esc>4 :tabnext 4<CR>
nnoremap <Esc>5 :tabnext 5<CR>

vnoremap * :<C-u>call VisualSelection()<CR>/<C-R>=@/<CR><CR>
vnoremap # :<C-u>call VisualSelection()<CR>?<C-R>=@/<CR><CR>

nnoremap <Tab> za

nnoremap <leader><leader> :e#<CR>

nnoremap Q <nop>

nnoremap <leader>a :Ag<CR>

" }}}
" colorscheme {{{
" ==============================================================================

set background=dark

try
  colorscheme gruvbox
catch
endtry

" }}}
" statusline {{{
" ==============================================================================

" let g:airline_theme = 'powerlineish'
" let g:airline_powerline_fonts = 1

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2v%<',
      \ },
      \ }

" }}}
" fzf {{{

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~40%' }

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Constant'],
  \ 'pointer': ['fg', 'Normal'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Type'] }

let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <C-p> :FZF<CR>

" }}}
" UltiSnips {{{
" ==============================================================================

" Trigger configuration. Do not use <Tab> if you use YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-b>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" }}}
" YouCompleteMe {{{
" ==============================================================================

nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>

set completeopt-=preview

let g:ycm_enable_diagnostic_signs = 0
let g:ycm_confirm_extra_conf = 0

" }}}
" delimitMate {{{
" ==============================================================================

let delimitMate_expand_cr = 1

" }}}
" NERDTree {{{
" ==============================================================================

let NERDTreeMapActivateNode = 'l'
let NERDTreeMapChangeRoot = 'L'
let NERDTreeMapUpdirKeepOpen = 'h'
let NERDTreeMapUpdir = 'H'

let NERDTreeShowHidden = 0
let NERDTreeChDirMode = 2 " Change CWD whenever tree root is changed
let NERDTreeMinimalUI = 1
let NERDTreeWinSize = 35

nnoremap <leader>n :NERDTreeTabsToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" }}}
" Git Gutter {{{
" ==============================================================================

let g:gitgutter_enabled=0

nnoremap <silent> <leader>d :GitGutterToggle<CR>

" }}}
" vim-cpp-enhanced-highlight {{{
" ==============================================================================

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" }}}
" vim-commentary {{{
" ==============================================================================

autocmd FileType c,cpp,glsl,lang7 setlocal commentstring=//\ %s

" }}}
" goyo.vim {{{
" ==============================================================================

let g:goyo_width = 100
let g:goyo_height = "100%"
let g:goyo_linenr = 1

" }}}
" markdown-preview {{{
" ==============================================================================

let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 1
    \ }

" }}}
" tmuxline {{{
" ==============================================================================

let g:tmuxline_powerline_separators = 0

" }}}
" Helper functions {{{
" ==============================================================================

function! FormatFile()
  let l:lines="all"
  py3f ~/.clang-format.py
endfunction

function! VisualSelection() range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

function! SplitResize(dir)
  if a:dir ==# 'h' || a:dir ==# 'l'
    let l:pref = 'vertical '
    let l:next = 'l'
  else
    let l:pref = ''
    let l:next = 'j'
  endif
  if (winnr() ==# winnr(l:next)) !=# (a:dir ==# l:next)
    let l:sign = '+'
  else
    let l:sign = '-'
  endif
  exe l:pref . 'resize ' . l:sign . '5'
endfunction

" }}}

" vim:foldmethod=marker:foldlevel=0
