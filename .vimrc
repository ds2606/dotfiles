" vim: set foldmethod=marker foldlevel=0 nomodeline:
" .vimrc of Daniel Schreck
" ============================================================================
" (modeled after junegunn/dotfiles)

" * TODO: fix autocommands being multiply added with every 'source vimrc'

" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

" Environment
set nocompatible         " redundant but prefer explicit setting
set history=500
set wildmenu
set splitbelow
set splitright
set hidden               " don't unload buffers on window-close
set clipboard^=unnamed   " copy-paste across terminals
set autoread             " auto-update unmodified buffers edited elsewhere
au  FocusGained,BufEnter * checktime  " check if buffer updated elsewhere
set magic                " enable special chars in regex ('*', '.', etc)
set nostartofline        " keep cursor on same column when scrolling

" Formatting
au BufEnter * set fo-=o  " no normal-mode newline comment-prefix autoinsertion
set encoding=utf8
scriptencoding utf8
set textwidth=90         " inserted text automatically linebroken after 120 chars
set foldlevelstart=99    " file unfolded by default
set wrap
set linebreak            " wrap at whitespace and punctuation (not mid-word)
set breakindent          " wrap to same indent level
let &showbreak='••• '    " prefix for wrapped lines

" Aesthetics
colorscheme palenight
let g:palenight_termcolors = 256
syn enable         " syntax highlighting
set number         " normal line numbering
set ruler
set scl=number
set laststatus=2   " show status bar by default
set noshowmode     " hide --MODE-- (redundant with lightline)
set showcmd        " show pending operators in status bar
hi  ExtraWhitespace ctermbg=18 guibg=#87005f
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Backups, swap files, and persistent undo
set backup
set backupdir=~/.vim/backups/
set writebackup
set directory=~/.vim/tmp/
set undofile
set undodir=~/.vim/undo

" Search
set ignorecase
set smartcase
set hlsearch
let @/ = ''       " don't highlight last search when sourcing .vimrc
set incsearch
set shortmess-=S  " show number of searches


" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Leader
" ----------------------------------------------------------------------------
let mapleader = ','
noremap \, ,

" ----------------------------------------------------------------------------
" Command-line
" ----------------------------------------------------------------------------
" Entry
noremap ; :
noremap \; ;

" Exit
cnoremap jk <C-c>

" Navigation
cnoremap <nowait> <esc> <C-c>
cnoremap h <left>
cnoremap l <right>
cnoremap H <C-left>
cnoremap L <C-right>
cnoremap j <down>
cnoremap k <up>
cnoremap J <S-down>
cnoremap K <S-up>
cnoremap a <C-b>
cnoremap e <C-e>
cnoremap c <C-c>

" Editing
cnoremap w <C-w>
cnoremap u <C-u>
cnoremap d <BS>
cnoremap D <Del>

" Capture-group insertion
cmap ;\ \(\)<left><left>


" ----------------------------------------------------------------------------
" Insert
" ----------------------------------------------------------------------------

