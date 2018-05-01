set nocompatible

" TODO Move this probably...
let mapleader = ","

" UI/Behaviour {{{
" ==============================================================================

set number
set relativenumber
set showcmd
set cursorline

" Turn on the Wild menu
set wildmenu
set wildmode=longest,list,full
set ttimeoutlen=100

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set title

" Sets how many lines of history VIM has to remember
set history=1000
set splitbelow
set splitright

" Set to auto read when a file is changed from the outside
set autoread

" Operator mode tilde
" set tildeop

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn persistent undo on
try
    set undodir=~/.vim/tmpdirs/undodir
    set undofile
catch
endtry

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Linebreak on 500 characters
set lbr
set tw=500

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"Always show current position
set ruler

" For regular expressions turn magic on
set magic

" }}}
" Tabs & Spaces {{{
" ==============================================================================
"
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
set softtabstop=4
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set modelines=1

" Always show status line
set laststatus=2

" }}}
" Syntax {{{
" ==============================================================================

" Enable syntax highlighting
syntax enable

" Enable Doxygen syntax highlighting
let g:load_doxygen_syntax = 1

" }}}
" Search {{{
" ==============================================================================

" Makes search act like search in modern browsers
set incsearch

" Ignore case when searching
set ignorecase
set wildignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch
set wrapscan

" When you press gv you Ag after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>cn :cn<cr>
map <leader>cp :cp<cr>

" }}}
" Splits Navigation {{{
" ==============================================================================

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" }}}
" Buffers {{{
" ==============================================================================

" TODO Move other buffer commands here
nnoremap <silent> <c-tab> :bn<CR>
nnoremap <silent> <s-c-tab> :bp<CR>

" }}}
" Movement/Editing {{{
" ==============================================================================

nnoremap ; :

nnoremap <CR> o<esc>
nnoremap <S-CR> O<esc>

vnoremap < <gv
vnoremap > >gv

nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

xnoremap p "_dP

" }}}
" Folding {{{
" ==============================================================================

" TODO Maybe move to another section
nnoremap <space> za

" }}}
" Leader Shortcuts {{{
" ==============================================================================

" TODO Document all statements
" TODO Rearrange all commands properly

nnoremap <leader>e :vsp ~/.dotfiles/.vimrc<CR>

" silversearcher-ag
nnoremap <leader>a :Ag 

" Clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

" Reopen last file
nnoremap <silent> <leader><leader> :e#<CR>

" Fast saving
nnoremap <leader>w :w!<CR>
nnoremap <leader>q :q!<CR>

" Remove search highlighting
nnoremap <leader><space> :noh<CR>

" clang-format
nnoremap <leader>s :call FormatFile() <bar> update<CR>

" nnoremap <leader>b :wa <bar> !cmake --build build<CR>
" nnoremap <leader>r :wa <bar> !cmake --build build --target run<CR>
" nnoremap <leader>c :wa <bar> !cmake build<CR>

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab

  " Always show tabs
  " set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

nnoremap <leader>r :wa<cr>:silent exec "!x-terminal-emulator -e ./run.sh"<cr>

" }}}
" Spell checking {{{
" ==============================================================================

" " Pressing ,ss will toggle and untoggle spell checking
" map <leader>ss :setlocal spell!<cr>
" 
" " Shortcuts using <leader>
" map <leader>sn ]s
" map <leader>sp [s
" map <leader>sa zg
" map <leader>s? z=

" }}}
" Autocmds {{{
" ==============================================================================

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

    " Disable bells
    set noerrorbells visualbell t_vb=
    autocmd GUIEnter * set visualbell t_vb=
augroup END

" }}}
" Vundle {{{
" ==============================================================================

filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

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

" Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
Plugin 'Raimondi/delimitMate'

" lean & mean status/tabline for vim that's light as air
Plugin 'vim-airline/vim-airline'

" A collection of themes for vim-airline
Plugin 'vim-airline/vim-airline-themes'

" Alternate Files quickly (.c --> .h etc)
Plugin 'vim-scripts/a.vim'

" TODO Fix shortcuts conflicts
" GDB command line interface and terminal emulator in (G)Vim
" Plugin 'vim-scripts/Conque-GDB'

" Color Schemes
Plugin 'sheerun/vim-wombat-scheme'
Plugin 'sjl/badwolf'
Plugin 'altercation/vim-colors-solarized'
Plugin 'crusoexia/vim-monokai'
Plugin 'crusoexia/vim-dracula'
Plugin 'rakr/vim-one'

" All of your Plugins must be added before the following line

call vundle#end()
filetype plugin indent on

