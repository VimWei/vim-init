function! date#time#IsTimeInRange(start_time, end_time) abort
    " Return 1 if current time is within [start_time, end_time] over 24h, inclusive.
    " Examples:
    "   date#time#IsTimeInRange('21:00', '06:30')  " wraps over midnight
    "   date#time#IsTimeInRange('09:00', '17:30')  " normal range

    let l:start_min = s:ParseTimeToMinutes(a:start_time)
    let l:end_min   = s:ParseTimeToMinutes(a:end_time)

    if l:start_min < 0 || l:end_min < 0
        return 0
    endif

    let l:now_min = s:ParseTimeToMinutes(strftime('%H:%M'))

    if l:start_min == l:end_min
        " Degenerate interval: only true exactly at that minute
        return l:now_min == l:start_min
    endif

    if l:start_min < l:end_min
        " Non-wrapping interval: [start, end]
        return (l:now_min >= l:start_min && l:now_min <= l:end_min) ? 1 : 0
    else
        " Wrapping interval across midnight: [start, 24h) U [0, end]
        return (l:now_min >= l:start_min || l:now_min <= l:end_min) ? 1 : 0
    endif
endfunction

function! s:ParseTimeToMinutes(time_str) abort
    " Parse a time string like '21:00' or '6:30' into minutes since midnight.
    let l:parts = split(a:time_str, ':')
    if len(l:parts) == 0
        return -1
    endif

    let l:hour_str = get(l:parts, 0, '')
    let l:min_str  = get(l:parts, 1, '0')

    if l:hour_str == ''
        return -1
    endif

    let l:hour = str2nr(l:hour_str)
    let l:minute = str2nr(l:min_str)

    if l:hour < 0 || l:hour > 23 || l:minute < 0 || l:minute > 59
        return -1
    endif

    return l:hour * 60 + l:minute
endfunction