" Escape
inoremap jk <esc>`^

" Insert-leader
inoremap ;; ;

" Write/quit
inoremap ;ww  <esc>:w<CR>i<C-o>l
inoremap ;wq  <esc>:wq
inoremap ;q   <esc>:q
inoremap ;x   <esc>:x

" Navigation
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-a> <esc>I
inoremap <C-e> <esc>A
inoremap ;k <C-k>

" Editing
inoremap ;d   <esc>ddkA
inoremap ;p   <C-o>p

" Normal-mode
inoremap ;n   <C-o>

" Registers
inoremap ;r   <C-r>
inoremap ;R   <C-o>:registers<CR>


" ----------------------------------------------------------------------------
" Visual
" ----------------------------------------------------------------------------

" Escape
vnoremap <space> <esc>

" Moving lines
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-l> >gv
xnoremap <silent> <C-h> <gv


" ----------------------------------------------------------------------------
" Normal
" ----------------------------------------------------------------------------

" Quit
nnoremap <silent> <leader>x :x<CR>
nnoremap <silent> <leader>q :confirm qall<CR>
nnoremap <leader>Q :qall!<CR>

" Make Y behave like other capitals
nnoremap Y y$

" Redo
nnoremap U <C-r>

" Match-jumping
packadd! matchit
map <leader>p %

" Line numbering
nnoremap <leader># :set nu!<CR>

" Spell checking
nnoremap <leader>sp :set spell!<CR>

" Misc [e]ditor commands
nnoremap <silent> <leader>ev :tabedit ~/.vimrc<CR>
nnoremap <silent> <leader>ez :tabedit ~/.dotfiles/.zsh_profile<CR>
nnoremap <leader>ef :set ft=
nnoremap <silent> <leader>er :SynReveal<CR>
nnoremap <silent> <leader>ec :CdPwd<CR> <bar> :echo "changed pwd to" getcwd()<CR>
nnoremap <silent> <leader>ep :pwd<cr>
nnoremap <silent> <leader>ew :Chomp<CR>

" Movement by visual line
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Goto line
noremap gl G

" Scrolling
noremap <silent> - :call smoothie#downwards()<CR>
noremap <silent> = :call smoothie#upwards()<CR>
noremap _           <C-e>
noremap +           <C-y>
noremap <leader>=   =

" Boundary jumping
noremap H ^
noremap L $
noremap J L
noremap K H
noremap & J
nnoremap <C-k> K

noremap gL g$

" Select all
noremap <leader>va :keepjumps normal! ggVG<CR>

" Insert new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Insert single character
nnoremap <leader>i i_<esc>r

" ALT-mappings
nnoremap i <C-i>
nnoremap o <C-o>
nnoremap ] <C-]>

" Macro repitition
nnoremap Q @@

" Show registers and marks
nnoremap <leader>R :registers<CR>
nnoremap <leader>m :marks<CR>

" Insert an open-paren and yank the close-paren
nnoremap <leader>( i()<esc>x


" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------

" Open
nnoremap <leader>bn  :enew<CR>
nnoremap <leader>bo  :e <C-r>=trim(execute('pwd'))<CR>/

" Close
nnoremap <silent><leader>bc  :<C-u>call <SID>close_buffer(0)<CR>
nnoremap <leader>bC  :call <SID>close_buffer(1)<CR>
function! s:close_buffer(force) abort
    let l:buf_no = v:count ? v:count : bufnr('%')
    if bufnr(l:buf_no) < 0
        echohl ErrorMsg | echo 'Buffer ' . l:buf_no . ' not found' | echohl None
        return
    elseif getbufinfo('%')[0].changed && ! a:force
        echohl ErrorMsg | echo 'Buffer ' . l:buf_no . ' is modified' | echohl None
        return
    endif

    let l:buf_name = bufname(bufnr(l:buf_no))
    if l:buf_name ==# '' | let l:buf_name = '[No Name]' | endif
    let l:cmd = a:force  ? 'Bdelete! ' : 'Bdelete '
    exec l:cmd . l:buf_no
    echo 'Closed buffer <' . l:buf_no . ': ' . l:buf_name . '>'
endfunction

" Navigate
nnoremap <silent> ]b :bnext!<CR>
nnoremap <silent> [b :bprev!<CR>
nnoremap <silent> <leader>bg  :<C-u>exe "buffer" . v:count<CR>

" Info
nnoremap <leader>bl  :ls<CR>
nnoremap <leader>bL  :ls!<CR>
nnoremap <leader>bi  2<C-g>


" ----------------------------------------------------------------------------
" Windows
" ----------------------------------------------------------------------------

" Open
nnoremap <silent> <leader>-  :sp<CR>
nnoremap <silent> <leader>_  :new<CR>
nnoremap <silent> <leader>\  :vsp<CR>
nnoremap <silent> <leader>\| :vne<CR>

" Close
nnoremap <silent> <leader>c :close<CR>
nnoremap <silent> <leader>wc :close<CR>

" Navigate
noremap ]w <C-w>w
noremap [w <C-w>W
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap <left> <C-w>h
noremap <down> <C-w>j
noremap <right> <C-w>l
noremap <up> <C-w>k
inoremap <left>  <esc><C-w>h
inoremap <right> <esc><C-w>l
inoremap <up>    <esc><C-w>k
inoremap <down>  <esc><C-w>j

" Manipulate
noremap <leader>wr <C-w><C-r>
noremap <leader>wo <C-w><C-o>
noremap <leader>w= <C-w>=
noremap <leader>wv <C-w>H
noremap <leader>wh <C-w>J
noremap <leader>wb <C-w>T

" Zoom
nnoremap <silent> <leader>wz  :call <SID>zoom()<CR>
function! s:zoom()
    if winnr('$') > 1
        tab split
    elseif winnr('$') == 1 && tabpagenr() != 1
           \ && index(tabpagebuflist(tabpagenr() - 1), bufnr()) >= 0
        let shouldshift = tabpagenr() == tabpagenr('$') ? 0 : 1
        tabclose
        if shouldshift | tabp | endif
    endif
endfunction


" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------

" Open
nnoremap <silent> <leader>tn :tabnew<CR>
nnoremap <silent> <leader>to :tabedit<CR>
nnoremap <leader>to :tabedit <C-r>=trim(execute('pwd'))<CR>/

" Close
nnoremap <leader>tc :tabclose<cr>

" Navigate
noremap [t <C-PageUp>
noremap ]t <C-PageDown>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" Manipulate
nnoremap <silent> <leader>t< :tabmove -1<CR>
nnoremap <silent> <leader>t> :tabmove +1<CR>


" ----------------------------------------------------------------------------
" Quickfix/location lists
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz


" ----------------------------------------------------------------------------
" Source .vimrc
" ----------------------------------------------------------------------------
noremap <silent><leader>S :call <SID>src_vimrc()<CR> <bar> :call <SID>echo_src()<CR>
if !v:vim_did_enter
    " guard against concurrently redefining function while executing it
    function s:src_vimrc()
        let old_mls = &modelines  " don't collapse opened folds
        set modelines=0  " this should work with 'nomodeline' but doesn't for some reason
        source ~/.vimrc
        let &modelines=old_mls
        echohl Statement | echo 'vimrc sourced' | echohl None
    endfunction
endif
function s:echo_src()
    echohl Statement | echo 'vimrc sourced' | echohl None
endfunction


" }}}
" ============================================================================
" TEXT OBJECTS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Common
" ----------------------------------------------------------------------------
function! s:textobj_cancel()
    if v:operator ==# 'c'
        augroup textobj_undo_empty_change
            autocmd InsertLeave <buffer> execute 'normal! u'
                        \| execute 'autocmd! textobj_undo_empty_change'
                        \| execute 'augroup! textobj_undo_empty_change'
        augroup END
    endif
endfunction

noremap         <Plug>(TOC) <nop>
inoremap <expr> <Plug>(TOC) exists('#textobj_undo_empty_change')?"\<esc>":''


" ----------------------------------------------------------------------------
" ?ii / ?ai | indent-object
" ?io       | strictly-indent-object
" ----------------------------------------------------------------------------
function! s:indent_len(str)
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction

function! s:indent_object(op, skip_blank, b, e, bd, ed)
    let i = min([s:indent_len(getline(a:b)), s:indent_len(getline(a:e))])
    let x = line('$')
    let d = [a:b, a:e]

    if i == 0 && empty(getline(a:b)) && empty(getline(a:e))
        let [b, e] = [a:b, a:e]
        while b > 0 && e <= line('$')
            let b -= 1
            let e += 1
            let i = min(filter(map([b, e], 's:indent_len(getline(v:val))'), 'v:val != 0'))
            if i > 0
                break
            endif
        endwhile
    endif

    for triple in [[0, 'd[o] > 1', -1], [1, 'd[o] < x', +1]]
        let [o, ev, df] = triple

        while eval(ev)
            let line = getline(d[o] + df)
            let idt = s:indent_len(line)

            if eval('idt '.a:op.' i') && (a:skip_blank || !empty(line)) || (a:skip_blank && empty(line))
                let d[o] += df
            else | break | end
        endwhile
    endfor
    execute printf('normal! %dGV%dG', max([1, d[0] + a:bd]), min([x, d[1] + a:ed]))
endfunction
xnoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), 0, 0)<cr>
xnoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), -1, 1)<cr>
onoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), -1, 1)<cr>
xnoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line('.'), line('.'), 0, 0)<cr>


" ----------------------------------------------------------------------------
" #[i / #]i | go to previous/next indentation level
" ----------------------------------------------------------------------------
function! s:go_indent(times, dir)
    for _ in range(a:times)
        let l = line('.')
        let x = line('$')
        let i = s:indent_len(getline(l))
        let e = empty(getline(l))

        while l >= 1 && l <= x
            let line = getline(l + a:dir)
            let l += a:dir
            if s:indent_len(line) != i || empty(line) != e
                break
            endif
        endwhile
        let l = min([max([1, l]), x])
        execute 'normal! '. l .'G^'
    endfor
endfunction
nnoremap <silent> [i :<c-u>call <SID>go_indent(v:count1, -1)<cr>
nnoremap <silent> ]i :<c-u>call <SID>go_indent(v:count1, 1)<cr>


" ----------------------------------------------------------------------------
" <Leader>I/A | Prepend/Append to all adjacent lines with same indentation
" ----------------------------------------------------------------------------
nmap <silent> <leader>I ^vio<C-V>I
nmap <silent> <leader>A ^vio<C-V>$A


" ----------------------------------------------------------------------------
" ?i_ ?a_ ?i. ?a. ?i, ?a, ?i/
" ----------------------------------------------------------------------------
function! s:between_the_chars(incll, inclr, char, vis)
    let cursor = col('.')
    let line   = getline('.')
    let before = line[0 : cursor - 1]
    let after  = line[cursor : -1]
    let [b, e] = [cursor, cursor]

    try
        let i = stridx(join(reverse(split(before, '\zs')), ''), a:char)
        if i < 0 | throw 'exit' | end
        let b = len(before) - i + (a:incll ? 0 : 1)

        let i = stridx(after, a:char)
        if i < 0 | throw 'exit' | end
        let e = cursor + i + 1 - (a:inclr ? 0 : 1)

        execute printf('normal! 0%dlhv0%dlh', b, e)
    catch 'exit'
        call s:textobj_cancel()
        if a:vis
            normal! gv
        endif
    finally
        " Cleanup command history
        if histget(':', -1) =~# '<SNR>[0-9_]*between_the_chars('
            call histdel(':', -1)
        endif
        echo
    endtry
endfunction

for [s:c, s:l] in items({'_': 0, '.': 0, ',': 0, '/': 1, '-': 0})
    execute printf("xmap <silent> i%s :<C-U>call <SID>between_the_chars(0,  0, '%s', 1)<CR><Plug>(TOC)", s:c, s:c)
    execute printf("omap <silent> i%s :<C-U>call <SID>between_the_chars(0,  0, '%s', 0)<CR><Plug>(TOC)", s:c, s:c)
    execute printf("xmap <silent> a%s :<C-U>call <SID>between_the_chars(%s, 1, '%s', 1)<CR><Plug>(TOC)", s:c, s:l, s:c)
    execute printf("omap <silent> a%s :<C-U>call <SID>between_the_chars(%s, 1, '%s', 0)<CR><Plug>(TOC)", s:c, s:l, s:c)
endfor


" ----------------------------------------------------------------------------
" ?il | inner line
" ----------------------------------------------------------------------------
xnoremap <silent> il <esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<CR>


" ----------------------------------------------------------------------------
" ?i# | inner comment
" ----------------------------------------------------------------------------
function! s:inner_comment(vis)
  if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
    call s:textobj_cancel()
    if a:vis
      normal! gv
    endif
    return
  endif

  let origin = line('.')
  let lines = []
  for dir in [-1, 1]
    let line = origin
    let line += dir
    while line >= 1 && line <= line('$')
      execute 'normal!' line.'G^'
      if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
        break
      endif
      let line += dir
    endwhile
    let line -= dir
    call add(lines, line)
  endfor

  execute 'normal!' lines[0].'GV'.lines[1].'G'
endfunction
xmap <silent> ic :<C-U>call <SID>inner_comment(1)<CR><Plug>(TOC)
omap <silent> ic :<C-U>call <SID>inner_comment(0)<CR><Plug>(TOC)


" ----------------------------------------------------------------------------
" ?ic / ?iC | Blockwise column object
" ----------------------------------------------------------------------------
function! s:inner_blockwise_column(vmode, cmd)
  if a:vmode ==# "\<C-V>"
    let [pvb, pve] = [getpos("'<"), getpos("'>")]
    normal! `z
  endif

  execute "normal! \<C-V>".a:cmd."o\<C-C>"
  let [line, col] = [line('.'), col('.')]
  let [cb, ce]    = [col("'<"), col("'>")]
  let [mn, mx]    = [line, line]

  for dir in [1, -1]
    let l = line + dir
    while line('.') > 1 && line('.') < line('$')
      execute 'normal! '.l.'G'.col.'|'
      execute 'normal! v'.a:cmd."\<C-C>"
      if cb != col("'<") || ce != col("'>")
        break
      endif
      let [mn, mx] = [min([line('.'), mn]), max([line('.'), mx])]
      let l += dir
    endwhile
  endfor

  execute printf("normal! %dG%d|\<C-V>%s%dG", mn, col, a:cmd, mx)

  if a:vmode ==# "\<C-V>"
    normal! o
    if pvb[1] < line('.') | execute 'normal! '.pvb[1].'G' | endif
    if pvb[2] < col('.')  | execute 'normal! '.pvb[2].'|' | endif
    normal! o
    if pve[1] > line('.') | execute 'normal! '.pve[1].'G' | endif
    if pve[2] > col('.')  | execute 'normal! '.pve[2].'|' | endif
  endif
