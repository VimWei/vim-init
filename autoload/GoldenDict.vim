" GoldenDict.vim
" Lookup current word/selection and send to GoldenDict
function! GoldenDict#Lookup(mode)
    " Backup registers
    let save_reg = @"
    let save_reg_type = getregtype('"')
    let word = ""

    if a:mode == 'v'
        " Visual mode handling
        silent normal! gvy
        let word = @"
        " Exit visual mode
        silent normal! \<Esc>
    else
        " Normal mode handling
        let word = expand("<cword>")
    endif

    " Restore registers
    call setreg('"', save_reg, save_reg_type)

    " Skip empty
    if empty(word)
        echohl ErrorMsg | echo "No content available for lookup" | echohl None
        return
    endif

    " Escape double quotes for command-line argument
    let word_escaped = substitute(word, '"', '""', 'g')

    " Find AutoHotkey v2 executable
    let ahk_path = ""
    let ahk_paths = [
        \ 'C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe',
        \ 'C:\Program Files\AutoHotkey\v2\AutoHotkey.exe',
        \ ]

    try
        for path in ahk_paths
            if filereadable(path)
                let ahk_path = path
                break
            endif
        endfor
    catch /.*/
    endtry

    if ahk_path == ""
        echohl ErrorMsg | echo "AutoHotkey v2 not found" | echohl None
        return
    endif

    " Locate VimReader's lookup bridge script
    let lookup_script = 'C:\Apps\VimReader\lib\GoldenDict\VimLookup.ahk'

    if !filereadable(lookup_script)
        echohl ErrorMsg | echo "VimLookup.ahk not found: " . lookup_script | echohl None
        return
    endif

    " Execute via AHK (asynchronous)
    let cmd = 'start /B "" "' . ahk_path . '" "' . lookup_script . '" "' . word_escaped . '"'
    silent! call system(cmd)
    echo "Looking up: " . word
endfunction
