# Vim-init

Vimel 个性化的 Vim 配置

## 安装

* 适用于Windows

1. 新建 `d:\WeirdData\` 目录，把项目克隆到 `d:\WeirdData\vim-init` 下面：
    * 项目位置可以保存到任意位置，这里仅表达目录关系
    * 该保存位置将在第3步中用到

    ```batch
    d:
    cd \WeirdData
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
    source d:\WeirdData\vim-init\init.vim
    ```

4. 打开vim，并安装包：
    * 需要先安装并配置好git

    ```VimCMD
    :PlugInstall
    ```

## 使用 Tips

1. `<Leader>` 是空格键 `<space>`

2. 使用命令 `:VI` 打开并配置 VIMRC

3. 使用 `\` 打开 Navigator 按键导航
    * 使用 `:VN` 自定义 Navigator 导航

4. 使用 `<Leader><Leader>m` 打开菜单
    * 使用 `:VM` 自定义 Menu 菜单