endfunction

xnoremap <silent> ib mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'iw')<CR>
xnoremap <silent> iB mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'iW')<CR>
xnoremap <silent> ab mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'aw')<CR>
xnoremap <silent> aB mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'aW')<CR>
onoremap <silent> ib :<C-U>call   <SID>inner_blockwise_column('',           'iw')<CR>
onoremap <silent> iB :<C-U>call   <SID>inner_blockwise_column('',           'iW')<CR>
onoremap <silent> ab :<C-U>call   <SID>inner_blockwise_column('',           'aw')<CR>
onoremap <silent> aB :<C-U>call   <SID>inner_blockwise_column('',           'aW')<CR>


" }}}
" ============================================================================
" COMMANDS {{{
" ============================================================================

" Autosave: toggle buffer autosaving
command! -bang Autosave call s:autosave(<bang>1)
function! s:autosave(enable)
    augroup autosave
        autocmd!
        if a:enable
            autocmd TextChanged,InsertLeave <buffer>
                \ if empty(&buftype) && !empty(bufname('')) | silent! update | endif
            echohl Statement | echo 'autosave enabled'
        else
            echohl WarningMsg | echo 'autosave disabled'
        endif
        echohl None
    augroup END
endfunction

" CdPwd: Change directory (only for current window) to that of current buffer file
command! CdPwd :lcd %:p:h

