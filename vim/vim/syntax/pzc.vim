" Vim syntax file
" Language:	    pazcal
" Maintainers:	Vasilis Gerakaris   <vgerak@gmail.com>
"               Gregory Liras       <gregliras@gmail.com>
" Last Change:	7 Oct 2012
" Filenames:	*.pzc
" Version:	    1.2
"

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword pazcalStatement	break continue NEXT default
syn keyword pazcalStatement	return
syn keyword pazcalStatement	false true
syn keyword pazcalStatement	typedef
syn keyword pazcalStatement	extern PRIVATE const
syn keyword pazcalStatement	PROGRAM PROC FUNC nextgroup=pazcalFunction skipwhite
syn keyword pazcalType      int bool char REAL enum struct union unsigned long
syn match   pazcalFunction	"\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
syn keyword pazcalFunction	WRITE WRITELN WRITESP WRITESPLN READ_INT READ_REAL SKIP_LINE MIN MAX
syn keyword pazcalRepeat	FOR while do
syn keyword pazcalRepeat	TO DOWNTO STEP
syn keyword pazcalConditional	if else switch case
syn keyword pazcalOperator	->

" Comments
syn match   pazcalCommentDelim          contained "/\*\|\*/"
syn match   pazcalCommentSkip           contained "^\s*\*\($\|\s\+\)"
syn cluster pazcalCommentStringContents contains=pazcalCommentSkip,pazcalCharacterNoError,@pazcalSpecialCharNoError
syn region  pazcalCommentString         contained start=+L\="+ skip=+\\"+ end=+"+ end=+\*\(\\\s*\n\s*\)*\/+me=s-1 contains=@pazcalCommentStringContents
syn region  pazcalComment               keepend matchgroup=pazcalCommentDelim start="/\*" end="\*/" contains=pazcalCommentString,@Spell
syn match   pazcalComment	            "//.*$" display contains=pazcalTodo,@Spell

syn match   pazcalRun		"\%^#!.*$"
syn match   pazcalCoding	"\%^.*\%(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$"
syn keyword pazcalTodo		TODO FIXME XXX contained

" Errors
syn keyword pazcalError     for
syn match   pazcalError		"\<\d\+\D\+\>" display
syn match   pazcalError		"[$]" display
syn match   pazcalError		"[&|=]\{3,}" display

" Strings
"syn region pazcalString		start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pazcalEscape,pazcalEscapeError,@Spell
syn region pazcalString		start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pazcalEscape,pazcalEscapeError,@Spell
"syn region pazcalString		start=+'''+ end=+'''+ keepend contains=pazcalEscape,pazcalEscapeError,pazcalDocTest,pazcalSpaceError,@Spell

