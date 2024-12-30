set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'L9'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'NLKNguyen/papercolor-theme'

call vundle#end()

filetype plugin indent on

syntax enable
set number

set cursorline
set colorcolumn=81

set autoindent
set smartindent

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab  
set pastetoggle=<F2>

let theme = system('defaults read -g AppleInterfaceStyle')
if theme =~ 'Dark'
    set background=dark
    colorscheme PaperColor
else
    set background=light
    colorscheme PaperColor
endif
