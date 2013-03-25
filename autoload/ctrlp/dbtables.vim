if exists('g:loaded_ctrlp_dbtables') && g:loaded_ctrlp_dbtables
  finish
endif
let g:loaded_ctrlp_dbtables = 1

let s:dbtables_var = {
\  'init':   'ctrlp#dbtables#init()',
\  'accept': 'ctrlp#dbtables#accept',
\  'exit':   'ctrlp#dbtables#exit()',
\  'lname':  'dbtables',
\  'sname':  'dbtables',
\  'type':   'dbtables',
\  'sort':   0,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:dbtables_var)
else
  let g:ctrlp_ext_vars = [s:dbtables_var]
endif

function! ctrlp#dbtables#init()
  let s = system(g:dbtables_dbcommand . " --batch -e 'show tables'")
  return split(s, "\n")[1:]
endfunc

function! ctrlp#dbtables#accept(mode, str)
  call ctrlp#exit()
  call dbtables#describe(a:str)
endfunction

function! ctrlp#dbtables#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#dbtables#id()
  return s:id
endfunction
