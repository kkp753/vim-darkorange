
set nocompatible

syntax on

set title
set tabstop=3
set autoindent
set incsearch
set number
set showmatch

set backspace=start,eol,indent

"Move cursor across the Line
set whichwrap=b,s,[,],<,>,,~

"Visualize tab or space @ end of line
set list
set listchars=tab:>\ ,trail:_
hi SpecialKey ctermfg=DarkGray

"Move cursor by Display Lines
nnoremap <Down> gj
nnoremap <Up> gk

"Fortran90 free-form
let fortran_free_source=1
let fortran_fold=1


" dein.vim -- Dark powered Vim/Neovim plugin manager

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME

let s:dein_dir = s:cache_home . '/dein'
let s:dein_path = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:dein_remote = 'https://github.com/Shougo/dein.vim'

" Load/Download dein.vim
"  &<vim option> : use options in script
"  ! : not, ~ : match, # : check the case of letter
"if &runtimepath !~# '/dein.vim'

if !isdirectory(s:dein_path)
  call system('git clone ' . s:dein_remote ." ". s:dein_path)
endif
exec "set runtimepath+=" . expand(s:dein_path)

" Load Plugins
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)
	" load from TOML file
	let s:toml_dir = s:config_home . '/dein'
	call dein#load_toml(s:toml_dir . '/dein.toml',      {'lazy': 0})
	call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})

	call dein#end()
	call dein#save_state()
endif

" Auto install
if has('vim_starting') && dein#check_install()
	call dein#install()
endif




" まずは回数指定の数値をリセット('10O'とかを防止するため)
" 現在行(expand('.'))のに空行''をAppend,<CR>で実行
" エディットモードを抜けて, 後にカーソル移動(j)
nnoremap O :<C-u>call append(expand('.'), '')<CR>j

" Enterでその場改行
nnoremap <CR> i<CR><Esc>
" ^M: Ctrl-v Shift-Enter でShift-Enterになるらしい
 


"colorscheme darkorange

" returns synID under the cursor
function! s:get_sid()
   return synID(line("."), col("."), 1)
endfunction
function! s:get_sid_trans()
   return synIDtrans(synID(line("."), col("."), 1))
endfunction


command! ShowSynColor echo
 \ synIDattr(s:get_sid(), "name") "(" synIDattr(s:get_sid(), "fg", "cterm") ") @"
 \ synIDattr(s:get_sid_trans(), "name") "(" synIDattr(s:get_sid_trans(), "fg", "cterm") ")"

" Show Hilight Syntax of the item under a cursor
command! ShowHlSyn echo synIDattr(synID(line("."), col("."), 1), "name")
                  \ "@" synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")


command! ShowHlSyn echo synIDattr(synID(line("."), col("."), 1), "name")
                  \ "@" synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")

command! -nargs=* ShowSyn call s:print_syn(<f-args>)
" <args>    ... arguments
" <f-args>  ... expand arguments for function

function! s:print_syn(...)
	" a:0 ... number of arguments
	if a:0 == 2
		let vofs = a:1
		let hofs = a:2
	else
		let vofs = 0
		let hofs = 0
	endif
	let sid = synID(line(".")+vofs, col(".")+hofs, 1)
	let tid = synIDtrans(sid)
	echo synIDattr(sid, "name") "(" synIDattr(sid, "fg", "cterm") ") @"
	   \ synIDattr(tid, "name") "(" synIDattr(tid, "fg", "cterm") ")"
endfunction

" [scope]
" l: function local        ... Default in the function
" g: global                ... Default in the other part
" a: argument
" s: script file local (?)



"------------------------------------------------------------------------
"  COLORSCHEME UTILITIES AND RULES
"------------------------------------------------------------------------

"256 colors
set t_Co=256

" set style to syntax group
function! s:h(group, style)
	execute "highlight" a:group
	 \ "guifg="   (has_key(a:style,   "guifg") ? a:style.guifg   : "NONE")
	 \ "guibg="   (has_key(a:style,   "guibg") ? a:style.guibg   : "NONE")
	 \ "gui="     (has_key(a:style,     "gui") ? a:style.gui     : "NONE")
	 \ "ctermfg=" (has_key(a:style, "ctermfg") ? a:style.ctermfg : "NONE")
	 \ "ctermbg=" (has_key(a:style, "ctermbg") ? a:style.ctermbg : "NONE")
	 \ "cterm="   (has_key(a:style,   "cterm") ? a:style.cterm   : "NONE")
endfunction

