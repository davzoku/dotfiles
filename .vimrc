" === Basic UI ===
set number              " show line numbers
" set relativenumber      " relative line numbers
syntax on               " enable syntax highlighting
set cursorline          " highlight current line

" === Tabs & indentation ===
set tabstop=4
set shiftwidth=4
set expandtab           " use spaces instead of tabs
set autoindent
set smartindent

" === Search ===
set ignorecase          " case insensitive search
set smartcase           " unless uppercase used
set incsearch           " search as you type
set hlsearch            " highlight matches

" === Usability ===
set clipboard=unnamedplus   " use system clipboard
set mouse=a                " enable mouse
set scrolloff=8            " keep context when scrolling
set nowrap                 " don’t wrap lines

" === Performance ===
set lazyredraw
set ttyfast

" === File handling ===
set hidden                " allow switching buffers
set nobackup
set nowritebackup
set noswapfile

" === Colors ===
set termguicolors
colorscheme unokai

" === Leader key ===
let mapleader=" "

" === Useful shortcuts ===
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>h :nohlsearch<CR>