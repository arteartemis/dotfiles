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
nnoremap <leader>t <C-]>
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
