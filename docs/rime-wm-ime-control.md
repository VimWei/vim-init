# RIME (Weasel) 对 WM_IME_CONTROL 的处理缺陷

## 问题概述

RIME/小狼毫未正确处理 `WM_IME_CONTROL` 消息，导致通过 TSF
（Text Services Framework）无法切换中英文输入状态。只能通过实际按键（Shift）来切换。

## 影响范围

所有通过 TSF 区段（compartments）控制输入法状态的工具均受影响：

- `im-control -c alphanumeric` — 无效果
- `im-control -c native` — 无效果
- VSCodeVim、ideaVim 等编辑器的 IME 自动切换插件
- 任何调用 `ITfCompartment::SetValue(GUID_COMPARTMENT_KEYBOARD_INPUTMODE_CONVERSION)` 的程序

当前唯一可靠的手段是 `-k open/close`（键盘开关），但 `-k close` 会使
RIME 托盘图标变灰（禁用态），而非显示为英文输入状态。

## 技术根因

Windows IME 通过 `WM_IME_CONTROL` 消息控制输入法状态：

```
IMC_GETOPENSTATUS    = 5   // 获取键盘开关状态
IMC_SETOPENSTATUS    = ?   // 设置键盘开关状态
IMC_GETCONVERSIONMODE = 1  // 获取转换模式（中/英/全角/半角等）
IMC_SETCONVERSIONMODE = 2  // 设置转换模式
```

RIME 当前行为：

1. `IMC_GETOPENSTATUS` — 返回值颠倒：中文模式返回 0，英文模式返回 1。
   微软拼音无论中英文均返回 1。
2. `IMC_SETCONVERSIONMODE` — **未实现**。设置 `IME_CMODE_NATIVE` 或
   `IME_CMODE_ALPHANUMERIC` 均不生效。
3. TSF 的 `GUID_COMPARTMENT_KEYBOARD_INPUTMODE_CONVERSION` 区段底层依赖
   `IMC_SETCONVERSIONMODE`，因此 TSF 路径同样无效。

## 正确参考

微软拼音正确处理上述消息：

- 收到 `IMC_SETCONVERSIONMODE` 后，根据 `IME_CMODE_NATIVE` 标志位的
  有无来切换中英文模式
- `IMC_GETOPENSTATUS` 始终返回非零值（键盘打开时）

## 相关链接

- [rime/weasel#1371](https://github.com/rime/weasel/issues/1371)
- 确认 `-c` 无效的测试：`im-control -k open -c alphanumeric` 不会将
  RIME 从中文切到英文

## 补充：AppIME.ahk 的绕过方案

AppIME.ahk 绕过此限制的方法：用 `Send("{LShift}")` 模拟实际按键来切换
RIME 状态。此方法有效但需要 AHK 环境，且不适用于 Vim 等无法直接模拟
OS 级按键的程序。
