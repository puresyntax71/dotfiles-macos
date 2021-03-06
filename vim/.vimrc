" Plugins {{{

call plug#begin('~/.vim/plugged')

Plug 'SirVer/ultisnips'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
" Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'leafgarland/typescript-vim'
Plug 'lepture/vim-jinja', { 'on': [] }
Plug 'machakann/vim-sandwich'
Plug 'matchit.zip', {'name': 'matchit'}
Plug 'mattn/emmet-vim', { 'for': ['html', 'jinja'] }
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'plasticboy/vim-markdown'
Plug 'posva/vim-vue'
Plug 'shawncplus/phpcomplete.vim'
Plug 'StanAngeloff/php.vim'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'cespare/vim-toml'
Plug 'cakebaker/scss-syntax.vim'
Plug 'fatih/vim-go'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'croaker/mustang-vim'
Plug 'joshdick/onedark.vim'
Plug 'romainl/apprentice'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'vim-scripts/BusyBee'
Plug 'twerth/ir_black'
Plug 'nanotech/jellybeans.vim'
Plug 'erichdongubler/vim-sublime-monokai'
Plug 'trusktr/seti.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'ajh17/Spacegray.vim'

call plug#end()

" }}}

" Settings {{{

filetype plugin indent on
syntax on

set rtp+=~/.fzf/bin/fzf
set autoindent
set background=dark
set backspace=indent,eol,start
" set clipboard^=unnamed,unnamedplus
set complete-=b
set complete-=u
set complete-=w
set completeopt+=menu,menuone
set completeopt-=preview
set directory=$HOME/.vim/tmp/swap
set display+=lastline
set expandtab
set foldcolumn=0
set foldenable
set foldlevel=99
set foldmethod=syntax
set history=1000
set ignorecase
set incsearch
set infercase
set laststatus=2
set list
set listchars=trail:·,precedes:«,extends:»,tab:▸\ 
set mouse=a
set mousehide
set number
set path=.,**
set scrolloff=5
set shiftwidth=4
set showcmd
set smartcase
set softtabstop=4
set switchbuf=useopen
set tabstop=4
set textwidth=80
set timeoutlen=700
set ttimeout
set ttimeoutlen=100
set undodir=$HOME/.vim/tmp/undo
set undofile
set visualbell t_vb=
set wildignore+=*.png,*.jpg,*.jpeg,*.gif,*.swp,*.swo
set wildignore+=*.swp,*.swo
set wildignore+=.git
set wildmode=list:longest,full
set wrap
set termguicolors

let ayucolor="dark"
colorscheme ayu

" }}}

" Bindings {{{

let mapleader=","
let maplocalleader=","

inoremap ,fn <C-R>=expand("%:t:r:r")<CR>
inoremap jk <Esc>
" inoremap <Tab> <Plug>(minisnip)<Esc>

nnoremap ' `
nnoremap ,A :Ag 
nnoremap ,B :BTags<CR>
nnoremap ,F :Files<CR>
nnoremap ,G :GFiles<CR>
nnoremap ,T :Tags<CR>
nnoremap ,BT :BTags<CR>
nnoremap ,ee :drop <C-R>=expand('%:p:h') . '/'<CR>
nnoremap ,eg :drop $MYGVIMRC<CR>
nnoremap ,ev :drop $MYVIMRC<CR>
nnoremap ,fn "=expand("%:t:r:r")<CR>p
nnoremap ,sp :sp <C-R>=expand('%:p:h') . '/'<CR>
nnoremap gV `[V`]
nnoremap j gj
nnoremap k gk
nnoremap q: <Nop>

noremap Y y$

noremap <Leader>g. :TTags<cr>
noremap <Leader>g% :call ttags#List(0, "*", "", ".")<cr>
noremap <Leader>g# :call ttags#List(0, "*", tlib#rx#Escape(expand("<cword>")))<cr>
noremap <Leader>g* :call ttags#List(0, "*", tlib#rx#Escape(expand("<cword>")) .".*")<cr>
noremap <Leader>g? :call ttags#List(1, "*", tlib#rx#Escape(expand("<cword>")))<cr>
for c in split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', '\zs')
    exec 'noremap <Leader>g'. c .' :TTags '. c .'<cr>'
endfor

" }}}

" Plugins {{{

let g:ale_linters = {'php': ['php', 'phpcs']}

let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'readonly': 'LightLineReadonly',
    \   'modified': 'LightLineModified',
    \   'filename': 'LightLineFilename'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ''
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ''._ : ''
  endif
  return ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

let $FZF_DEFAULT_COMMAND = 'fd --type f -I'

let g:php_var_selector_is_identifier = 1

let g:vue_pre_processors = 'detect_on_enter'

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

" let g:phpactorActivateOverlapingMappings = v:true

" }}}

" vim: foldmethod=marker