" }}}
" UltiSnips {{{
" ==============================================================================
"
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" }}}
" Color Scheme {{{
" ==============================================================================

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=dark

try
    colorscheme dracula
catch
endtry

if g:colors_name == "wombat"
    hi NonText ctermfg=241 ctermbg=234 guifg=#626262 guibg=#242424
    hi LineNr ctermfg=241 ctermbg=234 cterm=none guifg=#857b6f guibg=#242424 gui=none
endif

" execute "set colorcolumn=" . join(range(81,335), ',')
execute "set colorcolumn=81"

" }}}
" YouCompleteMe {{{
" ==============================================================================

" TODO Think about these
" nnoremap <F2> :YcmCompleter GoToInclude<CR>
" nnoremap <leader>d :YcmCompleter GoToDeclaration<CR>
set completeopt-=preview

let g:ycm_enable_diagnostic_signs = 0
let g:ycm_confirm_extra_conf = 0

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
" Lightline {{{
" ==============================================================================

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
" NERDTree {{{
" ==============================================================================

let NERDTreeMapActivateNode = '<space>'
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.swp']

let g:NERDTreeWinSize=35

nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nn :NERDTreeTabsToggle<CR>
nnoremap <leader>nb :NERDTreeFromBookmark<Space>

let g:nerdtree_tabs_open_on_gui_startup = 0

" }}}
" Git Gutter {{{
" ==============================================================================

" Always show sign column
if exists('&signcolumn')
    set signcolumn=yes
else
    let g:gitgutter_sign_column_always = 1
endif

" Disable diff by default
let g:gitgutter_enabled=0

" Toggle diff
nnoremap <silent> <leader>d :GitGutterToggle<cr>

" }}}
" vim-fugitive {{{
" ==============================================================================

" Split Diff vertically
set diffopt+=vertical

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>

" Color scheme
hi DiffAdd ctermfg=15 ctermbg=22 guifg=#ffffff guibg=#277027
hi DiffChange ctermfg=15 ctermbg=22 guifg=#ffffff guibg=#277027
hi DiffText ctermfg=15 ctermbg=34 guifg=#ffffff guibg=#339d33
hi DiffDelete ctermfg=1 ctermbg=1 guifg=#8c2d2d guibg=#8c2d2d

" }}}
" GVim {{{
" ==============================================================================

if has("gui_running")
    " Set extra options when running in GUI mode
    set guioptions-=T
    set guioptions-=e
    set guioptions-=m
    set guioptions-=r
    set guioptions-=R
    set guioptions-=L
    set guioptions-=l
    set t_Co=256
    set guitablabel=%M\ %t
    set guifont=Menlo\ for\ Powerline\ 10
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" }}}
" delimitMate {{{
" ==============================================================================

let delimitMate_expand_cr = 1

" }}}
" vim-airline {{{
" ==============================================================================

" let g:airline#extensions#tabline#enabled = 1

let g:airline_theme = 'powerlineish'

if has("gui_running")
    let g:airline_powerline_fonts = 1
endif

" }}}
" a.vim {{{
" ==============================================================================

nnoremap <silent> <F4> :A<CR>

" }}}
" Fullscreen {{{
" ==============================================================================

" TODO Maybe move to another section
map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

" }}}
" Tabs {{{
" ==============================================================================

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let ',tt' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader>tt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switching between tabs
nnoremap <silent> <M-h> :tabprev<CR>
nnoremap <silent> <M-l> :tabnext<CR>

" Switching between tabs by number
nnoremap <silent> <M-1> :tabnext 1<CR>
nnoremap <silent> <M-2> :tabnext 2<CR>
nnoremap <silent> <M-3> :tabnext 3<CR>
nnoremap <silent> <M-4> :tabnext 4<CR>
nnoremap <silent> <M-5> :tabnext 5<CR>

" }}}
" Command mode {{{
" ==============================================================================

" :W sudo saves the file 
command! W w !sudo tee % > /dev/null

" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" Deletes everything until the last slash 
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" }}}
" Helper functions {{{
" ==============================================================================

function! FormatFile()
    let l:lines="all"
    py3f ~/.clang-format.py
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
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

function! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif   

    return g:cmd_edited
endfunc

function! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc
" }}}
" Conque-GDB {{{
" ==============================================================================

" 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_Color = 2

" close conque when program ends running
let g:ConqueTerm_CloseOnEnd = 1

" display warning messages if conqueTerm is configured incorrectly
let g:ConqueTerm_StartMessages = 0

" }}}

" vim:foldmethod=marker:foldlevel=0
