if exists("b:current_syntax")
  finish
endif

" Comments
syntax match cafeobjComment /--.*/

" Module and view keywords
syntax keyword cafeobjKeyword mod! mod* view
syntax keyword cafeobjKeyword pr op ops bop var vars sort
syntax keyword cafeobjKeyword eq ceq red reduce open close
syntax keyword cafeobjKeyword principal constr if then else fi

" Boolean constants
syntax keyword cafeobjBoolean true false

" Strings
syntax region cafeobjString start=/"/ skip=/\\"/ end=/"/

" Numbers
syntax match cafeobjNumber /\<\d\+\>/

" Common operators and punctuation
syntax match cafeobjOperator /->/
syntax match cafeobjOperator /<=/
syntax match cafeobjOperator /[=|{}(),.]/

" Highlight links
highlight default link cafeobjComment Comment
highlight default link cafeobjKeyword Statement
highlight default link cafeobjBoolean Boolean
highlight default link cafeobjString String
highlight default link cafeobjNumber Number
highlight default link cafeobjOperator Operator

let b:current_syntax = "cafeobj"
