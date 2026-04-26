" 清理 Gemini 生成的 Markdown 文档格式

let s:items = [
    \ {'label': 'Delete lines starting with ---', 'cmd': 'g/^---/d', 'enabled': 1},
    \ {'label': 'Convert ### to ##', 'cmd': '%s/###/##/g', 'enabled': 1},
    \ {'label': 'Add empty line after ## headings', 'cmd': '', 'enabled': 1},
    \ {'label': 'Remove leading 2 spaces', 'cmd': '%s/^  //g', 'enabled': 1},
    \ {'label': 'Fix Chinese colon spacing', 'cmd': '%s/： /：/g', 'enabled': 1},
    \ {'label': 'Remove all text style (requires markdown)', 'cmd': '', 'enabled': 1},
\ ]

" 执行顺序: 按界面显示顺序 1→2→3→4→5→6
let s:exec_order = [0, 1, 2, 3, 4, 5]

function! LLMClean#Run()
    let items = deepcopy(s:items)
    while 1
        let choices = []
        call add(choices, 'Select LLMClean operations:')
        for i in range(len(items))
            let mark = items[i].enabled ? '[x]' : '[ ]'
            call add(choices, printf('%d. %s %s', i+1, mark, items[i].label))
        endfor
        call add(choices, printf('%d. [Execute selected operations]', len(items)+1))
        call add(choices, 'Type number and press Enter (0 to cancel):')
        
        let choice = inputlist(choices)
        
        if choice == 0
            echo 'Cancelled.'
            return
        elseif choice >= 1 && choice <= len(items)
            let items[choice-1].enabled = !items[choice-1].enabled
        elseif choice == len(items) + 1
            call s:ExecuteItems(items)
            return
        else
            echo 'Invalid choice.'
        endif
    endwhile
endfunction

function! s:ExecuteItems(items)
    let executed = 0
    for idx in s:exec_order
        if !a:items[idx].enabled
            continue
        endif
        
        if idx == 5
            " Special handling: Remove all text style (requires markdown)
            if &filetype != 'markdown'
                " Silently skip if not markdown
                continue
            endif
            " Execute: select all then apply <Plug>MarkdownRemoveAll
            silent! execute 'normal! ggVG'
            call feedkeys("\<Plug>MarkdownRemoveAll", 'x')
            let executed += 1
        elseif idx == 2
            " Special handling: Add empty line after ## headings
            call s:AddEmptyLineAfterH2()
            let executed += 1
        else
            " Standard command execution
            silent! execute a:items[idx].cmd
            let executed += 1
        endif
    endfor
    
    if executed == 0
        echo 'No operation selected.'
    else
        echo printf('LLMClean: %d operation(s) executed.', executed)
    endif
endfunction

function! s:AddEmptyLineAfterH2()
    let lnum = line('$')
    while lnum >= 1
        if getline(lnum) =~ '^## '
            let nextline = getline(lnum + 1)
            if nextline !~ '^$'
                call append(lnum, '')
            endif
        endif
        let lnum -= 1
    endwhile
endfunction