" Chomp: Delete trailing whitespace
command! Chomp exec "norm mt" | :%s/\s\+$//e | exe "norm `t"
    \ | echohl WarningMsg | echo "deleted trailing whitespace" | echohl None | noh

" Count: count number of occurrences in a file
command! -nargs=1 Count execute printf('%%s/%s//gn', escape(<q-args>, '/')) | normal! ``

" Diff: Toggle vimdiff for two splits
command! Diff :call ToggleDiff()
function ToggleDiff ()
    if (&diff)
        set nodiff noscrollbind
    else
        " enable diff options in both windows; balance the sizes, too
        wincmd =
        set diff scrollbind nowrap number
        wincmd w
        set diff scrollbind nowrap number
        wincmd w
    endif
endfunction

" GitRoot: Change directory to the root of the Git repository
function! s:git_root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
command! GitRoot call s:git_root()

" Goo: google a query
command! -nargs=1 Goo call s:goo(<f-args>, 0)
function! s:goo(pat, lucky)
  let q = substitute(a:pat, '["\n]', ' ', 'g')
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?%sq=%s"',
                   \ a:lucky ? 'btnI&' : '', q))
endfunction
nnoremap <leader>go :Goo<space>
" nnoremap <leader>? :call <SID>goog(expand("<cWORD>"), 0)<cr>
" nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>
" xnoremap <leader>? "gy:call <SID>goog(@g, 0)<cr>gv
" xnoremap <leader>! "gy:call <SID>goog(@g, 1)<cr>gv

