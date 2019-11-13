set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'isRuslan/vim-es6'
Plugin 'rhysd/vim-crystal'
Plugin 'rust-lang/rust.vim'
Plugin 'rking/ag.vim'
Plugin 'cespare/vim-toml'
Plugin 'leafgarland/typescript-vim'

call vundle#end()
filetype plugin indent on
syntax on

set backspace=indent,eol,start
set clipboard=unnamed
set colorcolumn=81
set expandtab
set history=10000
set hlsearch
set incsearch
set list
set listchars=trail:~
set mouse=a
set nofoldenable
set noswapfile
set nowrap
set number
set shiftwidth=2
set smartindent
set softtabstop=2
set t_Co=256
set tabstop=2
set title
set updatetime=500
set wildmode=list:longest,list:full

autocmd FileType Markdown setlocal spell

highlight LineNr ctermfg=grey

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:ctrlp_custom_ignore = {'dir': '\v[\/](tmp|node_modules|target|public)', 'file': '\v\.(exe|so|dll)$'}
let g:syntastic_html_tidy_ignore_errors=['proprietary attribute', 'trimming empty', 'discarding unexpected', 'is not recognized!', 'invalid value']

" remap escape key to delete, handy on kinesis advantage
vnoremap <Del> <esc>
noremap! <Del> <esc>
