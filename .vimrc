set nocompatible              " be iMproved, required
filetype off                  " required

filetype plugin indent on    " required

" Install Vim Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim' 
"Plug 'dense-analysis/ale'
Plug 'flazz/vim-colorschemes'
"Plug 'honza/vim-snippets'
"Plug 'joshdick/onedark.vim'
"Plug 'jparise/vim-graphql'
Plug 'leafgarland/typescript-vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
"Plug 'posva/vim-vue'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
"Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-surround'
"Plug 'vim-airline/vim-airline'
"Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }

call plug#end()

" ======= General Settings ========
let mapleader=","
set number
set relativenumber
set expandtab
set splitbelow
set splitright
set cursorline
set colorcolumn=80

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

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" This unsets the \"last search pattern\" register by hitting return
nnoremap <CR> :noh<CR><CR>

" ======= Theme ========
"set background=dark
"set termguicolors
"let g:onedark_termcolors=256
colorscheme cobalt2 

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
"augroup import_cost_auto_run
  "autocmd!
  "autocmd InsertLeave *.js,*.jsx,*.ts,*.tsx ImportCost
  "autocmd BufEnter *.js,*.jsx,*.ts,*.tsx ImportCost
  "autocmd CursorHold *.js,*.jsx,*.ts,*.tsx ImportCost
"augroup END

" ======= Vim Airline =======
let g:airline#extensions#tabline#enabled = 1

" ======= Shortcuts =======
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

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

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Show documentation
nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>

