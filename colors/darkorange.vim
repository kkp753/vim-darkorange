" File:       darkorange.vim
" Author:     kkp753
" URL:        https://github.com/kkp753/vim-darkorange
" References: http://vimhelp.appspot.com/syntax.txt.html
"             https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg

" [scope]
" l: function local        ... Default in the function
" g: global                ... Default in the other part
" a: argument
" s: script file local (?)

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


