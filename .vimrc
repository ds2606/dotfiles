"  VIMRC


" ENVIRONMENT

" environment settings
set nocompatible
let mapleader = ","
noremap \, ,
set history=500
set wildmenu
set showcmd              " show most recent command
set splitbelow
set splitright
set nu                   " normal line numbering
set formatoptions-=cro   " don't autoinsert newline comments from comments (BROKEN)
set clipboard^=unnamed   " copy-paste across terminals
set foldlevel=99         " file unfolded by default
set matchtime=0
set encoding=utf8
set wrap
set textwidth=90         " inserted text automatically linebroken after 120 chars
set linebreak            " wrap lines at whitespace and punctuation, not mid-word
set breakindent          " wrap lines to same indent level
let &showbreak='  '      " little extra break for wrapped lines
set autoread             " auto-refresh unmodified buffers edited elsewhere
au  FocusGained,BufEnter * checktime  " check if buffer updated elsewhere
set magic                " enable special chars in regex ('*', '.', etc)
"set mouse=a              " allow mouse interface

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
set scl=number
set shortmess-=S  " show number of searches
noremap <cr> :noh<cr>

" aesthetics
colorscheme palenight
let      g:palenight_termcolors = 256
let      g:lightline = {
            \ 'colorscheme': 'palenight',
            \  }
syntax   enable            " syntax highlighting
set      showmatch         " show matching brachets
set      ruler
set      laststatus=2         " show status bar by default
set      noshowmode           " hide --MODE-- (redundant with lightline)
hi       ExtraWhitespace ctermbg=18 guibg=#87005f
match    ExtraWhitespace /\s\+$/
autocmd  BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd  InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd  InsertLeave * match ExtraWhitespace /\s\+$/
autocmd  BufWinLeave * call clearmatches()
" set colorcolumn=80
" highlight OverLength ctermfg=204
" match OverLength /\%81v.\+/


" KEYBINDINGS

" command mode remap
noremap ; :
noremap \; ;

" `jk` for insertion/visual escape
inoremap jk <esc>`^
vnoremap <space> <esc>

" map comma -> backtick (for marks: accomodates tmux prefix and ergonomic)
noremap ' `

" quick quit, write, and write-quit
noremap <leader>q :q<cr>
noremap <leader>Q :qa<cr>
noremap <leader>x :x<cr>
noremap <leader>c :close<cr>

" Y behaves like other capitals (act to end of line)
noremap Y y$

" easier redo
noremap U <C-r>

" unmap arrow keys in normal/visual mode (use hjkl)
noremap  <left>  :echoe "use h"<cr>
noremap  <right> :echoe "use l"<cr>
noremap  <up>    :echoe "use k"<cr>
noremap  <down>  :echoe "use l"<cr>
inoremap <left>  <C-o>:echoe "use ^h"<cr>i
inoremap <right> <C-o>:echoe "use ^l"<cr>i
inoremap <up>    <C-o>:echoe "use ^k"<cr>i
inoremap <down>  <C-o>:echoe "use ^l"<cr>i

" bracket/paren matching
noremap <leader>p %

" toggle line numbering
noremap <leader># :set nu!<cr>

" move vertically by visual line (don't skip wrapped lines)
nmap j gj
nmap k gk

" 'go to line' without reaching for shift
noremap gl G

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
noremap gH g^
noremap gL g$

" insert mode navigation (remap digraph insertion)
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-a> <esc>I
inoremap <C-e> <esc>A
inoremap <C-^> <C-o><C-^>
inoremap <C-d> <C-k>

" quick select-all
noremap <leader>va ggVG

