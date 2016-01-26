# Hacked together first version

* Requires ctrlp or FZF for the list function

You will need the following maps:

```VimL
" Describe the table under the cursor
nmap <Leader>dt :call dbtables#describe('')<CR>

" Bring up a select list of tables to describe

nmap <Leader>dtt :CtrlPDbTables<CR>

or 

nmap <Leader>dtt :FZFDbTables<CR>

" Assuming no password
let g:dbtables_dbcommand='mysql -uuser Database'
```

## Credit
* Sidebar stuff from vimpipe
* Used cowsys/ctrlp-vimref as a template for ctrlp integration
