" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: penzo <marvin@42.fr>                       +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2019/03/25 17:57:53 by penzo             #+#    #+#              "
"    Updated: 2019/04/14 19:47:11 by penzo            ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

"For MacBook Air
set tabstop=4
set shiftwidth=4
set runtimepath^=~/.vim/pack/plugins/start/rust.vim "pas sure
set cindent

syntax on				"set colors
set nu					"display lines number
"set clipboard+=unnamed "for copypasta //doesn4t work :(
set colorcolumn=80		"display Norm column
highlight ColorColumn ctermbg=17
highlight CursorLine cterm=none guibg=#303000 ctermbg=235

"<O> is now instant
set timeout timeoutlen=5000 ttimeoutlen=100

"those commands needs autocmd to be effective at lauch
"au = autocmd

" auto source my syntax file
augroup Sourcegroup
	au!
	autocmd Vimenter,Bufenter * source ~/.vimsyntax.vim
augroup END

"create 42 comments style naturaly
augroup Commentgroup
"this line protect from multi including "need fix for macbook
	au!
	au VimEnter,WinEnter,BufWinEnter * set comments=sl:/*,mb:**,elx:*/
augroup END

augroup CursorLine
	au!
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup END

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal! g'\"" | endif
endif

"autocmd Bufenter * vertical resize 84 "automatically resize when split

" <f1> already maped to 42Header

" press f2 to toggle relative nu
map <f2> :set rnu! <CR>

map <f5> f)i, char** env<Esc>

" <Alt-j> move current line down
no ∆ ddp
" <Alt-k> move current line up
no ˚ ddkP
ino ˚ <Esc> ddkPi
" <Alt-l> move all current line to the right
no ¬ V>
" <Alt-h> move all current line to the right
no ˙ V<

"######FOLDING
set nofoldenable "will not autofold when opening a file
set foldmethod=indent
set foldnestmax=1


"fold brackets "i could find a better shortcut
"no \\ zf%
"set foldmethod=marker
"set foldmarker=/*,*/

"Map Y to yank until end of line
no Y y$

"Map U to reverse undo
map U <C-r>

"this prevent // to recomment the next newline
"https://vi.stackexchange.com/questions/15444/remove-automatic-comment-leader?rq=1
inoremap <silent><expr> <bs> getline('.') =~# '^//\s*$' ? "<c-u>" : "<bs>"

"this redirect swp files into ~/.vim/swp_files
set directory^=$HOME/.vim/swp_files//

"autocompletion options
set path+=**
set wildmenu
"set wildmode=list:full
set wildchar=<Tab>

set ignorecase	"no 'casesensitive' research
set smartcase	"unless pattern contain Maj

"set nocompatible	"ignore old Vi (USELESS)
set	wrap

set splitright	"More natural spliting
set sb			"More natural spliting
set showcmd		"show command in status bar
set showmatch	"show matching parentheses

" SCROLLING
"set scrolloff=8		"keep 8 lines visible C'est bof

"Buffer and Split
nnoremap <C-c> :bp\|bd #<CR>	"<Ctrl-c> to close buffer without closing split
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set hidden		"buffer thing

nnoremap gn :bn<CR>
nnoremap gp :bp<CR>
nnoremap gd :bp\|bd #<CR>
"refresh buffer
nnoremap gr :e!<CR>
"press gb to naviguate between buffers (Number or name(tab)) "ex: gb .h<tab>
nnoremap gb :ls<CR>:b<Space>


set tw=80
" fill rest of linLe with characters
function! FillLine( str )
	" set tw to the desired total length
	let tw = &textwidth
	if tw==0 | let tw = 80 | endif
	" strip trailing spaces first
	.s/[[:space:]]*$//
	" calculate total number of 'str's to insert
	let reps = (tw - col("$")) / len(a:str)
	" insert them, if there's room, removing trailing spaces (though forcing
	" there to be one)
	if reps > 0
		.s/$/\=(' '.repeat(a:str, reps))/
	endif
endfunction

map <F3> :call FillLine( '-' )<CR>

map <F4> A//<ESC>20A<TAB><ESC>d80\|a
":set ve=all<CR> :set ve=block<CR>

"Remap command for typos
command! WQ wq
command! Wq wq
command! W w
command! Q q

nnoremap <F5> 0i//<Esc>
nnoremap <F6> A//
nnoremap <F7> 0/\/\/<CR>D
nnoremap go :find 

"cscope test
"if has("cscope")
"    set csprg=~/bin/cscope
"    set csto=0
"    set cst
"    set nocsverb
"    " add any database in current directory
"    if filereadable("cscope.out")
"        cs add cscope.out
"        " else add database pointed to by environment
"    elseif $CSCOPE_DB != ""
"        cs add $CSCOPE_DB
"    endif
"endif
"==========	CCSCOPE
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>


    " Hitting CTRL-space *twice* before the search type does a vertical
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif
