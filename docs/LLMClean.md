# LLMClean 命令设计方案

## 目标
增加一个 Vim 命令 `:LLMClean`，用于交互式清理由 AI 生成的 Markdown 文档格式。

## 作用范围
- **全文模式**：`:LLMClean` — 对整个文件执行清理操作
- **选区模式**：可视选择后执行 `:'<,'>LLMClean` — 仅对选中的内容执行清理操作
  - 选区范围会自动追踪：删除/插入行后，后续操作会在调整后的范围内执行

## 技术选型
- **交互方式**：`quickui#dialog#open()`（vim-quickui 的 Dialog 系统）
- **原因**：提供图形化复选框对话框，交互更直观，无需循环输入数字

## 交互流程
```
┌─ LLMClean ──────────────────────────────────────X┐
│                                                  │
│  [x] Delete lines starting with ---              │
│  [x] Promote H3+ headings by one level           │
│  [x] Add empty line after H2+ headings           │
│  [x] Remove all markdown text style              │
│  [x] Remove leading 2 spaces                     │
│  [x] Remove spaces after Chinese colon           │
│  [x] Remove redundant spaces after numbered list │
│  [x] Remove backslash in numbered lists          │
│                                                  │
│              < Execute >    < Cancel >           │
│                                                  │
└──────────────────────────────────────────────────┘
```

- 使用 `Space` 或鼠标点击切换对应操作的启用/禁用状态
- 点击 `< Execute >` 或按 `Enter`：执行所有标记为 `[x]` 的操作
- 点击 `< Cancel >` 或按 `ESC`：取消退出

## 执行顺序
按界面显示顺序依次执行：

1. 删除以 `---` 开头的行（全文或选区），使用从下往上遍历删除，确保范围追踪准确
2. `:%s/###/##/g` 或 `:'<,'>s/###/##/g` — 将 H3 及以下标题提升一级（H2 不受影响）
3. 在 H2 及以下标题行（`##` 到 `######`）之后添加一行空行（如果下一行非空），仅限指定范围，使用从下往上遍历插入
4. `gv<Plug>MarkdownRemoveAll`（选区）或 `ggVG<Plug>MarkdownRemoveAll`（全文） — 移除所有 Markdown 文本格式（粗体、斜体、删除线、行内代码等）。仅在 `filetype=markdown` 时执行，否则静默跳过
5. `:%s/^  //g` 或 `:'<,'>s/^  //g` — 删除行首的 2 个空格
6. `:%s/： /：/g` 或 `:'<,'>s/： /：/g` — 删除中文冒号后的空格
7. `:%s/\(\d\.\)\s\+/\1 /g` 或 `:'<,'>s/\(\d\.\)\s\+/\1 /g` — 清理有序列表序号后的多余空格，仅保留一个空格。
8. `:%s/\(\d\+\)\\\(\.\)/\1\2/g` 或 `:'<,'>s/\(\d\+\)\\\(\.\)/\1\2/g` — 去除序号中间的 `\`，例如 `1\.` 变为 `1.`。

## 文件变更

### 1. 新建 `autoload/LLMClean.vim`
实现核心逻辑：
- `LLMClean#Run()` — 主入口，显示 `quickui#dialog` 复选框对话框，支持 `-range` 属性
- `s:ExecuteItems(items, range, start_line, end_line)` — 按 `s:exec_order` 顺序执行选中的操作
  - 接收范围参数，动态追踪行变化（删除/插入行后调整范围）
  - 第1项特殊处理：使用 `s:DeleteLinesStartingWith()` 从下往上遍历删除，避免 `:g` 命令的范围漂移问题
  - 第3项特殊处理：使用 `s:AddEmptyLineAfterHeadings()` 从下往上遍历插入，避免插入行影响未处理行
  - 第4项特殊处理：检查 `&filetype == 'markdown'`，选区模式通过具体行号选中，全文模式通过 `normal! ggVG` 全选，后执行 `<Plug>MarkdownRemoveAll`，非 markdown 文件类型时静默跳过

### 2. 修改 `init/autoload.vim`
在适当位置添加：
```vim
" LLMClean ---------------------------------------------------------------{{{1
" 详情查阅 ../autoload/LLMClean.vim
command! -range LLMClean call LLMClean#Run()
```

### 3. （可选）修改 `plugin-config/vim-quickui.vim`
在 Edit 菜单中添加：
```vim
\ ['&LLMClean', 'LLMClean', '清理 AI Markdown 格式'],
```

## 默认行为
- 所有 8 项操作默认均启用（`[x]`）

## Undo 支持
- 完全依赖 Vim 原生 undo 机制（`u` 撤销，`CTRL-R` 重做）
- 无需额外处理，因为 `:s` 和 `:g` 命令会自动记录到 undo 历史

## 兼容性
- Windows GVim 9.2.323
- 纯 VimScript，无额外依赖
