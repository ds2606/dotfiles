" VIMRC


" ENVIRONMENT

" environment settings
set nocompatible
let mapleader = ","
noremap \, ,
set history=500
set wildmenu
set showcmd              " show most recent command
set formatoptions-=cro   " don't autoinsert newline comments from comments (BROKEN)
set clipboard^=unnamed   " copy-paste across terminals
set foldlevel=99         " file unfolded by default
set matchtime=0
set encoding=utf8
set wrap
set tw=120               " inserted text automatically linebroken after 120 chars
set linebreak            " wrap lines at whitespace and punctuation, not mid-word
set breakindent          " wrap lines to same indent level
let &showbreak='  '      " little extra break for wrapped lines
set autoread             " auto-refresh unmodified buffers edited elsewhere
au  FocusGained,BufEnter * checktime  " check if buffer updated elsewhere
set magic                " enable special chars in regex ('*', '.', etc)
"set mouse=;             " allow mouse interface
"set scrolloff=3         " keep 3 lines of context while scrolling

" backups, swap files, and persistent undo
set backup
set backupdir=~/.vim/backups/  " backup files
set directory=~/.vim/tmp/      " for the swap files
set writebackup
set undofile
set undodir=~/.vim/undo

" search
set ignorecase
set smartcase
set hlsearch
set incsearch
set shortmess-=S  " show number of searches
noremap <cr> :noh<cr>

" aesthetics
colorscheme palenight
let      g:onedark_termcolors   = 256
let      g:palenight_termcolors = 256
syntax   enable            " syntax highlighting
set      showmatch         " show matching brachets
set      ruler
let      g:lightline = {
            \ 'colorscheme': 'palenight',
            \  }
set      laststatus=2         " show status bar by default
set      noshowmode           " hide --MODE-- (redundant with lightline)
"" should move most of these into the pn colorscheme
hi       Normal ctermbg=NONE
hi       LineNr ctermfg=60
hi       ExtraWhitespace ctermbg=18 guibg=#87005f
match    ExtraWhitespace /\s\+$/
autocmd  BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd  InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd  InsertLeave * match ExtraWhitespace /\s\+$/
autocmd  BufWinLeave * call clearmatches()
" set colorcolumn=80
" highlight OverLength ctermfg=204
" match OverLength /\%81v.\+/

" open new split panes to right and bottom (more natural)
set splitbelow
set splitright

" normal line numbering
noremap <leader># :set nu!<cr>
set nu


" KEYBINDINGS

" command mode remap
noremap ; :
noremap \; ;

" jk for insertion escape
inoremap jk <esc>l

" Y behaves like other capitals
noremap Y y$

" easier redo
noremap U <C-r>

" unmap arrow keys in normal/visual mode (use hjkl)
noremap  <left>  :echoe "use h"<cr>
noremap  <right> :echoe "use l"<cr>
noremap  <up>    :echoe "use k"<cr>
noremap  <down>  :echoe "use l"<cr>
inoremap <left>  <C-o>:echoe "use h"<cr>i
inoremap <right> <C-o>:echoe "use l"<cr>i
inoremap <up>    <C-o>:echoe "use k"<cr>i
inoremap <down>  <C-o>:echoe "use l"<cr>i

" bracket/paren matching
noremap <leader>p %

" move vertically by visual line (don't skip wrapped lines)
nmap j gj
nmap k gk

" easier scrolling (remap = to accomodate)
noremap -           :call smoothie#downwards()<cr>
noremap =           :call smoothie#upwards()<cr>
noremap _           <C-e>
noremap +           <C-y>
noremap <leader>=   =

" line/screen boundary navigation (remap defaults where necessary)
noremap H ^
noremap L $
noremap J L
noremap K H
noremap & J
noremap <C-k> K

" insert mode navigation (remap digraph insertion)
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-a> <esc>I
inoremap <C-e> <esc>A
inoremap <C-^> <C-o><C-^>
inoremap <C-d> <C-k>

