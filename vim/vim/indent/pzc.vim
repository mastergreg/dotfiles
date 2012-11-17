" Vim indent file
" Language:    pazcal
" Maintainers: Vasilis Gerakaris   <vgerak@gmail.com>
"              Gregory Liras       <gregliras@gmail.com>
" Last Change: 7 Oct 2012

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" PZC indenting is C indenting which i built-in, thus this is very simple
setlocal smartindent cinwords=if,else,switch,FOR,while,do
setlocal smartindent

let b:undo_indent = "setl cin<"
