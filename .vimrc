call plug#begin()

" let Vundle manage Vundle, required
Plug 'gmarik/vundle'

""" PLUGINS
" Fuzzy search files in the current directory tree/open files
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
" Auto-complete engine
Plug 'maralla/completor.vim'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" Syntax check
"Plug 'scrooloose/syntastic'
" ALE for async linting
Plug 'w0rp/ale'
" bdelete without close window
Plug 'moll/vim-bbye'

" A lot of [X and ]X keymaps for previous/next stuff
Plug 'tpope/vim-unimpaired'
" Delete, change and add surrounding characters around things
Plug 'tpope/vim-surround'
" Allow repeating whole plugin maps with .
Plug 'tpope/vim-repeat'
" Actions on word styles - case preserving substiture, coerction between name
" styles, etc
Plug 'tpope/vim-abolish'
" Tmux integration
Plug 'tpope/vim-tbone'
" Create screenshots of code commands: :Silicon :SiliconHighlight
Plug 'segeljakt/vim-silicon'

" elm
Plug 'elmcast/elm-vim', { 'for': ['elm'] }

" Golang
Plug 'fatih/vim-go', { 'for': ['go'] }

" C/C++
Plug 'vim-scripts/Conque-GDB', { 'for': ['c', 'cpp'] }

" Typescript
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }

" Python (requires pip install jedi)
Plug 'davidhalter/jedi-vim', { 'for': ['python'] }
let g:completor_python_binary='/usr/bin/python'

" Make navigation between tmux and vim panes use the same key
Plug 'christoomey/vim-tmux-navigator'
" Git plugin
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Dispatch for tests
Plug 'tpope/vim-dispatch'
" Auto-insert matching quotes/braces/backets when opening them
Plug 'Raimondi/delimitMate'
" Cool directory tree panel
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']  }
" Cool status line for vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Snippets of boilerplate code
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
" Match tmux colors to vim colors
Plug 'edkolev/tmuxline.vim'
" Don't remember what that is
"Plug 'Valloric/ListToggle'

" Py.test integtration
Plug 'alfredodeza/pytest.vim'

" Ansible syntax support
Plug 'chase/vim-ansible-yaml'

" Javascript completion
Plug 'marijnh/tern_for_vim'
Plug 'moll/vim-node'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Custom text objects
Plug 'kana/vim-textobj-user'

" ai/aI ii/iI select indented block
Plug 'kana/vim-textobj-indent' 

" aq/iq select area between quotes
Plug 'beloglazov/vim-textobj-quotes'

" au/iu/go select URLs
Plug 'jceb/vim-textobj-uri'

" av/iv area between _ or CamelCase
Plug 'Julian/vim-textobj-variable-segment'

" a,/i, select function parameters
Plug 'sgur/vim-textobj-parameter'

" af/if area between a given character
Plug 'thinca/vim-textobj-between'

Plug 'lifepillar/vim-solarized8'
call plug#end()

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

autocmd BufNewFile,BufRead *.s11 set filetype=asmpdp11

" Close documentation popup when leaving insert
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Set tabwidth to 2 for javascript and typescript
autocmd FileType javascript,typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
" autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType javascript map gd :TernDef<CR>

autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml map K :!ansible-doc <cword><CR>
autocmd FileType ansible map K :!ansible-doc <cword><CR>

""" PLUGIN CONFIGS
" tmuxline configs
let g:tmuxline_powerline_separators = 0
set laststatus=2

" Nice rgb colors
set termguicolors
"set t_Co=256
" Config solarized to use rgb colors
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
colorscheme solarized8

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

" FZF configs
" https://github.com/junegunn/fzf/wiki/Examples-(vim)#filtered-voldfiles-and-open-buffers
command! FZFMru call fzf#run({
\ 'source':  reverse(s:all_files()),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })

function! s:all_files()
  return extend(
  \ filter(copy(v:oldfiles),
  \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
  \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction

" tmux_navigator configs, I want to map my own nav keys
let g:tmux_navigator_no_mappings = 1

" When pressing <CR> after starting a bracket, put the end bracket in it's own
" line
let g:delimitMate_expand_cr=2
" When entering spaces afterh delimiters, enter them in the otehr end
let g:delimitMate_expand_space=1

" Toggle gitgutter
nmap <Leader>d :GitGutterToggle<CR>

""" KEY MAPS
" Close current file but keep the window open
nmap <Leader>c :Bdelete<CR>
" Go to previous buffer
nmap <Leader>\ :buffer #<CR>
" Jump to definition of object under cursor
nmap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Toggle NERDTree
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>N :NERDTreeFind<CR>
"nmap <Leader>p :Vexplore **/

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" copy and paste to and from tmux buffer
vmap ty :'<,'>Tyank<CR>
nmap ty :Tyank<CR>
nmap tp :Tput<CR>

" Same as tmux, alt-hjkl moves between panes
nnoremap <silent> h :TmuxNavigateLeft<cr>
nnoremap <silent> j :TmuxNavigateDown<cr>
nnoremap <silent> k :TmuxNavigateUp<cr>
nnoremap <silent> l :TmuxNavigateRight<cr>
nnoremap <silent> \ :TmuxNavigatePrevious<cr>

nmap <Leader>p :FZFMru<CR>

" Snippets trigger
let g:UltiSnipsExpandTrigger = "<c-L>"
" Add buffer number (%n) before filename in status line
let g:airline_section_c="%<%n %f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#"
