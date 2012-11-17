" Vim filetype plugin file
" Language:	pazcal
" Maintainers:	Vasilis Gerakaris   <vgerak@gmail.com>
"               Gregory Liras       <gregliras@gmail.com>
" Last Change:	7 Oct 2012

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Using line continuation here.
let s:cpo_save = &cpo
set cpo-=C

let b:undo_ftplugin = "setl fo< com< ofu< | if has('vms') | setl isk< | endif"

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

" Set completion with CTRL-X CTRL-O to autoloaded function.
if exists('&ofu')
  setlocal ofu=ccomplete#Complete
endif

" Set 'comments' to format dashed lists in comments.
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://

" In VMS C keywords contain '$' characters.
if has("vms")
  setlocal iskeyword+=$
endif

" When the matchit plugin is loaded, this makes the % command skip parens and
" braces in comments.
let b:match_words = &matchpairs . ',^\s*#\s*if\(\|def\|ndef\)\>:^\s*#\s*elif\>:^\s*#\s*else\>:^\s*#\s*endif\>'
let b:match_skip = 's:comment\|string\|character'

" Win32 can filter files in the browse dialog
if (has("gui_win32") || has("gui_gtk")) && !exists("b:browsefilter")
  if &ft == "pzc"
    let b:browsefilter = "PZC Source Files (*.pzc *.pzh)\t*.pzc;*.pzh\n" .
	  \ "PZC Header Files (*.pzh)\t*.pzh\n" .
	  \ "PZC Source Files (*.pzc)\t*.pzc\n" .
	  \ "All Files (*.*)\t*.*\n"
  else
    let b:browsefilter = "PZC Source Files (*.pzc)\t*.pzc\n" .
	  \ "PZC Header Files (*.pzh)\t*.pzh\n" .
	  \ "PZC Source Files (*.pzc)\t*.pzc\n" .
	  \ "All Files (*.*)\t*.*\n"
  endif
endif

let &cpo = s:cpo_save
unlet s:cpo_save