" Styles
let s:norm = {"ctermfg":"145", "ctermbg":"234"}
let s:weak = {"ctermfg":"241"}
let s:stg1 = {"ctermfg":"166", "cterm":"BOLD"}
let s:stg2 = {"ctermfg":"166"}
let s:stg3 = {"ctermfg":"102", "cterm":"BOLD"}
let s:acnt = {"ctermfg":"68"}
let s:hide = {"ctermfg":"237"}
" Lime :148
let s:invt = {"ctermbg":"214"}
let s:todo = {"ctermfg":"241", "ctermbg":"214"}
let s:outf = {"ctermfg":"59",  "ctermbg":"236"}
let s:stln = {"ctermfg":"166", "ctermbg":"236"}

"------------------------
" Gray   : 015(#ff) > 255(#ee) > 254(#e4) > 253(#da)
"        > 252(#d0) > 251(#c6) >   7(#c0) > 250(#bc)
"        > 249(#b2) > 145(#af) > 248(#a8) > 247(#9e)
"        > 246(#94) > 255(#8a) > 102(#87) >   8(#80) = 244(#80)
"        > 243(#76) > 242(#6c) > 241(#62) >  59(#5f)
"        > 240(#58) > 239(#4e) > 238(#44) > 237(#3a)
"        > 236(#30) > 235(#26) > 234(#1c) > 233(#12)
"        > 232(#08) >   0(#00)
" Orange : 214 > 208 > 166 > 130
" Lime   : 148
" Blue   : 68
"------------------------
let s:test = {"ctermfg":"13"}

" Text
call s:h("Normal",       s:norm) " Normal Text
call s:h("Comment",      s:weak) " Comment
call s:h("Statement",    s:stg3) " let/do/for/if/...
"Conditional .. if/then/else/switch/..
"Repeat      .. for/do/while/..
"Label       .. case/default/..
"Operator    .. sizeof/+/-/..
"Keyword     .. others
"Exception   .. try/catch/..
call s:h("Identifier",   s:stg2) " var
"call s:h("Function") " function/methods
call s:h("Special",      s:stg3) " {}(block)
call s:h("Type",         s:stg2) " Type
call s:h("PreProc",      s:stg2) " #define/#include/..
call s:h("SpecialKey",   s:hide) " space at line end, tab
" Constant and minor groups
call s:h("Constant",     s:acnt) " literal
call s:h("String",       s:stg3) "
"call s:h("Character")
"call s:h("Number")
"call s:h("Boolean")
"call s:h("Float")
" Cursor
call s:h("MatchParen",   s:acnt) " Matched ()[]{}
call s:h("Visual",       s:invt) " Visual
call s:h("IncSearch",    s:invt) " Search Result
call s:h("Todo",         s:todo) " TODO
" Title     " ?
" Search    " ?
" Directory " ?
call s:h("UnderLined",   s:test) " http://google.com

"http://google.com

" Message
call s:h("ModeMsg",      s:stg2) " -- INSERT --
"call s:h("Question",     s:test) " ?
"call s:h("MoreMsg",      s:acnt) " ?
"call s:h("WarningMsg",   s:test) " ?
call s:h("ErrorMsg",     s:invt) " Errpr
"call s:h("Tooltip",      s:test) " ?

" Frame
call s:h("VertSplit",    s:weak) " Vertical Line
call s:h("LineNr",       s:outf) " Number
call s:h("NonText",      s:outf) " after text
call s:h("StatusLine",   s:stln) " Status Line
call s:h("StatusLineNC", s:outf) " Status Line (unselected)

" Fortran
call s:h("fortranUnitHeader", s:stg1) " profram/contains/function/..

" LaTeX
call s:h("texStatement",  s:stg2) " \begin~, \renew~,...
call s:h("texSection",    s:stg1) " \sectioon
call s:h("texMathZoneE",  s:acnt) " equation ,align:AS
call s:h("texMathZoneD",  s:acnt) " eqnarray:D
call s:h("texMathZoneDS", s:acnt) " eqnarray*:DS
"call s:h("texMathSymbol", s:acnt) " \prod

"http://vimhelp.appspot.com/syntax.txt.html
"https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg

"------------------------------------------------------------------------
"  AUTO RELOAD .vimrc
"------------------------------------------------------------------------
augroup reloadrc
	" clean autogroup
	autocmd!
	autocmd VimEnter * source $MYVIMRC
	" always @ write "*vimrc"
	autocmd BufWritePost *vimrc source $MYVIMRC "| set foldmethod=markar
augroup end