" Redir: redirect command output into a scratch buffer
" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
" not working for e.g. the following command:
" > Redir for buf in getbufinfo({'bufloaded': 1, 'buflisted': 1}) | echo buf | endfor

command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)
function Redir(cmd, rng, start, end)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~# '^!'
		let cmd = a:cmd =~# ' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
		if a:rng == 0
			let output = systemlist(cmd)
		else
			let joined_lines = join(getline(a:start, a:end), '\n')
			let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
			let output = systemlist(cmd . ' <<< $' . cleaned_lines)
		endif
	else
		redir => output
		execute a:cmd
		redir END
		let output = split(output, "\n")
	endif
	vnew
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, output)
endfunction

" Sortwords: Sort words within a line
command! Sortwords :call setline('.',join(sort(split(getline('.'),' ')),' '))

" SynReveal: Reveal syntax categories
command! SynReveal :echo 'hi<' . synIDattr(synID(line("."),col("."),1),"name") . '> '
    \ . 'trans<' . synIDattr(synID(line("."),col("."),0),"name") . '> '
    \ . 'lo<' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . '>'
" junegunn's take on this, worth comparing
" function! s:hl()
"   " echo synIDattr(synID(line('.'), col('.'), 0), 'name')
"   echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')
" endfunction
" command! HL call <SID>hl()

" ----------------------------------------------------------------------------
" fasd_cd integration
" ----------------------------------------------------------------------------

" Cd: change directory (with fasd database update)
command! -complete=dir -nargs=* Cd :call Cd(<f-args>)
function! Cd(...)
    if a:0 == 0
        call fzf#run(fzf#wrap({'source': 'fd -t d -H -E .git -E .dropbox.cache
            \ --ignore-file ~/.dotfiles/.gitignore-global . ~/desktop/dropbox',
            \ 'sink': function('s:_fasdcd_sink_for_fzf')}))
    elseif a:0 == 1
        call s:_call_fasd_hook(a:1)
        exec 'cd ' . a:1
        echo getcwd()
    else
        echoe "':Cd' accepts a maximum of one argument."
    endif
endfunction

" Z: jump to directory
command! -nargs=* Z :call s:_fasd_cd(0, <f-args>)

