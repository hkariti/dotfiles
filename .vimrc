filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'SirVer/ultisnips'
Bundle 'scrooloose/syntastic'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Valloric/ListToggle'
Bundle 'Raimondi/delimitMate'
Bundle 'chase/vim-ansible-yaml'
Bundle 'edkolev/tmuxline.vim'
Bundle 'bling/vim-airline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'jewes/Conque-Shell'
Bundle 'alfredodeza/pytest.vim'
Bundle 'Tagbar'

" Custom text objects
Bundle 'kana/vim-textobj-user'

" ai/aI ii/iI select indented block
Bundle 'kana/vim-textobj-indent' 

" aq/iq select area between quotes
Bundle 'beloglazov/vim-textobj-quotes'

" au/iu/go select URLs
Bundle 'jceb/vim-textobj-uri'

" ai/iv area between _ or CamelCase
Bundle 'Julian/vim-textobj-variable-segment'

" a,/i, select function parameters
Bundle 'sgur/vim-textobj-parameter'

" Tpope magics
Bundle 'tpope/vim-unimpaired'

filetype plugin on
filetype indent on

set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set bg=dark

set t_Co=256
let g:tmuxline_powerline_separators = 0
set laststatus=2


let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

let NERDTreeIgnore = ['\.pyc$']
let NERDTreeQuitOnOpen=1

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
let g:ctrlp_show_hidden = 1

set shell=/bin/bash

nmap <Leader>c :bp \| bd #<CR>
nmap <Leader>N :NERDTreeToggle<CR>
nmap <Leader>\ :buffer #<CR>

autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> h :TmuxNavigateLeft<cr>
nnoremap <silent> j :TmuxNavigateDown<cr>
nnoremap <silent> k :TmuxNavigateUp<cr>
nnoremap <silent> l :TmuxNavigateRight<cr>
nnoremap <silent> \ :TmuxNavigatePrevious<cr>

