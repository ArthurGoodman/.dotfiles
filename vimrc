set nocompatible

" Trailing Whitespaces {{{
function ShowSpaces(...)
    let @/='\v(\s+$)|( +\ze\t)'
    let oldhlsearch=&hlsearch
    if !a:0
        let &hlsearch=!&hlsearch
    else
        let &hlsearch=a:1
    end
    return oldhlsearch
endfunction

function TrimSpaces() range
    let oldhlsearch=ShowSpaces(1)
    execute a:firstline.",".a:lastline."substitute ///gec"
    let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   :TrimSpaces<CR>
" }}}
" clang-format {{{
function FormatFile()
    let l:lines="all"
    py3f /home/nikita/ADASPlatformRoot/BuildTools/host_env_setup/linux/build/llvm/tools/clang/tools/clang-format/clang-format.py
endfunction

map <C-K> :call FormatFile()<CR>
imap <C-K> <c-o>:call FormatFile()<CR>
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
" Line Shortcuts {{{
nnoremap j gj
nnoremap k gk
nnoremap gv ggVG
" }}}
" Leader Shortcuts {{{
let mapleader = ","
nnoremap <leader>1 :set number!<CR> :set relativenumber!<CR>
nnoremap <leader>ev :vsp ~/.dotfiles/vimrc<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>a :Ag 
nnoremap <leader><space> :noh<CR>
nnoremap <leader>n :NERDTree<CR>
nnoremap <leader>s :call FormatFile() \| update<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
"vnoremap <leader>y "+y
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

" Git wrapper
Plugin 'tpope/vim-fugitive'

" A Vim plugin which shows a git diff in the gutter (sign column) and
" stages/undoes hunks.
Plugin 'airblade/vim-gitgutter'

" A tree explorer plugin
Plugin 'scrooloose/nerdtree'

" quoting/parenthesiizng made simple
Plugin 'tpope/vim-surround'

" semantic code completion and more
Plugin 'https://github.com/Valloric/YouCompleteMe'

" config generator from CMakeLists for YCM code completion plugin
Plugin 'https://github.com/rdnetto/YCM-Generator'

" fuzzy file search/goto
Plugin 'https://github.com/kien/ctrlp.vim'

" useful shortcuts
Plugin 'https://github.com/tpope/vim-unimpaired'

" snippets engine plugin
Plugin 'SirVer/ultisnips'

" popular snippets for the snippets engine
Plugin 'honza/vim-snippets'

" A light and configurable statusline/tabline plugin
Plugin 'itchyny/lightline.vim'

" Wombat color scheme
Plugin 'sheerun/vim-wombat-scheme'

" Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module /
" CLI script 'ack'
Plugin 'rking/ag.vim'

" All of your Plugins must be added before the following line

call vundle#end()
filetype plugin indent on
" }}}
" Color Scheme {{{
syntax enable
colorscheme wombat
" }}}
" Custom Color Cheme Settings {{{
hi NonText ctermfg=241 ctermbg=234
set colorcolumn=101
" }}}
" YouCompleteMe {{{
highlight YcmErrorSection guibg=#3f0000
nnoremap gf :YcmCompleter GoToInclude<CR>
set completeopt-=preview 
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_confirm_extra_conf = 0
" }}}
" ctrlp {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
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

" vim:foldmethod=marker:foldlevel=0