" Z: jump to directory, interactively (with FZF)
command! -nargs=* ZZ :call s:_fasd_cd(1, <f-args>)

" utility functions
function s:_fasd_cd(interactive, ...)
    if a:0 == 0
        echoe 'No argument given'
    else
        let args = ''
        for arg in a:000
            let args = args . ' ' . arg
        endfor
        if a:interactive == 0
            let cmd = 'fasd -d -e printf'
            let path = system(cmd . args)
            if !isdirectory(path)
                echoe 'no matches for [' . args . ' ] in fasd database'
                return
            endif
            call s:_call_fasd_hook(path)
            exec 'cd ' . path
            echo path
        elseif a:interactive == 1
            let cmd = 'fasd -dlR'
            let fasd_output = split(system(cmd . args), '\n')
            call fzf#run(fzf#wrap({'source': fasd_output,
                \ 'sink': function('s:_fasdcd_sink_for_fzf')}))
        endif
    endif
endfunction
function s:_call_fasd_hook(dir)
    let fasd_ps = job_start('fasd --proc $(fasd --sanitize cd ' . a:dir . ')')
endfunction
function s:_fasdcd_sink_for_fzf(dir)
    exec 'cd ' . a:dir
    call s:_call_fasd_hook(a:dir)
    echo a:dir
endfunction


" }}}
" ============================================================================
" AUTOCOMMANDS {{{
" ============================================================================

" Help buffer configuration
function! s:helptab()
    if &buftype ==# 'help'
        nnoremap <silent><buffer> q :q<cr>
        nnoremap <silent><buffer> u :call smoothie#upwards()<CR>
        nnoremap <silent><nowait><buffer> d :call smoothie#downwards()<CR>
    endif
endfunction
autocmd BufEnter *.txt call s:helptab()


" }}}
" ============================================================================
" PLUGINS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Set-up
" ----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Graphical extensions
Plug 'ds2606/nerdtree'
Plug 'junegunn/gv.vim'
Plug 'itchyny/lightline.vim'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'preservim/tagbar'
Plug 'mbbill/undotree'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'

" Utilities
Plug 'aymericbeaumet/vim-symlink'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'moll/vim-bbye'
Plug 'ap/vim-css-color'
Plug 'easymotion/vim-easymotion'
Plug 'samoshkin/vim-mergetool'
Plug 'psliwka/vim-smoothie'
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'simeji/winresizer'

" Text-handling
Plug 'jiangmiao/auto-pairs', { 'on': [] }
Plug 'mattn/emmet-vim'
Plug 'junegunn/vim-easy-align'
Plug 'svermeulen/vim-yoink'

" Languages
Plug 'uiiaoo/java-syntax.vim'
Plug 'rust-lang/rust.vim'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'preservim/vim-markdown'
Plug 'mzlogin/vim-markdown-toc'
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'

"" LSP/linting
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', { 'branch': 'release'}
Plug 'maximbaz/lightline-ale'

"" tpope
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch', { 'on': [] }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

call plug#end()


" ----------------------------------------------------------------------------
" ALE (linting)
" ----------------------------------------------------------------------------
nnoremap <silent><leader>st  :ALEToggle<CR>
nnoremap <silent><leader>so  :lop<CR>
nnoremap <silent><leader>sc  :ccl<bar>lcl<CR>
nnoremap <leader>sb  obreakpoint()<esc>k
let g:ale_enabled = 0
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'rust': ['rls', 'rustc', 'analyzer', 'cargo'],
    \ 'zsh': ['shell', 'shellcheck'],
    \ 'cpp': ['ccls'] }
let g:ale_python_pylint_options =
    \ "-d C0115,C0116,WO401 --variable-rgx '..?' --argument-rgx '..?'"  " allow 1-2 char variable names in pylint
let g:ale_sh_shellcheck_dialect = 'bash'


" ----------------------------------------------------------------------------
" COC (lsp)
" ----------------------------------------------------------------------------

" Completion
function! ShouldTabComplete()
    let col = col('.') - 1
    let char = getline('.')[col - 1]
    if !col || char =~# '\s'
        return 0
    else
        return 1
    endif
endfunction
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ ShouldTabComplete() ? coc#refresh() : "<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
nmap <silent> <leader>sd <Plug>(coc-definition)

" Show documentation
nnoremap <silent> <leader>sk :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . ' ' . expand('<cword>')
    endif
endfunction

" Float-window scrolling
noremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ?
     \ coc#float#scroll(1) : "\<C-d>"
noremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ?
     \ coc#float#scroll(0) : "\<C-u>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ?
     \ "\<c-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ?
     \ "\<c-r>=coc#float#scroll(0)\<CR>" : "\<Left>"

