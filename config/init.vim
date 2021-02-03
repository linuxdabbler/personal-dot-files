" general settings
let mapleader = " "             " set leader key to space

set title
set path+=**                    " searches current directory recursively.
set wildmode=longest,list,full  " auto complete mode/menu

set nocompatible

set tabstop=4 softtabstop=4     " sets tabs equal to 4 spaces
set shiftwidth=4                " sets shift width to 4 spaces
set expandtab                   " converts tabs to spaces
set smartindent                 " attempts to properly indent

set showcmd                     " shows current command
set showmode                    " shows current mode

filetype plugin on
syntax on                       " enables syntax highlighting

set number                      " shows line numbers
set relativenumber              " shows line numbers relative to the cursor position

set nowrap                      " does not allow lines to wrap

set ignorecase                  " ignores case when searching
set smartcase                   " turns on case sensitive search when letters are capitalized
set incsearch                   " sets incremental search


set scrolloff=8                 " starts scrolling the page when cursor is # lines from the bottom

set encoding=utf-8

set nohlsearch                  " turns off highlight after enter is pressed when searching

set mouse=nicr                  " mouse scrolling

set clipboard+=unnamedplus

call plug#begin()

Plug 'https://github.com/zchee/hybrid.nvim'                 " hybrid colorscheme
Plug 'https://github.com/vifm/vifm.vim'                     " vifm incorporation
Plug 'https://github.com/vim-python/python-syntax'          " python syntax highlighting
Plug 'https://github.com/kovetskiy/sxhkd-vim'               " sxhkd highlighting
Plug 'https://github.com/PotatoesMaster/i3-vim-syntax'      " i3 config highlighting
Plug 'https://github.com/ap/vim-css-color'                  " color previes for CSS
Plug 'https://github.com/tpope/vim-surround'                " easier way to surround text with whatever characters you want    
Plug 'https://github.com/vimwiki/vimwiki'                   " vim wiki plugin
Plug 'https://github.com/bling/vim-airline'                 " vim-airline is pretty

call plug#end()


colorscheme hybrid              " sets color scheme to hybrid

set splitbelow splitright       " sets split behavior


" remap split navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" adjust split sizes easier
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>

" change 2 split windows from vertical to horizontal or vice versa
map <leader>th <C-w>t<C-w>H
map <leader>tk <C-w>t<C-w>K

" remap ESC to ii
:imap ii <Esc>

" open vifm in a vertical split
nnoremap <leader>vs :VsplitVifm<>CR

" better diff highlighting
if &diff
    highlight! link DiffText MatchParen
endif
