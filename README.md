# Vimel Vim-init

个性化 Vim 配置

# Install （Windows）

- 新建 `D:\WeirdData\` 目录，把项目克隆到 `D:\WeirdData\vim-init` 下面：

```batch
D:
cd \WeirdData
git clone https://github.com/VimWei/vim-init.git
```

- 新建 `c:\Users\YourName\vimfiles\` 目录：

```batch
C:
CD \Users\YourName
mkdir vimfiles
```

- 编辑 `C:\Users\YourName\vimfiles\vimrc` 文件，里面加一行：

```VimL
source d:\WeirdData\vim-init\init.vim
```

- 打开vim，并安装包：
 
```batch
:PlugUpdate
```