" Misc
nnoremap <leader>sl :CocList<CR>
nmap <leader>sr <Plug>(coc-rename)
nnoremap <leader>sC :tabedit ~/.vim/coc-settings.json<CR>
set updatetime=300  " (for some reason, LSP/completion broken without this)
set shortmess+=c " Don't update statusline with completion information
"" set nobackup nowritebackup  " Some servers have issues with backup files (see #649)

" ----------------------------------------------------------------------------
" undotree
" ----------------------------------------------------------------------------
nnoremap <leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1

" ----------------------------------------------------------------------------
" easy-align
" ----------------------------------------------------------------------------
nnoremap ga <Plug>(EasyAlign)
xnoremap ga <Plug>(EasyAlign)

" ----------------------------------------------------------------------------
" yoink
" ----------------------------------------------------------------------------
let g:yoinkSwapClampAtEnds = 0
let g:yoinkIncludeDeleteOperations = 1
nnoremap <silent> <leader>y :Yanks<CR>
inoremap ;y <C-o>:Yanks<CR>
nnoremap [y <Plug>(YoinkRotateBack)
nnoremap ]y <Plug>(YoinkRotateForward)
nnoremap [Y :<C-u>call yoink#rotateThenPrint(1)<CR>:Yanks<CR>
nnoremap ]Y :<C-u>call yoink#rotateThenPrint(-1)<CR>:Yanks<CR>
nnoremap p  <Plug>(YoinkPaste_p)
nnoremap P  <Plug>(YoinkPaste_P)
nnoremap gp <Plug>(YoinkPaste_gp)
nnoremap gP <Plug>(YoinkPaste_gP)

" ----------------------------------------------------------------------------
" winresizer
" ----------------------------------------------------------------------------
let g:winresizer_horiz_resize  = 1
let g:winresizer_vert_resize   = 3
nnoremap <leader>r :WinResizerStartResize<CR>

" ----------------------------------------------------------------------------
" tagbar
" ----------------------------------------------------------------------------
nnoremap <leader>] :TagbarOpenAutoClose<CR>
let g:tagbar_wrap  = 1
let g:tagbar_width = max([25, winwidth(0) / 3])

" ----------------------------------------------------------------------------
" easymotion
" ----------------------------------------------------------------------------
let g:EasyMotion_smartcase   = 1
map <leader><leader>em <Plug>(easymotion-prefix)
map <leader>j <Plug>(easymotion-bd-jk)
map <leader>f <Plug>(easymotion-s2)

" ----------------------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------------------
nnoremap <leader>n :NERDTreeToggle <C-r>=trim(execute('pwd'))<CR><CR>
nnoremap <leader>N :NERDTreeFind<CR>
let NERDTreeShowHidden    = 1
let NERDTreeShowBookmarks = 1
let NERDTreeQuitOnOpen    = 1
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree')
    \ && b:NERDTree.isTabTree() | quit | endif

" ----------------------------------------------------------------------------
" FZF
" ----------------------------------------------------------------------------

" Basic configuration
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-h': 'split',
    \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '33%' }
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

" Top-level bindings
nnoremap <leader>/ :FzfDropbox<CR>
nnoremap <leader>h :Helptags<CR>

" Second-level bindings
nnoremap <leader>z/ :FzfPwd<CR>
nnoremap <leader>zb :Buffers<CR>
nnoremap <leader>zj :BLines<CR>
nnoremap <leader>zt :BTags<CR>
nnoremap <leader>zm :Marks<CR>
nnoremap <leader>zg :Rg<CR>
nnoremap <leader>zG :Rghidden<CR>

" Custom commands
command! -bang -nargs=* Rghidden call fzf#vim#grep("rg -. --column --line-number
    \ --no-heading --color=always --smart-case -- ".shellescape(<q-args>),
    \ 1, fzf#vim#with_preview(), <bang>0)
command! FzfDropbox call fzf#run(fzf#wrap({'source':
    \ 'fd -H -E .git -E .dropbox.cache --ignore-file
    \ ~/.dotfiles/.gitignore-global . ~/desktop/dropbox'}))
command! FzfPwd call fzf#run(fzf#wrap({'source':
    \ 'fd -H -E .git -E --ignore-file ~/.dotfiles/.gitignore-global'}))
command! -bar MoveBack if &buftype == 'nofile' && (winwidth(0) < &columns / 3 || winheight(0) < &lines / 3) | execute "normal! \<c-w>\<c-p>" | endif