" close buffer/tab/window
noremap <leader>c :close<cr>

" buffer management
set hidden  " hide a buffer instead of closing it
noremap ]b          :bnext<cr>
noremap [b          :bprev<cr>
noremap <leader>bc  :bd<cr>
noremap <leader>bl  :buffers<cr>

" tab management
noremap <leader>wt  :tabnew<cr>
noremap ]t          :tabn<cr>
noremap [t          :tabp<cr>
noremap <leader>wo  :tabedit <C-r>=expand("%:p:h")<cr>/
noremap <leader>wO  :tabedit

" window management
noremap <leader>wv  :vsp<cr>
noremap <leader>wh  :sp<cr>
noremap      <C-h>  <C-w>h
noremap      <C-j>  <C-w>j
noremap      <C-l>  <C-w>l
noremap      <C-k>  <C-w>k
noremap      <tab>  <c-w>w
noremap    <S-tab>  <c-w>W
noremap  <leader>-  :res -3 <cr>
noremap  <leader>=  :res +3 <cr>
noremap  <leader>9  :vertical resize -6 <cr>
noremap  <leader>0  :vertical resize +6 <cr>

" quickfix/location-list navigation
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" normal mode newline
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" insert mode write/quit
inoremap ;ww  <esc>:w<cr>li
inoremap ;wq  <esc>:wq
inoremap ;q   <esc>:q

" easier macro repitition
noremap Q @@

" delete trailing whitespace
noremap <silent> <leader>dw mt:let _s=@/ <bar>
      \ :%s/\s\+$//e<bar>:let @/=_s<cr>`t
      \ <bar> :echom "deleted trailing whitespace"<cr>

" file shortcuts for quick editing (last is for sourcing .vimrc)
noremap <leader>ev  :tabedit ~/desktop/home/.dotfiles/.vimrc<cr>
noremap <leader>ez  :tabedit ~/desktop/home/.dotfiles/.zsh_profile<cr>
noremap <leader>es  :source ~/.vimrc

" terminal access
noremap <leader>tn   :ter<cr>
      \<c-w>:exe          "resize" . (winheight(0) * 3/5) <cr>
noremap <leader>to   :sb zsh<cr>
      \<c-w>:exe          "resize " . (winheight(0) * 3/5) <cr>
tnoremap `n  <C-w>c:ter<cr>
      \<c-w>:exe          "resize " . (winheight(0) * 3/5) <cr>
tnoremap `c    <C-w>c
tnoremap `d    <C-d>
tnoremap <C-k>  <C-w>k
tnoremap `e    <C-w>N
tnoremap `-     <C-w>k <bar> :res +3 <cr> <bar> <c-w>j
tnoremap `=     <C-w>k <bar> :res -3 <cr> <bar> <c-w>j

" quick insertion of \(\) in search-replace
cmap ;\ \(\)<left><left>


" PLUG-INS

" vim-plug (to disable, append `{ 'on': [] }`
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'gillyb/stable-windows', { 'on': [] }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'maximbaz/lightline-ale'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
Plug 'psliwka/vim-smoothie'
Plug 'preservim/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'w0rp/ale'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

" undotree toggle
noremap <leader>u :UndotreeToggle<cr>

" easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" ALE
"" linting settings
let g:ale_lint_on_enter         = 0
let g:ale_lint_on_insert_leave  = 1
let g:ale_lint_on_save          = 1
let g:ale_lint_on_text_changed  = 1
let g:ale_linters               = {'python': ['flake8', 'pylint', 'pyls']}
let g:ale_python_flake8_options = "--ignore F403"  " allow 'import *'
let g:ale_python_pylint_options = "-d C0116 --variable-rgx '..?' --argument-rgx '..?'" " allow 1-2 char variable names in pylint
"" linting/debugging shortcuts
noremap <leader>lr  :ALELint<cr>
noremap <leader>lo  :lw<cr>
noremap <leader>lc  :lcl<cr>
noremap <leader>lw  :match ExtraWhitespace /\s\+$/<cr>
noremap <leader>lb  obreakpoint()<esc>k
noremap <expr> <leader>lg &scl=="no" ?
      \ 'mt:set scl=auto<cr>
            \ :highlight ALEError cterm=underline ctermfg=204 <cr>
            \ :highlight ALEWarning cterm=underline ctermfg=214 <cr>`t' :
      \ 'mt:set scl=no<cr>
            \ :highlight ALEError cterm=none ctermfg=none <cr>
            \ :highlight ALEWarning cterm=none ctermfg=none <cr>`t'
"" fixers
let g:ale_fixers = {'python': ['trim_whitespace']}
"" lsp/completion settings
set completeopt=menuone,noinsert
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled    = 0
let g:ale_completion_autoimport = 1  " don't think this is working
let g:ale_hover_cursor          = 0
let g:ale_set_balloons          = 0
"" lsp/completion shortcuts
inoremap `           <c-x><c-o>
inoremap ~~          ~
inoremap ~`          `
inoremap ;-          <down>
inoremap ;=          <up>
noremap  <leader>ld  :alegotodefinition<cr>
noremap  <leader>lR  :alerename<cr>
"" hover config
noremap <expr> <leader>lh getwinvar(winnr('#'), "&pvw") ?
      \ '<C-w>j <bar> :close<cr>`t' :
      \ 'mt:ALEHover<cr>'

" NERDTree
noremap <leader>n :NERDTreeToggle<cr>
noremap <leader>N :NERDTreeFind<cr>
" let NERDTreeShowHidden=1
let NERDTreeShowBookmarks = 1
let NERDTreeMouseMode     = 2
let g:NERDTreeQuitOnOpen  = 1
"" Exit vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Tagbar
noremap <leader>. :TagbarOpenAutoClose<cr>
let g:tagbar_wrap  = 1
let g:tagbar_width = max([25, winwidth(0) / 3])

" easymotion
let g:EasyMotion_startofline = 0   " keep cursor column when JK motion
let g:EasyMotion_smartcase   = 1     " turn on case-insensitive feature
map <leader>F <plug>(easymotion-prefix)
map <leader>j <Plug>(easymotion-bd-jk)
map <leader>f <Plug>(easymotion-s2)

" fugitive
set tags^=.git/tags;~

" gitgutter
let g:gitgutter_enabled = 0

" fzf
noremap <leader><space> :FZF ~ <cr>
let g:fzf_layout = {
  \ 'down': '~40%'
  \ }
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }
noremap <leader>/ :Rg<cr>,
noremap <leader>bs :Buffers<cr>,

" lightline integration with ale and fugitive
let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left':  [['mode', 'paste'],
      \             ['gitbranch', 'readonly', 'filename', 'modified']],
      \   'right': [['lineinfo'],
      \             ['percent'], ['filetype', 'fileencoding','fileformat'],
      \             ['linter_checking', 'linter_ok',
      \              'linter_errors', 'linter_warnings']]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \ 'linter_ok': 'ok',
      \ }

" fugitive
set tags^=.git/tags;~
noremap <leader>gc :Git commit -m
noremap <leader>gd :Git diff<cr>
noremap <leader>gl :Git log<cr>

" gitgutter
let g:gitgutter_enabled = 0
noremap <leader>gg :GitGutterToggle<cr>

" vim-smoothie
let g:smoothie_update_interval = 15
let g:smoothie_base_speed      = 7

" tab options (at end to prevent plugin overriding
set expandtab            " insert spaces instead of hard tabs
set tabstop=4            " hard tabs are 4 spaces
set softtabstop=4        " soft tabs are 4 spaces
set shiftwidth=4         " shift indentation levels ('>>', '<<', etc) by 4 spaces
set smarttab             " intelligently add whitespace with tabs
set autoindent
set smartindent

" (template for local customizations for potentially at some point)
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
