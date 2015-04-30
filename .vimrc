""" VUNDLE STUFF
""" Vundle is a plugin to manage installtion of vim plugins

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

""" PLUGINS
" Fuzzy search files in the current directory tree/open files
Bundle 'kien/ctrlp.vim'
" Auto-complete engine
Bundle 'Valloric/YouCompleteMe'
" Syntax check
Bundle 'scrooloose/syntastic'
" bdelete without close window
Bundle 'moll/vim-bbye'

" A lot of [X and ]X keymaps for previous/next stuff
Bundle 'tpope/vim-unimpaired'
" Delete, change and add surrounding characters around things
Bundle 'tpope/vim-surround'

" Make navigation between tmux and vim panes use the same key
Bundle 'christoomey/vim-tmux-navigator'
" Git plugin
Bundle 'tpope/vim-fugitive'
" Auto-insert matching quotes/braces/backets when opening them
Bundle 'Raimondi/delimitMate'
" Cool directory tree panel
Bundle 'scrooloose/nerdtree'
" Cool status line for vim
Bundle 'bling/vim-airline'
" Snippets of boilerplate code
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
" Match tmux colors to vim colors
Bundle 'edkolev/tmuxline.vim'
" Don't remember what that is
Bundle 'Valloric/ListToggle'

" Py.test integtration
Bundle 'alfredodeza/pytest.vim'

" Ansible syntax support
Bundle 'chase/vim-ansible-yaml'

" Javascript completion
Bundle 'marijnh/tern_for_vim'
Bundle 'moll/vim-node'

" Show functions and other tabs in sidebar
Bundle 'Tagbar'

" Multiple cursors
Bundle 'terryma/vim-multiple-cursors'

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

" af/if area between a given character
Bundle 'thinca/vim-textobj-between'

""" OTHER CONFIGS
filetype plugin on
filetype indent on
syntax on

" Saner tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Use spaces and not tabs
set expandtab
" Terminal is dark
set bg=dark
" lower case==ignore case when searching
set ignorecase
set smartcase

set shell=/bin/bash

" Close documentation popup when leaving insert
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Set tabwidth to 2 for javascript
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal omnifunc=tern#Complete

""" PLUGIN CONFIGS
" tmuxline configs
let g:tmuxline_powerline_separators = 0
set laststatus=2

" Nice 256 color scheme
set t_Co=256
Bundle 'altercation/vim-colors-solarized'
" Config solarized to use 256 colors
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

" netrw config
"let g:netrw_banner       = 0
"let g:netrw_browse_split = 4
"let g:netrw_keepdir      = 0
"let g:netrw_liststyle    = 1 " or 3
"let g:netrw_sort_options = 'i'
"let g:netrw_winsize      = -30

" NERDTree configs
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeQuitOnOpen=1

" CTRLp configs
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*__pycache__*
let g:ctrlp_show_hidden = 1
let g:ctrlp_cmd = 'CtrlPMixed'

" tmux_navigator configs, I want to map my own nav keys
let g:tmux_navigator_no_mappings = 1

""" KEY MAPS
" Close current file but keep the window open
nmap <Leader>c :Bdelete<CR>
" Go to previous buffer
nmap <Leader>\ :buffer #<CR>
" Jump to definition of object under cursor
nmap gd :YcmCompleter GoToDefinition
" Toggle NERDTree
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>N :NERDTreeFind<CR>
"nmap <Leader>p :Vexplore **/

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %


" Same as tmux, alt-hjkl moves between panes
nnoremap <silent> h :TmuxNavigateLeft<cr>
nnoremap <silent> j :TmuxNavigateDown<cr>
nnoremap <silent> k :TmuxNavigateUp<cr>
nnoremap <silent> l :TmuxNavigateRight<cr>
nnoremap <silent> \ :TmuxNavigatePrevious<cr>

" Snippets trigger
let g:UltiSnipsExpandTrigger = "<c-L>"
