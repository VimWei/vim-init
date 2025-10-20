" Check if built-in strptime() function is available
let s:has_strptime = 0
if exists('*strptime')
  try
    let s:has_strptime = strptime('%Y-%m-%d', '2000-01-01') > 0
  catch
    let s:has_strptime = 0
  endtry
endif

" Universal strptime() function that works on all platforms
function! date#strptime#strptime(format, timestring) abort
  " Try to use built-in strptime() if available
  if s:has_strptime
    try
      return strptime(a:format, a:timestring)
    catch
      " Fall back to manual parsing if built-in fails
    endtry
  endif
  
  " Manual implementation for platforms without strptime()
  return s:strptime_manual(a:format, a:timestring)
endfunction

" Manual strptime implementation
function! s:strptime_manual(format, timestring) abort
  " Handle common formats
  if a:format ==# '%Y %b %d %X'
    " Format: "1997 Apr 27 11:49:23"
    let l:pattern = '^\(\d\{4\}\) \(\w\{3\}\) \(\d\{1,2\}\) \(\d\{1,2\}\):\(\d\{2\}\):\(\d\{2\}\)$'
    let l:match = matchlist(a:timestring, l:pattern)
    if empty(l:match)
      return 0
    endif
    
    let l:year = str2nr(l:match[1])
    let l:month_name = l:match[2]
    let l:day = str2nr(l:match[3])
    let l:hour = str2nr(l:match[4])
    let l:minute = str2nr(l:match[5])
    let l:second = str2nr(l:match[6])
    
    " Convert month name to number
    let l:month_names = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                        \ 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    let l:month = index(l:month_names, l:month_name) + 1
    if l:month == 0
      return 0
    endif
    
    return s:datetime_to_timestamp(l:year, l:month, l:day, l:hour, l:minute, l:second)
    
  elseif a:format ==# '%Y-%m-%d'
    " Format: "2000-01-01"
    let l:pattern = '^\(\d\{4\}\)-\(\d\{1,2\}\)-\(\d\{1,2\}\)$'
    let l:match = matchlist(a:timestring, l:pattern)
    if empty(l:match)
      return 0
    endif
    
    let l:year = str2nr(l:match[1])
    let l:month = str2nr(l:match[2])
    let l:day = str2nr(l:match[3])
    
    return s:datetime_to_timestamp(l:year, l:month, l:day, 0, 0, 0)
    
  elseif a:format ==# '%Y-%m-%d %H:%M:%S'
    " Format: "2000-01-01 12:30:45"
    let l:pattern = '^\(\d\{4\}\)-\(\d\{1,2\}\)-\(\d\{1,2\}\) \(\d\{1,2\}\):\(\d\{2\}\):\(\d\{2\}\)$'
    let l:match = matchlist(a:timestring, l:pattern)
    if empty(l:match)
      return 0
    endif
    
    let l:year = str2nr(l:match[1])
    let l:month = str2nr(l:match[2])
    let l:day = str2nr(l:match[3])
    let l:hour = str2nr(l:match[4])
    let l:minute = str2nr(l:match[5])
    let l:second = str2nr(l:match[6])
    
    return s:datetime_to_timestamp(l:year, l:month, l:day, l:hour, l:minute, l:second)
    
  else
    " Unsupported format
    return 0
  endif
endfunction

" Convert datetime components to Unix timestamp
function! s:datetime_to_timestamp(year, month, day, hour, minute, second) abort
  " More accurate timestamp calculation
  
  " Days since epoch (1970-01-01)
  let l:days_since_epoch = 0
  
  " Add years with proper leap year calculation
  let l:year_diff = a:year - 1970
  let l:days_since_epoch += l:year_diff * 365
  
  " Add leap years (more accurate)
  for l:y in range(1970, a:year - 1)
    if l:y % 4 == 0 && (l:y % 100 != 0 || l:y % 400 == 0)
      let l:days_since_epoch += 1
    endif
  endfor
  
  " Add months
  let l:month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  if a:year % 4 == 0 && (a:year % 100 != 0 || a:year % 400 == 0)
    let l:month_days[1] = 29  " February in leap year
  endif
  
  let l:month_index = a:month - 1
  for l:i in range(l:month_index)
    let l:days_since_epoch += l:month_days[l:i]
  endfor
  
  " Add days
  let l:days_since_epoch += a:day - 1
  
  " Convert to seconds and add time components
  let l:timestamp = l:days_since_epoch * 86400 + a:hour * 3600 + a:minute * 60 + a:second
  
  return l:timestamp
endfunction

" Convenience functions for common date formats
function! date#strptime#iso_date(timestring) abort
  " Parse ISO date format: "2000-01-01"
  return date#strptime#strptime('%Y-%m-%d', a:timestring)
endfunction

function! date#strptime#datetime(timestring) abort
  " Parse datetime format: "2000-01-01 12:30:45"
  return date#strptime#strptime('%Y-%m-%d %H:%M:%S', a:timestring)
endfunction

function! date#strptime#help_format(timestring) abort
  " Parse the format from Vim help: "1997 Apr 27 11:49:23"
  return date#strptime#strptime('%Y %b %d %X', a:timestring)
endfunction

