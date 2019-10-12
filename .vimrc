set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim' 
Plugin 'flazz/vim-colorschemes'
Plugin 'mileszs/ack.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'posva/vim-vue'
Plugin 'prettier/vim-prettier'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'w0rp/ale'

call vundle#end()            " required
filetype plugin indent on    " required

" Install Vim Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}

call plug#end()

" ======= General Settings ========
syntax on
let mapleader=","
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
set clipboard=unnamed,unnamedplus

" ======= Vim Javascript ========
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" ======= ctrlp ========
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" ======= The silver search =======
let g:ackprg = 'ag --nogroup --nocolor --column'

" ======= NERDTree =======
let NERDTreeShowHidden=1
map <silent> <C-n> :NERDTreeFocus<CR>

" ======= Prettier =======
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" ======= Colorscheme =======
colorscheme gruvbox

" ======= Vim Vue =======
autocmd FileType vue syntax sync fromstart
map <C-k> :Commentary<CR>

" ======= Shortcuts =======
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
