set nocompatible

" plug {{{
" ==============================================================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'kien/ctrlp.vim'
Plug 'crusoexia/vim-dracula'
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Raimondi/delimitMate'

Plug 'Valloric/YouCompleteMe', { 'for': ['cpp', 'c'], 'do': 'python3 ./install.py --clang-completer' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable', 'for': ['cpp', 'c'] }

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }

Plug 'jceb/vim-orgmode', { 'for': 'org' }
Plug 'tpope/vim-speeddating', { 'for': 'org' }

Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }

call plug#end()

" }}}
" common {{{
" ==============================================================================

let mapleader = ','
let maplocalleader = ' '

set autoindent
set autoread
set backspace=eol,start,indent
set cursorline
set encoding=utf8
set expandtab
set ffs=unix,dos,mac
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set magic
set mat=2
set modelines=1
set nobackup
set noerrorbells visualbell vb t_vb=
set noswapfile
set nowb
set nowrap
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

" Enable I-beam cursor in terminal
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

try
  set undodir=~/.vim/tmpdirs/undodir
  set undofile
catch
endtry

let g:load_doxygen_syntax = 1

" }}}
" maps {{{
" ==============================================================================

nnoremap ; :

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l

nnoremap <CR> o<esc>
nnoremap <S-CR> O<esc>

vnoremap < <gv
vnoremap > >gv

nnoremap <leader>e :tabnew ~/.dotfiles/.vimrc<CR>
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

nnoremap <silent> <Esc><Left> :tabprev<CR>
nnoremap <silent> <Esc><Right> :tabnext<CR>
nnoremap <silent> <Esc>h :tabprev<CR>
nnoremap <silent> <Esc>l :tabnext<CR>

nnoremap <silent> <Esc>1 :tabnext 1<CR>
nnoremap <silent> <Esc>2 :tabnext 2<CR>
nnoremap <silent> <Esc>3 :tabnext 3<CR>
nnoremap <silent> <Esc>4 :tabnext 4<CR>
nnoremap <silent> <Esc>5 :tabnext 5<CR>

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nnoremap <TAB> za

nnoremap <silent> <leader><leader> :e#<CR>

" }}}
" colorscheme {{{
" ==============================================================================

set background=dark

try
  colorscheme dracula
catch
endtry

exec "set colorcolumn=" . join(range(81, 300), ',')

" }}}
" airline {{{
" ==============================================================================

let g:airline_theme = "powerlineish"
let g:airline_powerline_fonts = 1

" }}}
" ctrlp {{{
" ==============================================================================

let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 0
let g:ctrlp_show_hidden = 1

set wildignore=*.o,*.so,*.swp,*.cmake,*.log,*.bin,*~,*.pyc

" }}}
" UltiSnips {{{
" ==============================================================================

" Trigger configuration. Do not use <TAB> if you use YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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
let NERDTreeIgnore = ['\.swp']
let NERDTreeChDirMode = 2 " Change CWD whenever tree root is changed
let NERDTreeMinimalUI = 1
let NERDTreeWinSize = 35

nnoremap <leader>n :NERDTreeTabsToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

let g:nerdtree_tabs_open_on_gui_startup = 0

" }}}
" Git Gutter {{{
" ==============================================================================

"if exists('&signcolumn')
"    set signcolumn=yes
"else
"    let g:gitgutter_sign_column_always = 1
"endif

hi GitGutterAdd    guifg=#009900 guibg=NONE ctermfg=2 ctermbg=NONE
hi GitGutterChange guifg=#bbbb00 guibg=NONE ctermfg=3 ctermbg=NONE
hi GitGutterDelete guifg=#ff2222 guibg=NONE ctermfg=1 ctermbg=NONE

let g:gitgutter_enabled=0

nnoremap <silent> <leader>d :GitGutterToggle<cr>

" }}}
" Helper functions {{{
" ==============================================================================

function! FormatFile()
    let l:lines="all"
    py3f ~/.clang-format.py
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" }}}

" vim:foldmethod=marker:foldlevel=0
