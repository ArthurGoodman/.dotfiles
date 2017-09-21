set nocompatible

" UI/Behaviour {{{
set number
set relativenumber
set showcmd
set cursorline
set wildmenu
set wildmode=longest,list,full
set ttimeoutlen=100
set lazyredraw
set showmatch
set nowrap
set title
set history=1000
set splitbelow
set splitright
set autoread
" }}}
" clang-format {{{
function! FormatFile()
    let l:lines="all"
    py3f ~/ADASPlatformRoot/BuildTools/host_env_setup/linux/build/llvm/tools/clang/tools/clang-format/clang-format.py
endfunction

map <C-I> :call FormatFile()<CR>
imap <C-I> <c-o>:call FormatFile()<CR>
" }}}
" Tabs & Spaces {{{
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set modelines=1
" }}}
" Syntax {{{
let g:load_doxygen_syntax = 1
" }}}
" Search {{{
set incsearch
set ignorecase
set hlsearch
set wildignorecase
" }}}
" Folding {{{
set foldmethod=manual
nnoremap <space> za
" }}}
" Splits {{{
" Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}
" Line Shortcuts {{{
nnoremap j gj
nnoremap k gk
" }}}
" Leader Shortcuts {{{
let mapleader = ","

" Toggle line numbers
nnoremap <leader>1 :set number!<CR> :set relativenumber!<CR>

nnoremap <leader>ev :vsp ~/.dotfiles/vimrc<CR>

" silversearcher-ag
nnoremap <leader>a :Ag 

" Clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

" Reopen last file
nnoremap <leader><leader> :e#<CR>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Remove search highlighting
nnoremap <leader><space> :noh<CR>

" clang-format
nnoremap <leader>s :call FormatFile() \| update<CR>
" }}}
" UltiSnips {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
" Autocmds {{{
augroup configgroup
    autocmd!

    " Header snippet
    autocmd BufNewFile *.hpp :exe "normal iheader\<C-b>"

    " Changing cursor shape
    autocmd VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
    autocmd InsertEnter,InsertChange *
        \ if v:insertmode == 'i' | 
        \   silent execute '!echo -ne "\e[5 q"' | redraw! |
        \ elseif v:insertmode == 'r' |
        \   silent execute '!echo -ne "\e[3 q"' | redraw! |
        \ endif
    autocmd VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!

    " :nohlsearch on <esc>
    " !Breaks arrows in normal mode
    " autocmd TermResponse * nnoremap <esc> :noh<return><esc>
augroup END
" }}}
" Vundle {{{
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" a Git wrapper so awesome, it should be illegal
Plugin 'tpope/vim-fugitive'

" A Vim plugin which shows a git diff in the gutter (sign column) and
" stages/undoes hunks.
Plugin 'airblade/vim-gitgutter'

" A tree explorer plugin for vim.
Plugin 'scrooloose/nerdtree'

" quoting/parenthesizing made simple
Plugin 'tpope/vim-surround'

" A code-completion engine for Vim
Plugin 'Valloric/YouCompleteMe'

" Generates config files for YouCompleteMe
Plugin 'rdnetto/YCM-Generator'

" Fuzzy file, buffer, mru, tag, etc finder.
Plugin 'kien/ctrlp.vim'

" pairs of handy bracket mappings
Plugin 'tpope/vim-unimpaired'

" The ultimate snippet solution for Vim.
Plugin 'SirVer/ultisnips'

" vim-snipmate default snippets
Plugin 'honza/vim-snippets'

" A light and configurable statusline/tabline plugin for Vim
Plugin 'itchyny/lightline.vim'

" Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module / CLI script 'ack'
Plugin 'rking/ag.vim'

" !Breaks <leader>s
" Extended Visual Mode Commands, Substitutes, and Searches
" Plugin 'vim-scripts/vis'

" lean & mean status/tabline for vim that's light as air
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'

" Awesome wombat-like scheme for Vim
Plugin 'sheerun/vim-wombat-scheme'

" A Vim color scheme. 
Plugin 'sjl/badwolf'

" All of your Plugins must be added before the following line

call vundle#end()
filetype plugin indent on
" }}}
" Color Scheme {{{
syntax enable
colorscheme wombat
" }}}
" Custom Color Scheme Settings {{{
hi NonText ctermfg=241 ctermbg=234
set colorcolumn=101
" }}}
" YouCompleteMe {{{
hi YcmErrorSection guibg=#3f0000

nnoremap <leader>i :YcmCompleter GoToInclude<CR>
nnoremap <leader>d :YcmCompleter GoToDeclaration<CR>
set completeopt-=preview 

let g:ycm_enable_diagnostic_signs = 0
let g:ycm_confirm_extra_conf = 0
" }}}
" ctrlp {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_show_hidden = 1

set wildignore=*.o,*.so,*.swp,*.cmake,*.log,*.bin
" }}}
" Lightline {{{
set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'powerline',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }
" }}}
" Visual @ {{{
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
        execute ":'<,'>normal @".nr2char(getchar())
endfunction
" }}}
" AutoBrackets {{{
"inoremap {<CR> {<CR>}<c-o>O
"inoremap [<CR> [<CR>]<c-o>O
"inoremap (<CR> (<CR>)<c-o>O
" }}}
" NERDTree {{{
let NERDTreeMapActivateNode = '<space>'
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.swp']

nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>j :NERDTreeFind<CR>
" }}}
" Git Gutter {{{
if exists('&signcolumn')
    set signcolumn=yes
else
    let g:gitgutter_sign_column_always = 1
endif
" }}}
" vim-fugitive {{{
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>

" git diff color scheme
hi DiffAdd ctermfg=15 ctermbg=22
hi DiffChange ctermfg=15 ctermbg=22
hi DiffText ctermfg=15 ctermbg=34
hi DiffDelete ctermfg=1 ctermbg=1
" }}}
" vim-airline {{{
let g:airline_theme = 'powerlineish'
" }}}

" vim:foldmethod=marker:foldlevel=0
