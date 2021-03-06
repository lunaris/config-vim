set nocompatible    " Turn off compatibility.

" GUI Options
" ===========

set guioptions-=T   " No toolbar in Gvim.
set guioptions-=m   " No menubar in Gvim.
set winminheight=0  " No minimum window height.

" Miscellaneous setup
" ===================

set shell=zsh       " We're using zsh.
set mat=2           " Blink for 2/10 of a second.

" NeoBundle setup
" ===============
set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim',
  \ {
  \ 'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \    },
  \ }

NeoBundle 'bitc/vim-hdevtools'
NeoBundle 'godlygeek/tabular'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'lunaris/vim-him'
NeoBundle 'noah/vim256-color'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'

call neobundle#end()

" Colour schemes / look and feel
" ==============================

set t_Co=256        " Use 256 colours -- we should be OK in most cases.
colorscheme xoria256

" Vimrc editing
" ==============

map <leader>e :e! ~/.vimrc<CR>
                    " Quick loading of .vimrc.

map <leader>s :so ~/.vimrc<CR>
                    " Quick saving of .vimrc.

autocmd! BufWritePost .vimrc source ~/.vimrc
                    " Automatically source .vimrc when it changes.

" Editing settings
" ================

set hidden          " Hide buffers rather than closing them.
set ruler           " Show the ruler.
set wildmenu        " Wildcard menu.
set cmdheight=1     " Command bar height is 1 line.
set number          " Line numbering.
set autoindent      " Always set automatic indenting on.
set tabstop=2       " Set the tabstop to be 2 characters.
set expandtab       " Always expand tabs to spaces.
set shiftwidth=2    " Set the tabstop to be 2 characters (autoindenting).
set shiftround      " Use multiple of shiftwidth when using '<' and '>'.

set backspace=eol,start,indent
                    " Allow backspacing over everything in insert mode.

syntax on           " Turn on syntax highlighting.

" Searching and substitution
" ==========================

set showmatch       " Show matching brackets.
set ignorecase      " Ignore case when searching.
set smartcase       " Search case-insensitive if the term is all lowercase,
                    " case-sensitive otherwise.
set incsearch       " Show search matches as you type.

nnoremap <leader>nh :noh<CR>
                    " Easy clearing of searches.

" History and backups
" ===================

set history=400     " How many commands and searches to remember.
set undolevels=1000 " We want plenty of undo levels.
set nobackup        " We don't want to make backup files.
set noswapfile      " We don't want to make swap files.

" Terminal miscellany
" ===================

set title           " Change the terminal's title.
set shortmess+=I    " No welcome message.
set novisualbell    " Don't beep.
set noerrorbells    " Seriously, don't beep.
set t_vb=           " Please don't flash either.
set mouse=a         " We want the mouse please.

" Filetype stuff
" ==============

filetype on         " Peek into files to find their types.
filetype plugin on
filetype indent on

" Text wrapping and formatting
" ============================

set wrap            " Turn on text wrapping.
set textwidth=79    " Hard wrap at 80 characters.
set colorcolumn=80  " Display the 80-character margin.

func! DeleteTrailingWS()
  norm mz
  %s/\s\+$//ge
  norm `z
endfunc

map <leader>dw :call DeleteTrailingWS()<cr>
                    " Lets us delete trailing whitespace.

autocmd BufWrite * :call DeleteTrailingWS()
                    " Automatically delete trailing whitespace on saving.

autocmd BufEnter,BufNewFile,BufRead *.tsx? setlocal ft=typescript
                    " Make sure XML plugins don't ruin TypeScript support.

" Unite
" =====

nnoremap <Leader>ff :Unite -buffer-name=files -start-insert
  \ file_rec/git:--cached:--others:--exclude-standard<CR>

autocmd FileType unite call s:initialise_unite_buffer()
function! s:initialise_unite_buffer()
  " Enable <C-j> and <C-k> for navigating Unite buffers when in insert mode.
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction

" Syntastic
" =========

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_haskell_checkers=['hdevtools']
