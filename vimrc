set nocompatible              " be iMproved, required

" Simple tabs settings
set softtabstop=4 shiftwidth=4 expandtab 


" Vundle Section {
" Install Vundle if necessary
if !isdirectory($HOME."/.vim/bundle")
    silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim  > /dev/null 2>&1
endif

filetype off   " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My Plugins
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ
" }
" Put your non-Plugin stuff after this line


"""""""""""""""""""""""
" MAIN CONFIG
" """"""""""""""""""""

" Change leader key to ,
let mapleader=","

set cursorline
" Hide line numbers easier to copy paste
set nonumber
set nowrap
set hidden

" Backup and swap settings
if !isdirectory($HOME."/.vim/swapfiles")
    silent !mkdir $HOME/.vim/swapfiles  > /dev/null 2>&1
endif
set swapfile
set directory=$HOME/.vim/swapfiles//
set nobackup
set noundofile


" Search config
set showmatch
set hlsearch incsearch
set ignorecase smartcase

set background=dark
" Setup Solarized
if has('gui_running')
    " running gui not really planned right now !
else
    " in terminal mode assuming that solarized theme is selected
    set t_Co=16
    let g:solarized_termcolors=16
endif
silent! colorscheme solarized
syntax on

""""""""""""""""
" PLUGIN CONFIG
" """""""""""""""

" NERDTREE
map <F3> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" CTRL P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPBuffer'

" Airline
set laststatus=2  " to show airline on startup
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
