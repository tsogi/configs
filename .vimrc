" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Custom configuration from Nika
  set mouse=v 
  set number
  set relativenumber
  syntax enable

  call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'pangloss/vim-javascript'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'morhetz/gruvbox'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-commentary'
  Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
  call plug#end()
    
  " coc.nvim configuration
  set cmdheight=2
  set updatetime=300
  set signcolumn=yes
  nmap <leader>gd <Plug>(coc-definition)
  nmap <leader>gr <plug>(coc-references)
  nmap <CR> o<Esc>k
  inoremap { {}<Esc>ha
  inoremap ( ()<Esc>ha
  inoremap [ []<Esc>ha
  inoremap " ""<Esc>ha
  inoremap ' ''<Esc>ha
  inoremap ` ``<Esc>ha
  
  nmap { {}

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
  
  nmap <C-c> "+y
  nmap <C-v> "+p

  autocmd vimenter * colorscheme gruvbox
  set background=dark
  nmap ,n :NERDTreeFind<CR>
  nmap ,m :NERDTreeToggle<CR>
  set runtimepath^=~/.vim/bundle/ctrlp.vim
  let NERDTreeShowHidden=1
  let NERDTreeMapOpenInTab='<ENTER>'
  set cursorline
  let g:ctrlp_max_files=0
  let g:ctrlp_max_depth=40
  let g:ctrlp_working_path_mode = 0
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }
  set backupdir=/tmp//
  set directory=/tmp//
  set undodir=/tmp//

  let g:javascript_plugin_jsdoc = 1
  let g:javascript_plugin_ngdoc = 1

  filetype plugin indent on
  set tabstop=4
  set shiftwidth=4
  set expandtab

  let g:ctrlp_custom_ignore = 'node_modules\|vendor\|git'
  set ic
" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
