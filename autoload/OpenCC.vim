" OpenCC 1.0.5 Windows 32/64版
"
" 1. 将OpenCC加入系统path:高级系统设置/高级/环境变量/path/编辑/新建/浏览/确定
" 2. 打开或切换窗口到拟处理的文件, 使用如下OpenCC...命令转换格式，并输出文件到CWD中
"
" 繁体（台湾正体标准）到简体并转换为中国大陆常用词汇
" command! -range OpenCCTW2SP <line1>,<line2>call OpenCC#OpenCC("tw2sp.json")<CR>
" 简体到繁体（台湾正体标准）并转换为台湾常用词汇
" command! -range OpenCCS2TWP <line1>,<line2>call OpenCC#OpenCC("s2twp.json")<CR>
"
" Usage: opencc.exe [--noflush ] [-i ] [-o ] [-c ] [--] [--version] [-h]
"
" OpenCC 支持以下几种转换：
" s2t.json Simplified Chinese to Traditional Chinese 简体到繁体
" t2s.json Traditional Chinese to Simplified Chinese 繁体到简体
" s2tw.json Simplified Chinese to Traditional Chinese (Taiwan Standard) 简体到台湾正体
" tw2s.json Traditional Chinese (Taiwan Standard) to Simplified Chinese 台湾正体到简体
" s2hk.json Simplified Chinese to Traditional Chinese (Hong Kong Standard) 简体到香港繁体（香港小学学习字词表标准）
" hk2s.json Traditional Chinese (Hong Kong Standard) to Simplified Chinese 香港繁体（香港小学学习字词表标准）到简体
" s2twp.json Simplified Chinese to Traditional Chinese (Taiwan Standard) with Taiwanese idiom 简体到繁体（台湾正体标准）并转换为台湾常用词汇
" tw2sp.json Traditional Chinese (Taiwan Standard) to Simplified Chinese with Mainland Chinese idiom 繁体（台湾正体标准）到简体并转换为中国大陆常用词汇
" t2tw.json Traditional Chinese (OpenCC Standard) to Taiwan Standard 繁体（OpenCC 标准）到台湾正体
" t2hk.json Traditional Chinese (OpenCC Standard) to Hong Kong Standard 繁体（OpenCC 标准）到香港繁体（香港小学学习字词表标准）

function! OpenCC#OpenCC(configuration) range abort
    " 将当前目录改变为当前文件所在的目录
    silent!exe "cd %:h"
    "Input和Output文件名应避免使用空格，否则无法运行
    let l:OpenCCInput = "OpenCC.Temp.Input." . strftime("%Y%m%d.%H%M%S") . "." . expand('%:e')
    silent!exe a:firstline . "," . a:lastline . "w! >> " . OpenCCInput
    let l:OpenCCOutput = "OpenCC.Temp.Output." . strftime("%Y%m%d.%H%M%S") . "." . expand('%:e')
    let l:OpenCCConfig = escape('c:\Apps\opencc-1.0.5-win64\', '\') . a:configuration
    silent!exe "!OpenCC --input " . OpenCCInput . " --output " . OpenCCOutput . " --config " . OpenCCConfig
    silent!exe a:firstline . "," . a:lastline . "d"
    silent!exe a:firstline-1"r " . OpenCCOutput
    "删除临时文件
    silent!exe "!del " . OpenCCInput . " " . OpenCCOutput
    echomsg "已使用OpenCC转换简繁体"
endfunction
