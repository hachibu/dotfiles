set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'w0rp/ale'
"Plugin 'vim-airline/vim-airline'
"Plugin 'tpope/vim-fugitive'
"Plugin 'airblade/vim-gitgutter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'isRuslan/vim-es6'
"Plugin 'rhysd/vim-crystal'
"Plugin 'rust-lang/rust.vim'
Plugin 'rking/ag.vim'
Plugin 'cespare/vim-toml'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'chemzqm/vim-run'
Plugin 'reedes/vim-lexical'
Plugin 'vimwiki/vimwiki'

call vundle#end()
filetype plugin indent on
syntax on

set backspace=indent,eol,start
set clipboard=unnamed
set colorcolumn=81
set expandtab
"set formatoptions+=a
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
set virtualedit=all
set wildmode=list:longest,list:full

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

augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType wiki call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

let wiki_1 = {}
let wiki_1.path = '~/Dropbox/Wiki'

let wiki_2 = {}
let wiki_2.path = '~/Code/project-200/wiki'
let wiki_2.path_html = '~/Code/project-200/docs'

let g:vimwiki_list = [wiki_1, wiki_2]
