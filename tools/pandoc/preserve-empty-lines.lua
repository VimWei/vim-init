-- preserve-empty-lines.lua
function Para(el)
  if #el.content == 1 and el.content[1].t == "Str" and el.content[1].text == "THISIS__EMPTYLINE" then
    return pandoc.Para({pandoc.Str(" ")})  -- 注意这里是全角空格或 Unicode 空格
  end
end