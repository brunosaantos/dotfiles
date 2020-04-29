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
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'flazz/vim-colorschemes'
Plugin 'leafgarland/typescript-vim'
Plugin 'mileszs/ack.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'posva/vim-vue'
Plugin 'prettier/vim-prettier'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
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
Plug 'joshdick/onedark.vim'
Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }

call plug#end()

" ======= General Settings ========
let mapleader=","
set number
set relativenumber
set expandtab
set splitbelow
set splitright

" Use system clipboard
set clipboard=unnamed,unnamedplus

" Do not create .swp files
set noswapfile

" Show auto complete menus.
set wildmenu
set wildmode=list:longest

" Turn on syntax hightlighting.
set syntax=on
set nowrap
set tabstop=2
set shiftwidth=2
set nocindent

" Speed Optimization
set ttyfast
set lazyredraw

" ======= Theme ========
set background=dark
set termguicolors
let g:onedark_termcolors=256
colorscheme onedark 

" ======= Vim Javascript ========
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" Lightline
let g:lightline = { 'colorscheme': 'onedark' }

" ======= ctrlp ========
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_show_hidden = 1

" ======= The silver search =======
let g:ackprg = 'ag --nogroup --nocolor --column'

" ======= NERDTree =======
let NERDTreeShowHidden=1
map <silent> <C-n> :NERDTreeFocus<CR>

" ======= COC =======
let g:coc_global_extensions = [
\ 'coc-vetur',
\ 'coc-json',
\ 'coc-tsserver',
\ 'coc-emmet',
\ 'coc-snippets',
\ 'coc-prettier',
\ 'coc-eslint',
\ ]

" ======= Prettier =======
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" ======= Vim Vue =======
autocmd FileType vue syntax sync fromstart
map <C-k> :Commentary<CR>
let g:vue_pre_processors = 'detect_on_enter'

" ======= NERD Commenter =======
let g:used_javascript_libs = 'underscore,react,vue'
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

" ======= Import Cost =======
augroup import_cost_auto_run
  autocmd!
  autocmd InsertLeave *.js,*.jsx,*.ts,*.tsx ImportCost
  autocmd BufEnter *.js,*.jsx,*.ts,*.tsx ImportCost
  autocmd CursorHold *.js,*.jsx,*.ts,*.tsx ImportCost
augroup END

" ======= Shortcuts =======
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Remap move between windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
