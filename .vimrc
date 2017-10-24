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
    py3f ~/.clang-format-py
endfunction

" !Breaks tab in GVim
" map <C-I> :call FormatFile()<CR>
" imap <C-I> <c-o>:call FormatFile()<CR>
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
" set ignorecase
set hlsearch
set wildignorecase
" }}}
" Splits Navigation {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}
" Movement/Editing {{{
nnoremap <CR> o<esc>
nnoremap <S-CR> O<esc>
" }}}
" Folding {{{
nnoremap <space> za
" }}}
" Leader Shortcuts {{{
let mapleader = ","

" Toggle line numbers
nnoremap <leader>1 :set relativenumber!<CR>

nnoremap <leader>ev :vsp ~/.dotfiles/.vimrc<CR>

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
nnoremap <silent> <leader>s :call FormatFile() <bar> update<CR>

nnoremap <leader>b :wa <bar> !cmake --build build<CR>
nnoremap <leader>r :wa <bar> !cmake --build build --target run<CR>
nnoremap <leader>c :wa <bar> !cmake build<CR>
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

    " Change Cursor shape in terminal
    if !has("gui_running")
        " Changing cursor shape
        autocmd VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
        autocmd InsertEnter,InsertChange *
            \ if v:insertmode == 'i' |
            \   silent execute '!echo -ne "\e[5 q"' | redraw! |
            \ elseif v:insertmode == 'r' |
            \   silent execute '!echo -ne "\e[3 q"' | redraw! |
            \ endif
        autocmd VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
    endif

    " :nohlsearch on <esc>
    " !Breaks arrows in normal mode, doesn't work in GVim
    " autocmd TermResponse * nnoremap <esc> :noh<return><esc>

    " Disable bells
    set noerrorbells visualbell t_vb=
    autocmd GUIEnter * set visualbell t_vb=
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
Plugin 'jistr/vim-nerdtree-tabs'

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
" Plugin 'itchyny/lightline.vim'

" Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module / CLI script 'ack'
Plugin 'rking/ag.vim'

" !Breaks <leader>s
" Extended Visual Mode Commands, Substitutes, and Searches
" Plugin 'vim-scripts/vis'

" Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
Plugin 'Raimondi/delimitMate'

" lean & mean status/tabline for vim that's light as air
Plugin 'vim-airline/vim-airline'

" A collection of themes for vim-airline
Plugin 'vim-airline/vim-airline-themes'

" Alternate Files quickly (.c --> .h etc)
Plugin 'vim-scripts/a.vim'

" Color Schemes
Plugin 'sheerun/vim-wombat-scheme'
Plugin 'sjl/badwolf'
Plugin 'altercation/vim-colors-solarized'
Plugin 'joshdick/onedark.vim'
Plugin 'crusoexia/vim-monokai'
Plugin 'dracula/vim'

" BufExplorer Plugin for Vim
Plugin 'jlanzarotta/bufexplorer'

" All of your Plugins must be added before the following line

call vundle#end()
filetype plugin indent on
" }}}
" Color Scheme {{{
syntax enable
set background=dark
colorscheme wombat

if g:colors_name == "wombat"
    hi NonText ctermfg=241 ctermbg=234 guifg=#626262 guibg=#242424
    hi LineNr ctermfg=241 ctermbg=234 cterm=none guifg=#857b6f guibg=#242424 gui=none
endif

execute "set colorcolumn=" . join(range(101,335), ',')
" }}}
" YouCompleteMe {{{
hi YcmErrorSection guibg=#3f0000

nnoremap <F2> :YcmCompleter GoToInclude<CR>
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
" set laststatus=2
"
" let g:lightline = {
"     \ 'colorscheme' : 'powerline',
"     \ 'active' : {
"     \ 'left' : [ [ 'mode', 'paste' ],
"     \ ['gitbranch', 'readonly', 'filename', 'modified'] ]
"     \ },
"     \ 'component_function' : {
"     \ 'gitbranch' : 'fugitive#head'
"     \ },
"     \ }
" }}}
" Visual @ {{{
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
        execute ":'<,'>normal @".nr2char(getchar())
endfunction
" }}}
" NERDTree {{{
let NERDTreeMapActivateNode = '<space>'
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.swp']

nmap <silent> <leader>j :NERDTreeFind<CR>
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>

let g:nerdtree_tabs_open_on_gui_startup = 0
" }}}
" Git Gutter {{{
" !TODO Change colors of marks for GVim
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
" !Change colors for GVim
hi DiffAdd ctermfg=15 ctermbg=22 guifg=#ffffff guibg=#005f00
hi DiffChange ctermfg=15 ctermbg=22 guifg=#ffffff guibg=#005f00
hi DiffText ctermfg=15 ctermbg=34 guifg=#ffffff guibg=#00af00
hi DiffDelete ctermfg=1 ctermbg=1 guifg=#800000 guibg=#800000
" }}}
" GVim {{{
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guifont=Menlo\ for\ Powerline\ 10
" }}}
" delimitMate {{{
let delimitMate_expand_cr = 1
" }}}
" vim-airline {{{
let g:airline_theme = 'powerlineish'
if has("gui_running")
    let g:airline_powerline_fonts = 1
endif
" }}}
" a.vim {{{
nnoremap <F4> :A<CR>
" }}}
" Fullscreen {{{
map <silent> <F11>
            \ :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
" }}}
" Switching Buffers {{{
nnoremap <silent> <c-tab> :bn<CR>
nnoremap <silent> <s-c-tab> :bp<CR>
" }}}

" vim:foldmethod=marker:foldlevel=0
