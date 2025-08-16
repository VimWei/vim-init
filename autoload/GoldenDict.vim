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

    " Clean word: remove extra spaces and symbols at both ends
    let word = substitute(word, '\_s\+', ' ', 'g')
    let word = substitute(word, '^\W*\(.\{-}\)\W*$', '\1', '')

    if word == ""
        echohl ErrorMsg | echo "No content available for lookup" | echohl None
        return
    endif

    " Prepare system command
    let cmd = ""
    if has("win32") || has("win64")
        " Try common GoldenDict installation locations
        let possible_paths = [
            \ 'd:\PortableApps\PortableApps\GoldenDict\GoldenDict.exe',
            \ 'C:\Apps\GoldenDict\GoldenDict.exe',
            \ 'C:\Program Files\GoldenDict\GoldenDict.exe',
            \ 'C:\Program Files (x86)\GoldenDict\GoldenDict.exe'
            \ ]
        
        let gd_path = ""
        try
            for path in possible_paths
                if filereadable(path)
                    let gd_path = path
                    break
                endif
            endfor
        catch /.*/
            " If path detection fails, gd_path remains empty
        endtry
        
        if gd_path == ""
            echohl ErrorMsg | echo "GoldenDict not found in default installation locations" | echohl None
            return
        endif
        
        let cmd = 'start /B "" "' . gd_path . '" "' . word . '"'
    elseif has("mac")
        let cmd = 'open -a GoldenDict --args "' . word . '"'
    else
        let cmd = 'goldendict "' . word . '" &'
    endif

    " Execute command (asynchronous)
    silent! call system(cmd)
    echo "Looking up: " . word
endfunction