syn match  pazcalEscape		    +\\[abfnrtv'"\\]+ display contained
syn match  pazcalEscape		    "\\\o\o\=\o\=" display contained
syn match  pazcalEscapeError	"\\\o\{,2}[89]" display contained
syn match  pazcalEscape		    "\\x\x\{2}" display contained
syn match  pazcalEscapeError	"\\x\x\=\X" display contained
syn match  pazcalEscape		    "\\$"
syn match  pazcalEscape         "\\u\x\{4}" display contained
syn match  pazcalEscapeError	"\\u\x\{,3}\X" display contained
syn match  pazcalEscape	        "\\U\x\{8}" display contained
syn match  pazcalEscapeError	"\\U\x\{,7}\X" display contained
syn match  pazcalEscape	        "\\N{[A-Z ]\+}" display contained
syn match  pazcalEscapeError	"\\N{[^A-Z ]\+}" display contained

" Raw strings
"syn region pazcalRawString	start=+[bB]\=[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pazcalRawEscape,@Spell
syn region pazcalRawString	start=+[bB]\=[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pazcalRawEscape,@Spell
"syn region pazcalRawString	start=+[bB]\=[rR]"""+ end=+"""+ keepend contains=pazcalDocTest2,pazcalSpaceError,@Spell
"syn region pazcalRawString	start=+[bB]\=[rR]'''+ end=+'''+ keepend contains=pazcalDocTest,pazcalSpaceError,@Spell

syn match pazcalRawEscape	+\\['"]+ display transparent contained

" Bytes
syn region pazcalBytes		start=+[bB]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pazcalBytesError,pazcalBytesContent,@Spell
"syn region pazcalBytes		start=+[bB]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pazcalBytesError,pazcalBytesContent,@Spell
"syn region pazcalBytes		start=+[bB]"""+ end=+"""+ keepend contains=pazcalBytesError,pazcalBytesContent,pazcalDocTest2,pazcalSpaceError,@Spell
"syn region pazcalBytes		start=+[bB]'''+ end=+'''+ keepend contains=pazcalBytesError,pazcalBytesContent,pazcalDocTest,pazcalSpaceError,@Spell

syn match pazcalBytesError    ".\+" display contained
syn match pazcalBytesContent    "[\u0000-\u00ff]\+" display contained contains=pazcalBytesEscape,pazcalBytesEscapeError

syn match pazcalBytesEscape	    +\\[abfnrtv'"\\]+ display contained
syn match pazcalBytesEscape	    "\\\o\o\=\o\=" display contained
syn match pazcalBytesEscapeError	"\\\o\{,2}[89]" display contained
syn match pazcalBytesEscape	    "\\x\x\{2}" display contained
syn match pazcalBytesEscapeError	"\\x\x\=\X" display contained
syn match pazcalBytesEscape	    "\\$"

" Numbers (ints, longs, floats, complex)
syn match   pazcalHexError	"\<0[xX]\x*[g-zG-Z]\x*\>" display

syn match   pazcalHexNumber	"\<0[xX]\x\+\>" display
syn match   pazcalOctNumber "\<0[oO]\o\+\>" display
syn match   pazcalBinNumber "\<0[bB][01]\+\>" display

syn match   pazcalNumberError	"\<\d\+\D\>" display
syn match   pazcalNumberError	"\<0\d\+\>" display
syn match   pazcalNumber	"\<\d\>" display
syn match   pazcalNumber	"\<[1-9]\d\+\>" display
syn match   pazcalNumber	"\<\d\+[jJ]\>" display

syn match   pazcalFloat		"\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match   pazcalFloat		"\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
syn match   pazcalFloat		"\<\d\+\.\d*\%([eE][+-]\=\d\+\)\=[jJ]\=" display

syn match   pazcalOctError	"\<0[oO]\=\o*[8-9]\d*\>" display
syn match   pazcalBinError	"\<0[bB][01]*[2-9]\d*\>" display

  hi def link pazcalStatement	Statement
  hi def link pazcalFunction	Function
  hi def link pazcalConditional	Conditional
  hi def link pazcalRepeat		Repeat
  hi def link pazcalOperator	Operator
  hi def link pazcalType	    Type

  hi def link pazcalComment		Comment
  hi def link pazcalCommentString	Comment
  hi def link pazcalCommentSkip		Comment
  hi def link pazcalCommentDelim    Comment

  hi def link pazcalCoding		Special
  hi def link pazcalRun		    Special
  hi def link pazcalTodo		Todo

  hi def link pazcalError		Error
  hi def link pazcalIndentError	Error
  hi def link pazcalSpaceError	Error

  hi def link pazcalString		String
  hi def link pazcalRawString	String
  hi def link pazcalEscape		Special
  hi def link pazcalEscapeError	Error

  hi def link pazcalBytes		        String
  hi def link pazcalBytesContent	    String
  hi def link pazcalBytesError	        Error
  hi def link pazcalBytesEscape		    Special
  hi def link pazcalBytesEscapeError	Error

  hi def link pazcalStrFormatting	Special
  hi def link pazcalStrFormat    	Special
  hi def link pazcalStrTemplate	    Special

  hi def link pazcalDocTest		Special
  hi def link pazcalDocTest2	Special

  hi def link pazcalNumber		Number
  hi def link pazcalHexNumber	Number
  hi def link pazcalOctNumber	Number
  hi def link pazcalBinNumber	Number
  hi def link pazcalFloat		Float

  hi def link pazcalNumberError Error
  hi def link pazcalOctError	Error
  hi def link pazcalHexError	Error
  hi def link pazcalBinError	Error

  hi def link pazcalBuiltinObj	Structure
  hi def link pazcalBuiltinFunc	Function

  hi def link pazcalExClass	    Structure

let b:current_syntax = "pzc"
