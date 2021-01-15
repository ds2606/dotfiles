" VIMRC


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
set textwidth=80         " inserted text automatically linebroken after 120 chars
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


" KEYBINDINGS

" command mode remap
noremap ; :
noremap \; ;

" jk for insertion escape
inoremap jk <esc>l

" quick quit, write, and write-quit
noremap <leader>q :q<cr>
noremap <leader>x :wq<cr>

" new file
noremap <leader>n :new<cr>

" Y behaves like other capitals
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
noremap <leader>bc  :BD<cr>
noremap <leader>bl  :buffers<cr>

" tab/window management
noremap ]p          <C-w>w
noremap [p          <C-w>W
noremap <leader>\   :vsp<cr>
noremap <leader>-   :sp<cr>
noremap <leader>wv  <C-w>H
noremap <leader>wh  <C-w>J
noremap <leader>wt  :tabnew<cr>
noremap <leader>wo  :tabedit <C-r>=expand("%:p:h")<cr>/
noremap <leader>wO  :tabedit
noremap <leader>ws  :W<cr>
noremap ]t          :tabn<cr>
noremap [t          :tabp<cr>
noremap <leader>wb <C-w>T
noremap <leader>wm :call MaximizeToggle()<CR>
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

" quickfix/location-list navigation
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz
noremap <leader>wqo  :cw<cr>
noremap <leader>wqc  :ccl<cr>
noremap <leader>wlo  :lw<cr>
noremap <leader>wlc  :lcl<cr>

" normal mode newline
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" insert mode write/quit
inoremap ;ww  <esc>:w<cr>li
inoremap ;wq  <esc>:wq
inoremap ;x  <esc>:x
inoremap ;q   <esc>:q

" easier macro repitition
noremap Q @@

" delete trailing whitespace
noremap <silent> <leader>dw mt:let _s=@/ <bar>
      \ :%s/\s\+$//e<bar>:let @/=_s<cr>`t
      \ <bar> :echom "deleted trailing whitespace"<cr>
" noremap <leader>lw  :match ExtraWhitespace /\s\+$/<cr>  "show trailing whitespace

" file shortcuts for quick editing (last is for sourcing .vimrc)
noremap <leader>ev  :tabedit ~/.vimrc<cr>
noremap <leader>es  :source  ~/.vimrc
noremap <leader>ez  :tabedit ~/.dotfiles/.zsh_profile<cr>

" terminal access
noremap <leader>sn   :ter<cr>
      \<c-w>:exe          "resize" . (winheight(0) * 3/5) <cr>
noremap <leader>so   :sb zsh<cr>
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
Plug 'maximbaz/lightline-ale'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'on': [], 'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'psliwka/vim-smoothie'
Plug 'preservim/tagbar'
Plug 'qpkorr/vim-bufkill'
Plug 'sheerun/vim-polyglot'
Plug 'simeji/winresizer'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

" undotree toggle
noremap <leader>u :UndotreeToggle<cr>

" easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" winresizer
let g:winresizer_horiz_resize   = 1
let g:winresizer_vert_resize    = 3
noremap <leader>r :WinResizerStartResize<cr>

" ALE
let g:ale_enabled               = 0  " ale disabled by default
let g:ale_linters               = {'python': ['flake8', 'pylint']}
let g:ale_python_flake8_options = "--ignore F403"  " allow 'import *'
let g:ale_python_pylint_options =
    \ "-d C0115,C0116,WO401 --variable-rgx '..?' --argument-rgx '..?'"  " allow 1-2 char variable names in pylint
"" linting/debugging shortcuts
noremap <leader>lt  :ALEToggle<cr>
noremap <leader>lo  :lw<cr>
noremap <leader>lc  :lcl<cr>
noremap <leader>lw  :match ExtraWhitespace /\s\+$/<cr>
noremap <leader>lb  obreakpoint()<esc>k
noremap <leader>ld  :alegotodefinition<cr>
noremap <leader>lR  :alerename<cr>
set completeopt=menuone,noinsert
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled    = 1
let g:ale_completion_autoimport = 1  " don't think this is working
let g:ale_hover_cursor          = 0
let g:ale_set_balloons          = 0
inoremap `           <c-x><c-o>
inoremap ~~          ~
inoremap ~`          `
inoremap ;-          <down>
inoremap ;=          <up>

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

" experimenting with CoC
" Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup

" " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" " delays and poor user experience.
" set updatetime=300

" " Don't pass messages to |ins-completion-menu|.
" set shortmess+=c

" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-@> coc#refresh()

" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" " Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction

" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" " Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" " Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" " Use CTRL-S for selections ranges.
" " Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Mappings for CoCList
" " Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
