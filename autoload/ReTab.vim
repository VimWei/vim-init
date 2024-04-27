" Tab与空格互换

function! ReTab#Tab2Space()
    set ts=4
    set expandtab
    %retab!
endfunc
function! ReTab#Space2Tab()
    set ts=4
    set noexpandtab
    %retab!
endfunc
