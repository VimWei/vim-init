# Vim-init

Vimel 个性化的 Vim 配置

## 安装

* 适用于Windows

1. 选择一个目录存放项目，例如 `d:\YourPath\vim-init`：
    * 项目位置可以保存到任意位置，这里仅表达目录关系
    * 该保存位置将在第3步中用到

    ```batch
    d:
    cd \YourPath
    git clone https://github.com/VimWei/vim-init.git
    ```

2. 新建 `c:\Users\YourName\vimfiles\` 目录：

    ```batch
    c:
    cd \Users\YourName
    mkdir vimfiles
    ```

3. 编辑 `$HOME/vimfiles/vimrc` 文件，里面加一行：
    * 具体位置：`c:\Users\YourName\vimfiles\vimrc`
    * vimrc文件可从本 项目根目录中复制
    * 根据步骤1修订vim-init\init.vim的存放路径

    ```VimL
    source d:\YourPath\vim-init\init.vim
    ```

4. 打开vim，并安装包：
    * 需要先安装并配置好git

    ```VimCMD
    :PlugInstall
    ```

5. 设置 Python 环境：
    * 部分插件（如 LeaderF 等）需要 Python 支持
    * 需要先安装 [uv](https://docs.astral.sh/uv/getting-started/installation/)

    ```batch
    cd d:\YourPath\vim-init
    uv venv
    uv sync
    ```

## 使用 Tips

1. `<Leader>` 是空格键 `<space>`

2. 使用命令 `:VI` 打开并配置 VIMRC

3. 使用 `\` 打开 Navigator 按键导航
    * 使用 `:VN` 自定义 Navigator 导航

4. 使用 `<Leader><Leader>m` 打开菜单
    * 使用 `:VM` 自定义 Menu 菜单
