" Vim syntax file
" Language:     llama
" Filenames:    *.ll

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" ll is case sensitive.
syn case match

" lowercase identifier - the standard way to match
syn match    llLCIdentifier /\<\(\l\|_\)\(\w\|'\)*\>/

syn match    llKeyChar    "|"

" Errors
syn match    llBraceErr   "}"
syn match    llBrackErr   "\]"
syn match    llParenErr   ")"
syn match    llCommentErr "\*)"
syn match    llThenErr    "\<then\>"

" Error-highlighting of "end" without synchronization:
" as keyword or as error (default)
if exists("ll_noend_error")
  syn match    llKeyword    "\<end\>"
else
  syn match    llEndErr     "\<end\>"
endif

" Some convenient clusters
syn cluster  llAllErrs contains=llBraceErr,llBrackErr,llParenErr,llCommentErr,llEndErr,llThenErr

syn cluster  llAENoParen contains=llBraceErr,llBrackErr,llCommentErr,llEndErr,llThenErr

syn cluster  llContained contains=llTodo,llPreDef,llModParam,llModParam1,llPreMPRestr,llMPRestr,llMPRestr1,llMPRestr2,llMPRestr3,llModRHS,llFuncWith,llFuncStruct,llModTypeRestr,llModTRWith,llWith,llWithRest,llModType,llFullMod


" Enclosing delimiters
syn region   llEncl transparent matchgroup=llKeyword start="(" matchgroup=llKeyword end=")" contains=ALLBUT,@llContained,llParenErr
syn region   llEncl transparent matchgroup=llKeyword start="{" matchgroup=llKeyword end="}"  contains=ALLBUT,@llContained,llBraceErr
syn region   llEncl transparent matchgroup=llKeyword start="\[" matchgroup=llKeyword end="\]" contains=ALLBUT,@llContained,llBrackErr
syn region   llEncl transparent matchgroup=llKeyword start="#\[" matchgroup=llKeyword end="\]" contains=ALLBUT,@llContained,llBrackErr


" Comments
syn region   llComment start="(\*" end="\*)" contains=llComment,llTodo
syn region   llComment start="--" end='\n' contains=llComment,llTodo
syn keyword  llTodo contained TODO FIXME XXX


" let
syn region   llEnd matchgroup=llKeyword start="\<let\>" matchgroup=llKeyword end="\<end\>" contains=ALLBUT,@llContained,llEndErr

" local
syn region   llEnd matchgroup=llKeyword start="\<local\>" matchgroup=llKeyword end="\<end\>" contains=ALLBUT,@llContained,llEndErr

" abstype
syn region   llNone matchgroup=llKeyword start="\<abstype\>" matchgroup=llKeyword end="\<end\>" contains=ALLBUT,@llContained,llEndErr

" begin
syn region   llEnd matchgroup=llKeyword start="\<begin\>" matchgroup=llKeyword end="\<end\>" contains=ALLBUT,@llContained,llEndErr

" if
syn region   llNone matchgroup=llKeyword start="\<if\>" matchgroup=llKeyword end="\<then\>" contains=ALLBUT,@llContained,llThenErr


"" Modules

" "struct"
syn region   llStruct matchgroup=llModule start="\<struct\>" matchgroup=llModule end="\<end\>" contains=ALLBUT,@llContained,llEndErr

" "sig"
syn region   llSig matchgroup=llModule start="\<sig\>" matchgroup=llModule end="\<end\>" contains=ALLBUT,@llContained,llEndErr,llModule
syn region   llModSpec matchgroup=llKeyword start="\<structure\>" matchgroup=llModule end="\<\u\(\w\|'\)*\>" contained contains=@llAllErrs,llComment skipwhite skipempty nextgroup=llModTRWith,llMPRestr

" "open"
syn region   llNone matchgroup=llKeyword start="\<open\>" matchgroup=llModule end="\<\u\(\w\|'\)*\(\.\u\(\w\|'\)*\)*\>" contains=@llAllErrs,llComment

" "structure" - somewhat complicated stuff ;-)
syn region   llModule matchgroup=llKeyword start="\<\(structure\|functor\)\>" matchgroup=llModule end="\<\u\(\w\|'\)*\>" contains=@llAllErrs,llComment skipwhite skipempty nextgroup=llPreDef
syn region   llPreDef start="."me=e-1 matchgroup=llKeyword end="\l\|="me=e-1 contained contains=@llAllErrs,llComment,llModParam,llModTypeRestr,llModTRWith nextgroup=llModPreRHS
syn region   llModParam start="([^*]" end=")" contained contains=@llAENoParen,llModParam1
syn match    llModParam1 "\<\u\(\w\|'\)*\>" contained skipwhite skipempty nextgroup=llPreMPRestr

syn region   llPreMPRestr start="."me=e-1 end=")"me=e-1 contained contains=@llAllErrs,llComment,llMPRestr,llModTypeRestr

syn region   llMPRestr start=":" end="."me=e-1 contained contains=@llComment skipwhite skipempty nextgroup=llMPRestr1,llMPRestr2,llMPRestr3
syn region   llMPRestr1 matchgroup=llModule start="\ssig\s\=" matchgroup=llModule end="\<end\>" contained contains=ALLBUT,@llContained,llEndErr,llModule
syn region   llMPRestr2 start="\sfunctor\(\s\|(\)\="me=e-1 matchgroup=llKeyword end="->" contained contains=@llAllErrs,llComment,llModParam skipwhite skipempty nextgroup=llFuncWith
syn match    llMPRestr3 "\w\(\w\|'\)*\(\.\w\(\w\|'\)*\)*" contained
syn match    llModPreRHS "=" contained skipwhite skipempty nextgroup=llModParam,llFullMod
syn region   llModRHS start="." end=".\w\|([^*]"me=e-2 contained contains=llComment skipwhite skipempty nextgroup=llModParam,llFullMod
syn match    llFullMod "\<\u\(\w\|'\)*\(\.\u\(\w\|'\)*\)*" contained skipwhite skipempty nextgroup=llFuncWith

syn region   llFuncWith start="([^*]"me=e-1 end=")" contained contains=llComment,llWith,llFuncStruct
syn region   llFuncStruct matchgroup=llModule start="[^a-zA-Z]struct\>"hs=s+1 matchgroup=llModule end="\<end\>" contains=ALLBUT,@llContained,llEndErr

syn match    llModTypeRestr "\<\w\(\w\|'\)*\(\.\w\(\w\|'\)*\)*\>" contained
syn region   llModTRWith start=":\s*("hs=s+1 end=")" contained contains=@llAENoParen,llWith
syn match    llWith "\<\(\u\(\w\|'\)*\.\)*\w\(\w\|'\)*\>" contained skipwhite skipempty nextgroup=llWithRest
syn region   llWithRest start="[^)]" end=")"me=e-1 contained contains=ALLBUT,@llContained

" "signature"
syn region   llKeyword start="\<signature\>" matchgroup=llModule end="\<\w\(\w\|'\)*\>" contains=llComment skipwhite skipempty nextgroup=llMTDef
syn match    llMTDef "=\s*\w\(\w\|'\)*\>"hs=s+1,me=s

syn keyword  llKeyword  and 
syn keyword  llKeyword  datatype else eqtype
syn keyword  llKeyword  delete dim do done downto
syn keyword  llKeyword  in match mod new
syn keyword  llKeyword  raise handle type
syn keyword  llKeyword  rec val where while with

syn keyword  llType     bool char int mutable
syn keyword  llType     float unit

syn keyword  llOperator div mod not or of then to

syn keyword  llBoolean      true false
syn match    llConstructor  "(\s*)"
syn match    llConstructor  "\[\s*\]"
syn match    llConstructor  "#\[\s*\]"
syn match    llConstructor  "\u\(\w\|'\)*\>"

" Module prefix
syn match    llModPath      "\u\(\w\|'\)*\."he=e-1

syn match    llCharacter    +#"\\""\|#"."\|#"\\\d\d\d"+
syn match    llCharErr      +#"\\\d\d"\|#"\\\d"+
syn region   llString       start=+"+ skip=+\\\\\|\\"+ end=+"+

syn match    llFunDef       "=>"
syn match    llRefAssign    ":="
syn match    llTopStop      ";;"
syn match    llOperator     "\^"
syn match    llOperator     "::"
syn match    llAnyVar       "\<_\>"
syn match    llKeyChar      "!"
syn match    llKeyChar      ";"
syn match    llKeyChar      "\*"
syn match    llKeyChar      "="

syn match    llNumber        "\<-\=\d\+\>"
syn match    llNumber        "\<-\=0[x|X]\x\+\>"
syn match    llReal          "\<-\=\d\+\.\d*\([eE][-+]\=\d\+\)\=[fl]\=\>"

" Synchronization
syn sync minlines=20
syn sync maxlines=500

syn sync match llEndSync     grouphere  llEnd     "\<begin\>"
syn sync match llEndSync     groupthere llEnd     "\<end\>"
syn sync match llStructSync  grouphere  llStruct  "\<struct\>"
syn sync match llStructSync  groupthere llStruct  "\<end\>"
syn sync match llSigSync     grouphere  llSig     "\<sig\>"
syn sync match llSigSync     groupthere llSig     "\<end\>"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_ll_syntax_inits")
  if version < 508
    let did_ll_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink llBraceErr     Error
  HiLink llBrackErr     Error
  HiLink llParenErr     Error

  HiLink llCommentErr   Error

  HiLink llEndErr       Error
  HiLink llThenErr      Error

  HiLink llCharErr      Error

  HiLink llComment      Comment

  HiLink llModPath      Include
  HiLink llModule       Include
  HiLink llModParam1    Include
  HiLink llModType      Include
  HiLink llMPRestr3     Include
  HiLink llFullMod      Include
  HiLink llModTypeRestr Include
  HiLink llWith         Include
  HiLink llMTDef        Include

  HiLink llConstructor  Constant

  HiLink llModPreRHS    Keyword
  HiLink llMPRestr2     Keyword
  HiLink llKeyword      Keyword
  HiLink llFunDef       Keyword
  HiLink llRefAssign    Keyword
  HiLink llKeyChar      Keyword
  HiLink llAnyVar       Keyword
  HiLink llTopStop      Keyword
  HiLink llOperator     Keyword

  HiLink llBoolean      Boolean
  HiLink llCharacter    Character
  HiLink llNumber       Number
  HiLink llReal         Float
  HiLink llString       String
  HiLink llType         Type
  HiLink llTodo         Todo
  HiLink llEncl         Keyword

  delcommand HiLink
endif

let b:current_syntax = "ll"

" vim: ts=8
