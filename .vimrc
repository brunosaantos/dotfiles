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
Plugin 'leafgarland/typescript-vim'
Plugin 'mileszs/ack.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'posva/vim-vue'

call vundle#end()            " required
filetype plugin indent on    " required

" Install Vim Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'
Plug 'honza/vim-snippets'
Plug 'joshdick/onedark.vim'
Plug 'jparise/vim-graphql'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }

call plug#end()

" ======= General Settings ========
let mapleader=","
set number
set relativenumber
set expandtab
set splitbelow
set splitright
set cursorline

" Use system clipboard
set clipboard=unnamed,unnamedplus

" Do not create .swp files
set noswapfile

" Show auto complete menus.
set wildmenu
set wildmode=list:longest

" Turn on syntax highlighting.
set syntax=on
set nowrap
set tabstop=2
set shiftwidth=2
set nocindent

" Speed Optimization
set ttyfast
set lazyredraw

" This unsets the \"last search pattern\" register by hitting return
nnoremap <CR> :noh<CR><CR>

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
let g:NERDTreeWinPos = "right"
map <silent> <C-n> :NERDTreeFocus<CR>

" ======= COC =======
let g:coc_global_extensions = [
\ 'coc-emmet',
\ 'coc-eslint8',
\ 'coc-json',
\ 'coc-marketplace',
\ 'coc-prettier',
\ 'coc-simple-react-snippets',
\ 'coc-snippets',
\ 'coc-stylelint',
\ 'coc-tsserver',
\ 'coc-vetur',
\ ]

" ======= Prettier =======
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" ======= Vim Vue =======
autocmd FileType vue syntax sync fromstart
map <C-k> :Commentary<CR>
let g:vue_pre_processors = 'detect_on_enter'

" ======= Javascript Libraries Syntax =======
let g:used_javascript_libs = 'underscore,react,vue'

" ======= NERD Commenter =======
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

" ======= Vim Airline =======
let g:airline#extensions#tabline#enabled = 1

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

" Remap shift highlighed lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Show documentation
nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>

