if exists(':SpeedDatingFormat') == 2
    " 支持“会议预定”中的特定日期格式
    :10SpeedDatingFormat %Y%m%d%a%H:%M

    " 支持“会议纪要”中的特定日期格式
    :11SpeedDatingFormat %Y-%m-%d %A %H:%M:%S

    " 支持“GTD”中的特定日期格式
    :12SpeedDatingFormat %Y-%m-%d %A

    " 支持“周膳计划”中的特定日期格式
    :13SpeedDatingFormat %a %Y-%m-%d

    " 调整默认 ISO 格式的优先级（默认10）
    :14SpeedDatingFormat %Y-%m-%d

    " 斜杠分隔格式
    :15SpeedDatingFormat %Y/%m/%d

    " 中文日期格式
    :16SpeedDatingFormat %Y年%m月%d日

    " 点分隔格式
    :17SpeedDatingFormat %Y.%m.%d
endif
