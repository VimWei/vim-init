# Vim-init

Vimel 个性化的跨平台 Vim 配置（Linux 遵循 XDG 规范，Windows 遵循平台惯例）

## 安装与配置

### 1. 克隆仓库到配置目录

打开终端，先回到用户主目录，后续所有操作均基于此使用相对路径：

* **Linux / Debian:**

    ```bash
    cd ~
    mkdir -p .config
    ```

* **Windows (CMD):**

    ```batch
    cd /d %USERPROFILE%
    mkdir .config
    ```

* **统一克隆命令 (跨平台一致):**

    ```bash
    git clone https://github.com/VimWei/vim-init.git .config/vim
    ```

* **Windows (CMD) 额外步骤：** 创建符号链接让 Vim 找到配置文件：

    ```batch
    if not exist vimfiles mkdir vimfiles
    if exist vimfiles\vimrc del vimfiles\vimrc
    mklink vimfiles\vimrc .config\vim\vimrc
    ```

### 2. 设置 Python 环境

```bash
# 安装 uv
# Linux / macOS:
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows (WinGet，CMD/PowerShell 通用):
winget install --id=astral-sh.uv -e

# 安装 python 环境及依赖
uv pip install --requirement .config/vim/pyproject.toml --target .local/share/uv/tools/vim-init
```

### 3. 激活插件安装

打开 Vim，在命令行模式下执行以下命令完成所有插件的组装：

```VimCMD
:PlugInstall
```

> 📂 **目录隔离说明：**配置文件存放于配置目录 `.config/vim/`，而插件源码、undo 历史、swap 临时文件等运行时数据会自动隔离到独立目录，不污染配置仓库：
> * **Linux:** `~/.vim/`（含 `plugged/`、`undodir/`、`swap/`、`backup/`）
> * **Windows:** `%USERPROFILE%\vimfiles\`（含 `plugged/`、`undodir/`、`swap/`、`backup/`）

## 使用 Tips

1. `<Leader>` 是空格键 `<space>`

2. 使用命令 `:VI` 打开并配置 VIMRC

3. 使用 `\` 打开 Navigator 按键导航
    * 使用 `:VN` 自定义 Navigator 导航

4. 使用 `<Leader><Leader>m` 打开菜单
    * 使用 `:VM` 自定义 Menu 菜单