" ----------------------------------------------------------------------------
" lightline
" ----------------------------------------------------------------------------
let g:lightline = {
    \ 'colorscheme': 'palenight',
    \ 'active': {
        \   'left':  [['mode', 'paste'],
        \             ['readonly', 'filename', 'gitbranch', 'modified']],
        \   'right': [['lineinfo'],
        \             ['filetype', 'fileencoding','bufnum', 'percent'],
        \             ['linter_checking', 'linter_ok',
        \              'linter_errors', 'linter_warnings', 'linter_infos' ]]
        \ },
    \ 'inactive': {
        \ 'left': [['filename'], ['modified']],
        \ 'right': [['lineinfo'], ['percent'], ['bufnum']] },
    \ 'component_function': {
        \   'gitbranch': 'FugitiveHead'
        \ },
    \ }
let g:lightline.component_expand = {
    \  'linter_checking': 'lightline#ale#checking',
    \  'linter_warnings': 'lightline#ale#warnings',
    \  'linter_errors': 'lightline#ale#errors',
    \  'linter_infos': 'lightline#ale#infos',
    \  'linter_ok': 'lightline#ale#ok',
    \ }
let g:lightline.component_type = {
    \ 'linter_errors': 'error',
    \ 'linter_infos': 'info',
    \ 'linter_ok': 'ok',
    \ 'linter_warnings': 'warning',
    \ }
    let g:lightline.subseparator = { 'left': '|', 'right': '|' }

" ----------------------------------------------------------------------------
" Git (fugitive, gitgutter, gv.vim)
" ----------------------------------------------------------------------------
set tags^=.git/tags;~
let g:gitgutter_map_keys = 0
nnoremap <silent> <leader>gg :Git<CR>
nnoremap <silent> <leader>gd :Git diff<CR>
nnoremap <silent> <leader>gl :Git log<CR>
nnoremap <silent> <leader>gs :Git status<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gm :Gvdiffsplit!<CR>
nnoremap <silent> <leader>gt :GitGutterToggle<CR>
nnoremap <silent> <leader>gc :pclose<CR>
nnoremap <silent> <leader>gv :GV<CR>
nnoremap <silent> <leader>gV :GV!<CR>
nnoremap <silent> <leader>g1 :diffge //2<CR>
nnoremap <silent> <leader>g2 :diffge //3<CR>
nnoremap <leader>gp <Plug>(GitGutterPreviewHunk)
nnoremap <leader>gu <Plug>(GitGutterUndoHunk)
nnoremap ]g         <Plug>(GitGutterNextHunk)
nnoremap [g         <Plug>(GitGutterPrevHunk)

" ----------------------------------------------------------------------------
" vim-smoothie
" ----------------------------------------------------------------------------
let g:smoothie_update_interval = 15
let g:smoothie_base_speed      = 7

" ----------------------------------------------------------------------------
" VimTeX
" ----------------------------------------------------------------------------
let g:vimtex_view_method = 'skim'
let g:vimtex_compiler_latexmk = {
    \ 'build_dir': {-> join([expand("%:t:r"),'-builddir'], '')},
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
    \ }

" ----------------------------------------------------------------------------
" emmet
" ----------------------------------------------------------------------------
imap ;e <Plug>(emmet-expand-abbr)
" let g:user_emmet_leader_key = ';e'

" ----------------------------------------------------------------------------
" Markdown
" ----------------------------------------------------------------------------
nnoremap <leader>e1 m`yypVr=``
nnoremap <leader>e2 m`yypVr-``
nnoremap <leader>e3 m`^i### <esc>``4l
nnoremap <leader>e4 m`^i#### <esc>``5l
nnoremap <leader>e5 m`^i##### <esc>``6l
let g:instant_markdown_autostart = 0
autocmd FileType markdown nnoremap <buffer><silent> <C-s> :InstantMarkdownPreview<CR>
autocmd FileType markdown nnoremap <buffer><silent> <C-q> :InstantMarkdownStop<CR>


" }}}
" ============================================================================
" END-OF-FILE CONFIGS (prevent plugin overriding) {{{
" ============================================================================

" Tab options
set expandtab      " insert spaces instead of hard tabs
set tabstop=4      " hard tabs are 4 spaces
set softtabstop=4  " soft tabs are 4 spaces
set shiftwidth=4   " shift indentation levels ('>>', '<<', etc) by 4 spaces
set smarttab       " intelligently add whitespace with tabs
set autoindent
set smartindent

" Bindings
noremap <silent> <leader><CR> :noh<CR>


" }}}
" ============================================================================
" LOCAL VIMRC {{{
" ============================================================================
let s:local_vimrc = fnamemodify(resolve(expand('<sfile>')), ':p:h').'/vimrc-extra'
if filereadable(s:local_vimrc)
  execute 'source' s:local_vimrc
endif


" }}}
" ============================================================================