" pane switching
noremap ]p          <C-w>w
noremap [p          <C-w>W
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" buffer management
set nohidden  " really close a buffer when closing it (prevents buflist blow-up) NOT SURE IF WORKING AS EXPECTED
noremap ]b          :bnext<cr>
noremap [b          :bprev<cr>
noremap <leader>bc  :BD<cr>
noremap <leader>bl  :buffers<cr>

" window/tab management
noremap ]t          :tabn<cr>
noremap [t          :tabp<cr>
noremap <leader>-   :sp<cr>
noremap <leader>_   :new<cr>
noremap <leader>\   :vsp<cr>
noremap <leader>\|  :vne<cr>
noremap <leader>wj  :tabmove -1<cr>
noremap <leader>wk  :tabmove +1<cr>
noremap <leader>wr  <C-w><C-r>
noremap <leader>wv  <C-w>H
noremap <leader>wh  <C-w>J
noremap <leader>wb  <C-w>T
noremap <leader>z   :call MaximizeToggle()<CR>
function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" normal mode insert newline, insert char, and delete line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>
nnoremap <leader>i i_<Esc>r
inoremap ;d   <esc>ddkA

" insert mode write, quit, perform normal-mode command, paste, and insert semicolon
inoremap ;ww  <esc>:w<cr>li
inoremap ;wq  <esc>:wq
inoremap ;x   <esc>:x
inoremap ;q   <esc>:q
inoremap ;n   <C-o>
inoremap ;p   <C-o>p
inoremap ;; ;

" easier macro repitition
noremap Q @@

" quick show registers
noremap <C-r> :registers<cr>

" quick syntax set
noremap <leader>sf :set ft=

" quick syntax reveal
map <leader>sr :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" delete trailing whitespace
noremap <silent> <leader>dw mt:let _s=@/ <bar>
      \ :%s/\s\+$//e<bar>:let @/=_s<cr>`t
      \ <bar> :echom "deleted trailing whitespace"<cr>:noh<cr>
" noremap <leader>lw  :match ExtraWhitespace /\s\+$/<cr>  "show trailing whitespace

" file shortcuts for quick editing (last is for sourcing .vimrc)
noremap <leader>en  :enew<cr>
noremap <leader>et  :tabnew<cr>
noremap <leader>eo  :tabedit <C-r>=expand("%:p:h")<cr>/
noremap <leader>eO  :tabedit <C-r><cr>
noremap <leader>ec  :CocConfig<cr>
noremap <leader>ez  :tabedit ~/.dotfiles/.zsh_profile<cr>
noremap <leader>ev  :tabedit ~/.vimrc<cr>
noremap <leader>es  :source  ~/.vimrc<cr> <bar> :echom "vim config reloaded"<cr>

" vim built-in terminal access
noremap <leader>tn  :ter<cr><C-w>:exe "resize" . (winheight(0) * 3/5) <cr>
noremap <leader>to  :sb zsh<cr><C-w>:exe "resize " . (winheight(0) * 3/5) <cr>
tnoremap ~n    <C-w>c:ter<cr><C-w>:exe "resize " . (winheight(0) * 3/5) <cr>
tnoremap ~c    <C-w>c
tnoremap ~d    <C-d>
" tnoremap <C-k> <C-w>k
tnoremap ~p    <C-w>w
tnoremap ~e    <C-w>N
tnoremap ~-    <C-w>k <bar> :res +3 <cr> <bar> <c-w>j
tnoremap ~=    <C-w>k <bar> :res -3 <cr> <bar> <c-w>j

" quick insertion of \(\) in search-replace
cmap ;\ \(\)<left><left>


" PLUG-INS

" vim-plug (to disable, append `{ 'on': [] }`
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'gillyb/stable-windows', { 'on': [] }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'maximbaz/lightline-ale'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim'
Plug 'preservim/nerdtree'
Plug 'psliwka/vim-smoothie'
Plug 'preservim/tagbar'
Plug 'qpkorr/vim-bufkill'
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'
Plug 'simeji/winresizer'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'uiiaoo/java-syntax.vim'
Plug 'w0rp/ale'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

" undotree toggle
noremap <leader>u :UndotreeToggle<cr>

" easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" bufkill
let g:BufKillCreateMappings = 0

" winresizer
let g:winresizer_horiz_resize  = 1
let g:winresizer_vert_resize   = 3
noremap <leader>r ,WinResizerStartResize<cr>

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
let g:EasyMotion_startofline = 0   " keep cursor column with line jump
let g:EasyMotion_smartcase   = 1   " turn on case-insensitive feature
map <leader>F <plug>(easymotion-prefix)
map <leader>j <Plug>(easymotion-bd-jk)
map <leader>f <Plug>(easymotion-s2)

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
noremap <leader>/ :Rg<cr>
noremap <leader>bs :Buffers<cr>

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

" fugitive/gitgutter
set tags^=.git/tags;~
noremap <leader>gg :Git<cr>
noremap <leader>gc :Git commit
noremap <leader>gd :Git diff<cr>
noremap <leader>gl :Git log<cr>
noremap <leader>gt :GitGutterToggle<cr>
noremap ]g         :GitGutterNextHunk<cr>
noremap [g         :GitGutterPrevHunk<cr>

" vim-smoothie
let g:smoothie_update_interval = 15
let g:smoothie_base_speed      = 7

" ALE (linting)
noremap <leader>lt  :ALEToggle<cr>
noremap <leader>lo  :lop<cr>
noremap <leader>lb  obreakpoint()<esc>k
noremap <silent>[l  :ALEPrevious<cr>
noremap <silent>]l  :ALENext<cr>
let g:ale_enabled               = 0
let g:ale_enabled               = 0
" let g:ale_disable_lsp           = 1
let g:ale_linters               = {'python': ['flake8', 'pylint'],
                                 \ 'rust': ['rls', 'rustc', 'analyzer', 'cargo'],
                                 \ 'zsh': ['bashate', 'shell', 'shellcheck'],
                                 \ 'cpp': ['ccls']}
let g:ale_python_flake8_options = "--ignore f403"  " allow 'import *'
let g:ale_python_pylint_options =
    \ "-d C0115,C0116,WO401 --variable-rgx '..?' --argument-rgx '..?'"  " allow 1-2 char variable names in pylint

" COC (completion/lsp)
set updatetime=300  " (for some reason, LSP/completion broken without this)
set shortmess+=c " Don't pass messages to \|ins-completion-menu\|.
inoremap ;~ ~
inoremap <silent><expr> ~
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lk :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
inoremap <silent><nowait><expr> - coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "-"
inoremap <silent><nowait><expr> = coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "="
inoremap <nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
nnoremap <nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
"" Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup

" tab options (at end to prevent plugin overriding)
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
