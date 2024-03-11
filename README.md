# Vim-init

Vimel 个性化的 Vim 配置

## 安装（适用于Windows）

1. 新建 `D:\WeirdData\` 目录，把项目克隆到 `D:\WeirdData\vim-init` 下面：

    ```batch
    D:
    cd \WeirdData
    git clone https://github.com/VimWei/vim-init.git
    ```

2. 新建 `c:\Users\YourName\vimfiles\` 目录：

    ```batch
    C:
    CD \Users\YourName
    mkdir vimfiles
    ```

3. 编辑 `C:\Users\YourName\vimfiles\vimrc` 文件，里面加一行：
    * 可从项目根目录复制vimrc文件
    * 根据步骤1修订vim-init\init.vim的存放路径

    ```VimL
    source d:\WeirdData\vim-init\init.vim
    ```

4. 打开vim，并安装包：
    * 需要先安装并配置好git

    ```VimCMD
    :PlugUpgrade
    :PlugUpdate
    ```
