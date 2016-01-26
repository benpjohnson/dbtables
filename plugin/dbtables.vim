command! CtrlPDbTables cal ctrlp#init(ctrlp#dbtables#id())
" nmap <Leader>dt  :call dbtables#describe('')<CR>
" nmap <Leader>dtt :CtrlPDbTables<CR>

" TODO: Add select top X rows as a task

" FIXME: duplicate detection broken. Apply on a per table level
" CREDIT: Largly nicked from vimpipe!
" FIXME: add foreign keys
" FIXME: reuse buffer if open
" FIXME: error handling
" FIXME split this into describe / describeword
" TODO:  
function! dbtables#describe(table)
    " use the word at the cursor if no parameter passed
    if len(a:table) == 0
        let table = expand("<cword>")
    else
        let table = a:table
    endif

    let bufname = "[Describe]"

    " Split & open.
    silent execute "vert new " . bufname

    let describebuffer = bufnr(bufname, 1)
    call setbufvar(describebuffer, "&swapfile", 0)
    call setbufvar(describebuffer, "&buftype", "nofile")
    call setbufvar(describebuffer, "&bufhidden", "wipe")
    call setbufvar(describebuffer, "&bufhidden", "nowrap")
    execute ":setlocal nowrap"

    let sql = "SELECT DISTINCT column_name, column_type, column_comment FROM information_schema.columns WHERE table_name = \"" . table . "\""
    call dbtables#runSqlInBuffer(sql)

    let sql = "SELECT * FROM `" . table . "` LIMIT 5;"
    call dbtables#runSqlInBuffer(sql)

    let sql = "SHOW INDEXES IN `" . table . "`;"
    call dbtables#runSqlInBuffer(sql)

    execute "normal gg"
endfunction

function! dbtables#dumpInserts(table)
    let command = g:dbtables_mysqldump " --no-create-info --skip-opt --compact --tables " . a:table
    execute ":sil r!" . command
endfunction


function! dbtables#runSqlInBuffer(sql)
    execute ":sil r!" . g:dbtables_dbcommand . " --table -e '" . a:sql . ";'"
endfunction
