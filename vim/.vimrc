" vim:foldmethod=marker:foldlevel=0
filetype plugin on
filetype indent on
syntax on
set modelines=1
set laststatus=2 " Always show the status line
" Close documentation popup when leaving insert
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set backspace=indent,eol,start  " more powerful backspacing

""" PLUGINS {{{
call plug#begin()
"" General {{{
" ALE for async linting and completion
Plug 'w0rp/ale'

" Cool directory tree panel
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']  }
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeQuitOnOpen=1
" Multiple cursors
Plug 'mg979/vim-visual-multi'
" Visualization
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/vim-solarized8'
" Fuzzy search files in the current directory tree/open files
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

" Visualize undo tree
Plug 'simnalamburt/vim-mundo'
nnoremap <Leader>u :MundoToggle<CR>

Plug 'moll/vim-bbye' " bdelete without close window
Plug 'tpope/vim-unimpaired' " A lot of [X and ]X keymaps
Plug 'tpope/vim-surround' " Delete, change and add surrounding characters around things
Plug 'tpope/vim-repeat' " Allow repeating whole plugin maps with .
Plug 'Raimondi/delimitMate' " Auto-insert matching quotes/braces/backets
" Actions on word styles - case preserving substiture, coerction between name
" styles, etc
Plug 'tpope/vim-abolish'
"" }}}
"" Tool intergations {{{
" Tmux
Plug 'tpope/vim-tbone'
Plug 'christoomey/vim-tmux-navigator' " Make navigation between tmux and vim panes use the same key
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter' " Mark which lines were changed and git-add them
"" }}}
"" Lanauges {{{
" in-vim REPL, including sending text from buffers
Plug 'sillybun/vim-repl'

" Python
Plug 'davidhalter/jedi-vim', { 'for': ['python'] }

Plug 'elmcast/elm-vim', { 'for': ['elm'] }
Plug 'fatih/vim-go', { 'for': ['go'] }
" Latex
Plug 'lervag/vimtex'
" }}}
"" Custom text objects {{{
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent' " ai/aI ii/iI select indented block
Plug 'beloglazov/vim-textobj-quotes' " aq/iq select area between quotes
Plug 'jceb/vim-textobj-uri' " au/iu/go select URLs
Plug 'Julian/vim-textobj-variable-segment' " av/iv area between _ or CamelCase
Plug 'sgur/vim-textobj-parameter' " a,/i, select function parameters
Plug 'thinca/vim-textobj-between' " af/if area between a given character
" }}}
"" }}}
call plug#end()
""" }}}
""" PLUGIN CONFIGS {{{
" airline {{{
" Add buffer number (%n) before filename in status line
let g:airline_section_c="%<%n %f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#"
" }}}
" NERDTree {{{
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeQuitOnOpen=1
" }}}
" ALE {{{
let g:ale_completion_enabled = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
" }}}
" FZF {{{
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
" }}}
" tmux_navigator {{{
let g:tmux_navigator_no_mappings = 1 " I want to map my own nav keys
" }}}
" delimitMate {{{
" When pressing <CR> after starting a bracket, put the end bracket in it's own
" line
let g:delimitMate_expand_cr=2
" When entering spaces afterh delimiters, enter them in the otehr end
let g:delimitMate_expand_space=1
" "}}}
" }}}

" Saner tabs {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab " Use spaces and not tabs
" }}}
" Visuals and terminal {{{
colorscheme solarized8
set bg=dark " Terminal is dark
set termguicolors " rgb colors
set shell=/bin/bash
" }}}
" Search {{{
" lower case==ignore case when searching
set ignorecase
set smartcase
" }}}

" Language specific settings {{{
" Python
autocmd Filetype python let g:repl_program.python = 'ipython'|let g:repl_ipython_version = '8'
" Javascript
autocmd FileType javascript,typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript,typescript map gd :TernDef<CR>
" Ansible
autocmd FileType ansible map K :!ansible-doc <cword><CR>
" Yaml
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
" LaTEX
" Using BufReadPre since we need to set this option before VimTex is loaded
" and FileType event is too late
autocmd BufReadPre *.tex let g:vimtex_view_method = 'zathura'

" }}}

""" KEY MAPS {{{
" Close current file but keep the window open
nmap <Leader>c :Bdelete<CR>
" Go to previous buffer
nmap <Leader>\ :buffer #<CR>
" Jump to definition of object under cursor
nmap gd :ALEGoToDefinition<CR>
" Toggle NERDTree
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>N :NERDTreeFind<CR>

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

" }}}
