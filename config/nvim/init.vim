let mapleader = " "
let maplocalleader = ' '

call plug#begin('~/.vim/plugged')

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Colors
Plug 'chriskempson/base16-vim'

" More text objects
Plug 'wellle/targets.vim'

" Bit more convenience IDE support
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-commentary'

" For Github link sharing
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" For Haskell
Plug 'parsonsmatt/intero-neovim'
Plug 'neovimhaskell/haskell-vim'

" For Sorbet Language Server
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()


colorscheme base16-default-dark

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =2         " Tab key indents by 2 spaces.
set shiftwidth  =2        " >> indents by 2 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set inccommand=nosplit
set incsearch nohlsearch

set wildmenu
set wildmode=full
set noswapfile
set autoread
set autowrite
autocmd! FocusGained,BufEnter * checktime
 
nnoremap <leader>f  :Files<cr>
nnoremap <leader>ve :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>b :Buffer<cr>
nnoremap <leader>ag :Ag! 
nnoremap 0 ^
inoremap <C-\> <Esc>
noremap <C-\> <Esc>
nnoremap * :keepjumps normal! *N<CR>
nnoremap <leader>o o<Esc>k
nnoremap <leader>O O<Esc>j
noremap <leader>k "_d
noremap <Leader>y "*y

nnoremap <leader>p yiw:Ag! (?:class\s\|(?:def\s(?:self.)?))<C-r>"<CR>
nnoremap Y  y$
nmap <leader>== gg=G``

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" faster commenting
nmap <Leader>c gcc
vmap <Leader>c gc

set splitbelow
set splitright

set gdefault
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

set so=999

set ignorecase

let g:github_enterprise_urls = ['https://git.corp.stripe.com']

nnoremap <Leader>gh :Gbrowse<CR>
xnoremap <Leader>gh :Gbrowse<CR>
nnoremap <Leader>gc :Gbrowse!<CR>
xnoremap <Leader>gc :Gbrowse!<CR><Paste>

au FileType ruby setlocal iskeyword+=!

" Often mistyped commands
command! Q  q
command! W  w
command! Wq wq
command! WQ wq
map Q :q<CR>

"Strip trailing whitespace
autocmd FileType c,cpp,java,php,javascript,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

function! FlipBindingPry()
  if getline('.') =~? '^\s*binding\.pry\s*$'
    normal dd
  else
    normal obinding.pry
  endif
  write
endfunction

nnoremap <leader>d :call FlipBindingPry()<CR>
nnoremap <leader>r :bufdo :g/^\s*binding.pry$/d \| update<CR>


augroup interoMaps
  au!
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

  " Background process and window management
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>

  " Reloading (pick one)
  " Automatically reload on save
  au BufWritePost *.hs InteroReload
  " Manually save and reload
  " au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  " Navigation
  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup END

" Intero starts automatically. Set this if you'd like to prevent that.
let g:intero_start_immediately = 0

" Enable type information on hover (when holding cursor at point for ~1 second).
let g:intero_type_on_hover = 1

" Change the intero window size; default is 10.
let g:intero_window_size = 15

" Sets the intero window to split vertically; default is horizontal
" let g:intero_vertical_split = 1

" OPTIONAL: Make the update time shorter, so the type info will trigger faster.
set updatetime=1000

if exists(':tnoremap')
  tnoremap <M-e> <C-\><C-n>
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
endif

let g:LanguageClient_serverCommands = {
    \ 'ruby': ['pay', 'exec', 'scripts/bin/typecheck', '--lsp'],
    \ }

nnoremap <silent> <leader>t :call LanguageClient#textDocument_definition()<CR>
