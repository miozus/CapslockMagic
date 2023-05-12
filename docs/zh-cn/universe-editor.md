# 🦑 V1.3.0 宇宙编辑器

一统天下之 vscode + idea + neovim && win + mac 都共用一套快捷键，封装了编辑器的常见操作。

通用：需添加前缀 `<leader>` （默认空格键）

- <kbd>n</kbd> 下一个错误
- <kbd>j</kbd> 快速修复
- <kbd>o</kbd> 大纲
- <kbd>z</kbd> 禅模式
- <kbd>f</kbd> 代码格式排版
- <kbd>e</kbd> 转到文件
- <kbd>a</kbd> 文件中查找
- <kbd>s</kbd> 左侧资源管理器中查看该文件
- <kbd>h</kbd> 该文件版本历史
- <kbd>b</kbd> 该行打断点
- <kbd>rr</kbd> 重构：重命名

Idea 特供（Vscode 相似接口不起作用）

- <kbd>g</kbd> 类名高亮时可生成代码
- <kbd>,</kbd> 参数换位左移
- <kbd>.</kbd> 参数换位右移
- <kbd>v</kbd> 重构：抽取变量
- <kbd>m</kbd> 重构：抽取为新方法

特殊：

- <kbd>H</kbd> 窗口标签：上一个（无前缀）
- <kbd>L</kbd> 窗口标签：下一个（无前缀）

当然，猴子输入法 <kbd>;</kbd> `**`，也记录了上述指令，不过实际输出为对应的快捷键组合。这套通用的快捷键映射，我已经做成一套，用了一年多。

#### 使用方法

1. vscode 下载键位映射插件 `IntelliJ IDEA Keybindings`

2. 按如下路径，替换对应软件键位映射配置文件

```bash
# Windows 复制粘贴到（默认/类似）位置 ->
tree .\CAPSLOCKMAGIC\TOOLS
│
├───idea
│     ├─.ideavimrc                -> IdeaVim 插件配置 -> C:\Users\<UserName>\.ideavimrc
│     └─ macOS For All Magic.xml  -> Idea 键位映射配置 -> C:\Users\<UserName>\AppData\Roaming\JetBrains\IntelliJIdea2022.1\keymaps\macOS For All Magic.xml
│
├───code
│     └─keybindings.json          -> Vscode 键位映射配置 -> C:\Users\<UserName>\AppData\Roaming\Code\User\keybindings.json
│
└───neovim
      └─init.vim                  -> Vscode/Neovim 用户配置 ->  C:\Users\<UserName>\AppData\Local\nvim\init.vim
```

#### 设计思路

**1.跨平台键位映射方案增强**

比如 <kbd>Shift</kbd> <kbd>F6</kbd> 代码重命名

> 源自 idea  插件（win+mac）的键位映射方案 [samvtran/jetbrains-macos-keybindings-for-all](https://github.com/samvtran/jetbrains-macos-keybindings-for-all)  : MacOS / Windows 的按键兼容。
> 
> 我将它移植到了 vscode 并微调适配。

**2.Neovim 增强**

比如 `<leader>rr` 代码重命名

特别地，在 Idea + Vscode 的 Neovim 插件（.ideavimrc + init.vim），对于调用编辑器动作接口，都做了统一适配。

这份配置记录了一年来，从化身八爪鱼敲键盘也无法退出 vim
的小白，到如今形成肌肉记忆的程序员，它吸收了众多设计思想：两本书，三四个开源仓库，十多个国内外视频，在各种编辑器摸爬滚打,删繁就简妥协后，获得相对平衡的结果。

**3.AutoHotkey 增强**

比如 <kbd>;</kbd> `lrr` 代码重命名（前面加个小写的`L`，代替 `<leader>` 键）

在插件 IDE.ahk 中的 `IdeAction` 类，封装了 1 方案的组合键。

