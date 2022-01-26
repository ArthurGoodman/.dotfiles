set nocompatible

" plug {{{
" ==============================================================================

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Plug 'joshdick/onedark.vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'lifepillar/vim-solarized8'
" Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
" Plug 'drewtempelmeyer/palenight.vim'
" Plug 'Mofiqul/dracula.nvim'

" Plug 'itchyny/lightline.vim'
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

" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeTabsToggle', 'NERDTreeFind'] }
Plug 'jistr/vim-nerdtree-tabs', { 'on': ['NERDTreeTabsToggle', 'NERDTreeFind'] }

" Plug 'sheerun/vim-polyglot'
" Plug 'bfrg/vim-cpp-modern'

" Plug 'jceb/vim-orgmode', { 'for': 'org' }
" Plug 'tpope/vim-speeddating', { 'for': 'org' }

Plug 'nvim-orgmode/orgmode'

Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'christoomey/vim-tmux-navigator'
" Plug 'edkolev/tmuxline.vim'

Plug 'ryanoasis/vim-devicons'

Plug 'nvim-lualine/lualine.nvim'
" Plug 'lukas-reineke/virt-column.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'zchee/deoplete-clang'
" Plug 'Shougo/neoinclude.vim'

" Plug 'jamestthompson3/nvim-remote-containers'

" Plug 'neovim/nvim-lspconfig'
" Plug 'lspcontainers/lspcontainers.nvim'

Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
Plug 'tyru/open-browser.vim', { 'for': 'plantuml' }
Plug 'weirongxu/plantuml-previewer.vim', { 'for': 'plantuml' }

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
set encoding=utf-8
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

set list
set listchars=tab:»·,space:·

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

nnoremap <leader>e :tabnew $MYVIMRC<CR>
nnoremap <leader>t :tabnew<CR>

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

nnoremap <leader><space> :noh<CR>

" nnoremap <leader>s :call FormatFile() <bar> update<CR>

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

" let g:lightline = {
"       \ 'colorscheme': 'powerline',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'FugitiveHead'
"       \ },
"       \ 'component': {
"       \   'lineinfo': '%3l:%-2v%<',
"       \ },
"       \ }

" }}}
" fzf {{{
" ==============================================================================

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
  \ 'header':  ['fg', 'Type'],
  \ 'gutter':  ['bg', 'Normal'] }

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

" nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
" nnoremap <leader>gi :YcmCompleter GoToInclude<CR>

set completeopt-=preview

" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_confirm_extra_conf = 0

" }}}
" delimitMate {{{
"===============================================================================

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

" let g:cpp_class_scope_highlight = 1
" let g:cpp_member_variable_highlight = 1
" let g:cpp_class_decl_highlight = 1

" }}}
" vim-commentary {{{
" ==============================================================================

autocmd FileType c,cpp,glsl,lang7 setlocal commentstring=//\ %s

" }}}
" goyo.vim {{{
" ==============================================================================

" let g:goyo_width = 100
" let g:goyo_height = "100%"
" let g:goyo_linenr = 1

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

" let g:tmuxline_powerline_separators = 0

" }}}
" Helper functions {{{
" ==============================================================================

" function! FormatFile()
"   let l:lines="all"
"   py3f ~/.clang-format.py
" endfunction

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
" neovim {{{
" ==============================================================================

if has("nvim")
    set guicursor=
endif

" }}}
" coc {{{
" ==============================================================================

set updatetime=300
set shortmess+=c
set signcolumn=number

nmap <silent> <leader>rn <Plug>(coc-rename)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent> <expr> <c-space> coc#refresh()

inoremap <silent> <expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap gf <Plug>(coc-format-selected)
vmap gf <Plug>(coc-format-selected)
nmap <silent> gf :Format<CR>

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" " Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent> <nowait> <expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent> <nowait> <expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent> <nowait> <expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent> <nowait> <expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent> <nowait> <expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent> <nowait> <expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent> <nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <nowait> <space>p  :<C-u>CocListResume<CR>

" }}}

lua << END

-- lualine {{{
-- ==============================================================================

require("lualine").setup {
  options = {
    theme = "powerline",
    -- section_separators = "",
    -- component_separators = "",
  }
}

-- }}}
-- virt-column {{{
-- ==============================================================================

-- require("virt-column").setup {
--   char = "│",
-- }

-- }}}
-- nvim-treesitter {{{
-- ==============================================================================

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  },
}

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 999

-- }}}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
})

END

" let g:deoplete#enable_at_startup = 1
" let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
" let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

" vim:foldmethod=marker:foldlevel=0
