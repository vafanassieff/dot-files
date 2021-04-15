set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'L9'
Plugin 'altercation/vim-colors-solarized'
Plugin 'nathanaelkane/vim-indent-guides'

call vundle#end()

filetype plugin indent on

syntax enable
colorscheme monokai
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
