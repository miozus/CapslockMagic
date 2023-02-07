# CapslockMagic

> [中文文档](https://github.com/miozus/CapslockMagic) | [README](https://translate.google.cn/) | [Karabiner Gallery](https://ke-complex-modifications.pqrs.org/#caps_lock_magic) | [Github Repo](https://github.com/miozus/CapslockMagic) | [Gitee Repo](https://gitee.com/miozus/CapslockMagic)
>
> Make Capslock Great Three!
> 
> <a href="https://github.com/thqby/AutoHotkey_H"> <img src="https://img.shields.io/badge/AutoHotkey__H-thqby-orange?style=flat&logo=GitHub"></a> <a href="https://github.com/miozus/CapslockMagic"> <img src="https://img.shields.io/badge/CapslockMagic-1.4.5-brightengreen?style=flat&logo=ClickUp"></a> <a href="https://jq.qq.com/?_wv=1027&k=iiuN83v3"> <img src="https://img.shields.io/badge/QQ群-1026918136-yellow?style=flat&logo=TencentQQ"></a>

- [CapslockMagic](#capslockmagic)
  - [快速开始](#快速开始)
    - [Windows](#windows)
    - [MacOS](#macos)
      - [直接云端导入配置](#直接云端导入配置)
  - [如何使用](#如何使用)
    - [3️⃣ 数字小键盘](#3️⃣-数字小键盘)
    - [; 分号特殊符（特舒服）](#-分号特殊符特舒服)
    - [⌨️ 猴子输入法](#️-猴子输入法)
    - [📺 窗口移动](#-窗口移动)
    - [📺 窗口定型](#-窗口定型)
    - [🖱️ 鼠标控制](#️-鼠标控制)
  - [程序员专辑](#程序员专辑)
    - [🦉 V1.2.0 单手调试器](#-v120-单手调试器)
    - [🦑 V1.3.0 宇宙编辑器](#-v130-宇宙编辑器)
    - [🕷️ v1.4.0 爬虫零件箱](#️-v140-爬虫零件箱)
    - [️🕶️ v1.5.0 HHKB兼容适配](#️️-v150-hhkb兼容适配)
  - [1分钟学会添加一个猴子词条](#1分钟学会添加一个猴子词条)
  - [进化史](#进化史)
  - [五个人性化设计](#五个人性化设计)
  - [常见问题](#常见问题)

---

## 快速开始

### Windows

1.下载

```bash
git clone https://github.com/miozus/CapslockMagic.git
```

2.运行

1. 解压文件: `tools/AutoHotkey_H/AutoHotkey_H-xx-thqby.7z`
   ，或者 [thqby/AutoHotkey_H](https://github.com/thqby/AutoHotkey_H/releases) 版本中心下载最新发行版和解压。
2. 添加管理员权限：右键单击 `AutoHotKey.exe` （x64 / x32）> 属性 > 安全 > 兼容性 > 勾选管理员权限 > 确定。
3. 设置默认打开方式：右键单击 `CapslockMagic.ahk` : 打开方式，选择到步骤1的解压目录的 `AutoHotKey.exe` 打开。

<details>
<summary> 【推荐】开机自启</summary>
&nbsp;

创建基本任务：按 <kbd>Win</kbd> 键搜索 `task` > 任务计划程序 > 右键单击任务计划程序库，新建文件夹 > 新建基本任务 > (按引导设置) > 完成

- 常规：必选使用最高权限运行
- 触发器：登陆时
- 条件：取消勾选所有
- 操作：启动程序 `AutoHotKey.exe`, 参数 `CapslockMagic.ahk` 文件地址

![auto-startup-plan](bin/img/auto-startup-plan.png)

</details>

<details>
<summary>【可选】快速启动小技巧</summary>
&nbsp;

1. 新建文件夹 `myenv` 
2. 右键点击`CapslockMagic.ahk` 创建快捷方式，剪切放入 `myenv` 文件夹中（重命名为`m`）
3. 将 `myenv` 文件夹完整路径，添加到系统环境变量 PATH。
4. 即实现 <kbd> Win</kbd> + <kbd>E</kbd> 输入 `m` 回车，瞬间启动。

![myenv-tip](bin/img/myenv-tip.png)

</details>

### MacOS

#### 直接云端导入配置

使用 `Safari` 浏览器打开链接，它将自动加载配置到 `Karabiner-Element`：打开软件，选择 `complex-mapping` 标签 >
左下角 `add-rule` > 选择配置 > `Enable` 。

```bash
karabiner://karabiner/assets/complex_modifications/import?url=https://raw.githubusercontent.com/miozus/CapslockMagic/master/tools/karabiner/caps_lock_magic.json
```

> **注意**： 脚本支撑软件是免费开源的 [Karabiner-Element](https://karabiner-elements.pqrs.org/) ，如未下载，请先自行下载。 CapsLockMagic 已支持拓展包：
> 
> - 分号特殊符 `Semicolon Pull Down Symbol`
> - 数字小键盘 `3 Awake Digital Keyboard`
> - 其他基础功能，请参考开源项目 [Vonng/Capslock](https://github.com/Vonng/Capslock) ，按需导入。

<details>
<summary>【可选】官方仓库导入</summary>
&nbsp;

```bash
https://ke-complex-modifications.pqrs.org/#caps_lock_magic
```

</details>

<details>
<summary>【可选】二次开发手动导入 </summary>
&nbsp;

1. 下载

  ```bash
  git clone https://github.com/miozus/CapslockMagic.git
  ```

2. 修改
   修改文件 `tools/karabiner/caps_lock_magic.yml`
3. 运行终端命令 yq （如果没安装过，则先运行 `brew install yq`），转换格式 yaml ⇒ json 放到默认配置目录中

```bash
yq eval -j -I=2 your_path_to_CapslockMagic/tools/karabiner/caps_lock_magic.yml > ~/.config/karabiner/assets/complex_modifications/caps_lock_magic.json
```

4 打开应用，添加规则和启用配置

```bash
open -a Karabiner-Elements
```

</details>

## 如何使用

将 ⇪CapsLock（大写锁定键）改造为一个强力的功能修饰键（✱ Hyper ），奇迹般地提高操作效率与生产力。

![控制平面](/bin/img/keyboard-enhancement.jpg)

按键功能继承自 [CapsLock-Enhancement](https://github.com/Vonng/Capslock/tree/master/docs/zh-cn) （中文参考文档），操作基本一致，直接敲键盘试用，这里不再赘述。 下面主要介绍 `Magic` 进化的功能：

### 3️⃣ 数字小键盘

按住数字 <kbd>3</kbd> 不松手时，保持在数字模式，同时轻敲 <kbd>第二个键</kbd>，实际输出为图示对应键位下方的键，松开 <kbd>3</kbd> 退出数字模式。

![数字小键盘](bin/img/digital-keyboard.png)

| 输入                        | 输出                     |
| --------------------------- | ------------------------ |
| <kbd>3</kbd> + <kbd>2</kbd> | <kbd>F2</kbd>            |
| <kbd>3</kbd> + <kbd>J</kbd>  | 4                        |
| <kbd>3</kbd> + <kbd>N</kbd>  | 空格键                   |
| <kbd>3</kbd> + <kbd>G</kbd>  | G（Vim 跳行） |
| <kbd>3</kbd> + 无（松开）   | 3                        |

- 方便记忆：想象成稍微倾斜的数字小键盘。

- 适用场景：手机号码、验证码、坐标、代码行号等。附带确认、删除。

<details>
<summary>数字小键盘设计思路（展开）</summary>
&nbsp;

- 取消了映射到 <kbd>F3</kbd> 的按键，因为 <kbd>F3</kbd> 为了成全整个模式，牺牲了它自己。

- 把 <kbd>F1~12</kbd> 加上， 是因为他们都和数字有关，而且我的 60 配列键盘 `fn2` 键在右下角对称 `Ctrl` 键， 单个键要瞟一眼键盘，再整组合键的话，手指太扭曲了。

</details>

### <kbd>;</kbd> 分号特殊符（特舒服）

按住分号 <kbd>;</kbd> **不松手**，进入“分号特殊符模式”，同时轻敲 <kbd>第二个键</kbd> ，实际输出对应键位上方的字符。松开 <kbd>;</kbd> 立即退出。

![分号特殊符](bin/img/semicolon-keyboard.png)

- 例如 <kbd>;</kbd> + <kbd>a</kbd> 实际输出 <kbd>*</kbd>

<details>
<summary>符号分布设计思路（展开）</summary>
&nbsp;

这样排布设计来自咸鱼阿康， 我们都用 Vim，所以本人优化的方向，也在于提升 Vim 体验:

1. 元素定位

- <kbd>H</kbd> `%` 定位括号：修改函数参数。
- <kbd>J</kbd> `;` 定位上个操作位置，使用频繁高。
- <kbd>K</kbd> `` ` `` 反引号常用来写文档，引用代码。
- <kbd>L</kbd> `"` 定位字符串，天天见。因为占用了分号键，就让邻居顺便补偿给它。
- <kbd>E</kbd> `^` <kbd>U</kbd> `$` 定位语句开头/末尾，注意观察数字键上 Vim
  和正则表达式，对于前后的按键刚好反过来。这太反人类了!因为这个设定折磨我太久，所以使用分号模式时仿佛看到沙漠绿洲。
- <kbd>B</kbd> `{` 定位大括号内，bracket 原生操作大小括号，放在一起。 <kbd>;</kbd> <kbd>shift</kbd> <kbd>B</kbd> = `)`
- <kbd>Q</kbd> `(` 定位小括号内  <kbd>;</kbd> <kbd>shift</kbd> <kbd>Q</kbd> = `}`
- <kbd>Y</kbd> `@` 执行宏，小技巧常用 `qq` 开启记录，左右搭配。也不至于误触。

2. 游戏见闻

- <kbd>N</kbd> `-` <kbd>M</kbd> `+` 我玩游戏发现的，物品计数器左边小右边大，符合直觉。
- <kbd>S</kbd> <kbd>E</kbd> <kbd>D</kbd> <kbd>F</kbd> 看上去正好像方向键 `<` `^` `>`
  左手刚好放在热键区。我思考过，游戏中左手默认方向键 <kbd>W</kbd> <kbd>A</kbd> <kbd>S</kbd> <kbd>D</kbd>
  是因为小拇指可以方便按修饰键，太浪费了。

3. 单词缩写

- <kbd>V</kbd> `|` Vertical 垂直线，V 字母从中间对称分开，V 键大概在键盘的中央（<kbd>;</kbd> <kbd>shift</kbd> <kbd>V</kbd>
  组合键映射为中文顿号 `、` ）。
- <kbd>T</kbd> `~` Tide 波浪线（<kbd>;</kbd> <kbd>shift</kbd> <kbd>T</kbd> 组合键映射为 4 个空格）。
- <kbd>C</kbd> `.` comma / dot / period 点。这里按两个键映射一个键的原因，一是可用脚本保证必须输出英文字符，不受中文句号影响；二是
  JQ 元素定位类语法 `$.` 的连击。
- <kbd>X</kbd> `_` Xia Hua Xian 下划线。
- <kbd>G</kbd> `!` Gan Tan Hao 感叹号。
- <kbd>D</kbd> `=` Deng Hao 等号。

4. 常用操作

- <kbd>Z</kbd> 撤销操作：如果打错字或误删，撤销就好了。
- <kbd>O</kbd> 切换输入法：能不用手掌按 <kbd>Ctrl</kbd> 键，就不要去按了，让双手保持在热键区。

</details>

### ⌨️ 猴子输入法

按下分号 <kbd>;</kbd> **立即松手**（即轻按），进入“猴子输入法”状态，此时监听键盘，输入正确的密令，输出字符片段（纯文本），或执行自定义的函数指令。

如果输入错误密令或按下 <kbd>Esc</kbd> 等，立即退出。

<img src="bin/img/hook_cne.gif" width="100%" alt="print_snippets.gif"/>

| 输入                                                              | 显示   | 输出说明                                       | 猴子   | 输入法状态 |
| ----------------------------------------------------------------- | ------ | ---------------------------------------------- | ------ | ---------- |
| <kbd>;</kbd>（轻按）                                              | 🙈      | 等待输入密令                                   | 不看   | 进入       |
| 假如 <kbd>c</kbd> <kbd>n</kbd> <kbd>e</kbd>                       | cn     | 匹配到猴子词典（字符片段 1️⃣），输出纯文本 |        | 退出       |
| 假如 <kbd>c</kbd> <kbd>n</kbd> <kbd>k</kbd>                       | cnk    | 尚未匹配，继续等待                             |        | 等待       |
| <kbd>⏎</kbd> 或 <kbd>Esc</kbd> 或 <kbd>␣</kbd>                    | 💨      | 截至目前未匹配成功，中断                       | 跑了   | 退出       |
| 假如 <kbd>s</kbd><kbd>l</kbd><kbd>e</kbd><kbd>e</kbd><kbd>p</kbd> | slee   | 匹配到猴子词典（函数指令 2️⃣），执行自定义函数功能           |        |
|                                                                   | 🙉 睡眠 | 电脑马上进入休眠状态                           | 猜对了 | 退出       |

> 这是 Windows **独占**功能，词条数据保存在 `/data/UserDictionary.ahk` 中。

<details>
<summary>猴子输入法设计思路（展开）</summary>
&nbsp;

它的本质是map字典映射

- key：自定义的缩写，怎么好记怎么来。
- value: 指令集，主要分为两类
    - 1️⃣ **`xxDictionary` 字符片段词典:**。其他所有的变量 都是这类纯文本（支持换行和缩进），邮箱，网址，emoji 等。
    - 2️⃣ **`secretDictionary` 函数指令词典**。它代表用户定义的一系列 AHK 指令集的可执行函数。
        - 这里设计为必须写注释，不写不生效。
            - 比如添加一行 `"sleep", "睡眠",`
            - 还要在 `bin\SemicolonHook.ahk` 的`execSemicolonAbbr` 方法中添加一种情况 `case "sleep": computerGoSleep()`
        - 技巧：它可以用来写 Vim 的宏，完美的跨软件运行方案。

MacOS 仅将用户词典添加到内置输入法，作为打字候选项。

</details>

<details>
<summary>【案例】如何将猴子词典（.ahk）导出到第三方输入法，比如苹果词典（.plist）?</summary>
&nbsp;

> 目前已支持 MacOS、QQ拼音、搜狗拼音相互转换

![UserDict](bin/img/userDict.png)

根据需要调用 `Converter` 类的转换方法，获得用户自定义短语文件 ，通过局域网/蓝牙/微信等方式传输，导入输入法软件即可。

1. 打开猴子词典 `./data/UserDictionary.ahk` ，在底部根据自身需要去掉注释，保存后按 <kbd>Caps</kbd> <kbd>Y</kbd> 重启脚本。

```JavaScript

;选择性注释，开放转换接口
global
macDictionary := UserDict.concat([emojiDict, csDict, privateDict, logoDict])

CapsLock & 9::
{
;猴子词典 -> 苹果词典（枚举类参数可选
MAC / PINYIN / JSON）
    Converter.convert(macDictionary, DictTypeEnum.MAC)

    ;猴子词典 < -苹果词典（弹窗选择文件）
    ;Converter.parse()

;猴子词典 < -苹果词典（文件目录） 
    ;
fileDir := "/dist/userdict4macos.plist"
;
Converter.parse(fileDir)

}

```

2. 按 <kbd>Caps</kbd> <kbd>9</kbd> ，根据弹窗提示操作后，点击确定，脚本所在目录就生成了文件 `/dist/userdict4macos.plist` ，通过局域网共享文件传输到 MacOS。

![转换弹窗提示](bin/img/convertMsg.png)

3. MacOS 拖拽用户词典到文本

![importMacDict](bin/img/macObj2macDict.gif)

偏好设置 > 键盘 > 文本

一般先全选删除旧词典，再将成品文件 `.plist` 拖拽进来， 导入内置中文输入法，和平时打字没有区别，只是多了候选项， 润物细无声。

没有切换输入法，也可以自动补全（但在 IDE 中却失效了）。

</details>

&nbsp;

> **<kbd>A</kbd>  禅模式（单手操作原理）**
>
> - 进入：组合键按下后，即可松手，键盘进入 1.5 秒的监听状态，根据用户第二个按键，立即做出一次响应动作。
> - 退出：等待超时，会退出状态，或者按下 <kbd>Esc</kbd> 键，主动退出禅模式。
> 
> 注意： 如果遇到状态栏菜单，快速弹出作为收尾动作，这是正常现象，因为用来解除 `Win` 键的按键锁定，避免卡键的副作用。

**<kbd>A</kbd> 系列的组合键，专门集成窗口管理和鼠标控制的功能**

### 📺 窗口移动

![窗口禅模式](bin/img/moom-move.gif)

按下 <kbd>Caps</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> （可以松手了）开启禅模式：

此时轻敲 <kbd>第二个键</kbd>，移动窗口坐标位置。

- <kbd>H</kbd> <kbd>J</kbd> <kbd>K</kbd> <kbd>L</kbd> 控制左下上右的移动方向（Vim 风格）
- <kbd>␣</kbd> 窗口回到屏幕中央

### 📺 窗口定型

![窗口定型](bin/img/moom-zoom.gif)

按下 <kbd>Caps</kbd> + <kbd>Ctrl</kbd> + <kbd>A</kbd> （可以松手了）开启禅模式：

此时轻敲 <kbd>第二个键</kbd>，使得窗口占据屏幕部分区域。

- <kbd>H</kbd> <kbd>J</kbd> <kbd>K</kbd> <kbd>L</kbd> 上下左右，即 Vim 风格
- <kbd>[</kbd> <kbd>]</kbd> 偏左 / 右（2:1）
- <kbd>I</kbd> <kbd>O</kbd> 偏左 / 右（1:1）
- <kbd>␣</kbd> 中央（1:1:1）
- <kbd>N</kbd> 正中央
- <kbd>M</kbd> <kbd>,</kbd> 窗口最大/小化
- <kbd>.</kbd> 窗口大小回到上一个状态

### 🖱️ 鼠标控制

![鼠标禅模式](bin/img/mouse-move.gif)

<kbd>Caps</kbd> + <kbd>Win</kbd> + <kbd>A</kbd> 或者 猴子输入法 <kbd>;</kbd> `zen` 开启（可以松手了），开启禅模式：

此时轻敲 <kbd>第二个键</kbd>，控制光标动作。

- <kbd>H</kbd> <kbd>J</kbd> <kbd>K</kbd> <kbd>L</kbd> 控制方向（Vim）
  - 同时按住不放 <kbd>A</kbd> 键，能降低鼠标移动速度
- <kbd>I</kbd> / <kbd>O</kbd> 单击左 / 右
- <kbd>U</kbd> / <kbd>P</kbd> 滚轮前 / 后
- <kbd>N</kbd> / <kbd>M</kbd> 侧键前 / 后
- <kbd>C</kbd> / <kbd>V</kbd> 复制/粘贴 选中文字
- <kbd>G</kbd> 指针回到窗口中央

---

## 程序员专辑

### 🦉 V1.2.0 单手调试器

封装了 JetBrains Intellij Idea 键位映射风格的调试快捷键。按下组合键后，它先自动激活 Idea 窗口（如有，没有则作罢），通过快捷键，触发对应的功能。

- 进入（二选一）
    - 按住生效：按住数字键 <kbd>4</kbd> 不松手
    - 猴子输入法 <kbd>;</kbd> `dbg` 开启禅模式
- 退出
    - 主动：<kbd>Esc</kbd>
    - 被动：<kbd>A</kbd> <kbd>I</kbd> <kbd>O</kbd> <kbd>S</kbd> 增删改代码时，或 <kbd>␣</kbd> 打开调试计算器时默默退出

特别地，同时按下（第三个键） <kbd>Ctrl</kbd> 键，左上角按键都获得增强功能。

<img src="bin/img/debug-keyboard.png" width="100%" alt="print_snippets.gif">

示例

- 按下 <kbd>4</kbd> + <kbd>1</kbd> ，触发 `stepOver` 快捷键，程序执行当前语句，高亮下一行语句。
- 按下 <kbd>4</kbd> + <kbd>3</kbd> ，触发 `resume` 快捷键，程序放行当前断点，执行到下一个断点。
- 按下 <kbd>4</kbd> + <kbd>5</kbd> ，触发 `hotspot` 快捷键，执行 Jrebel 热部署的编译功能，相当于按下小斧头。


### 🦑 V1.3.0 宇宙编辑器

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

使用方法：替换对应软件键位映射配置文件

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

<details>
<summary>宇宙编辑器增强功能按键设计（展开）</summary>
&nbsp;

1.跨平台键位映射方案增强

比如 <kbd>Shift</kbd> <kbd>F6</kbd> 代码重命名

> 源自 idea  插件（win+mac）的键位映射方案 [samvtran/jetbrains-macos-keybindings-for-all](https://github.com/samvtran/jetbrains-macos-keybindings-for-all)  : MacOS / Windows 的按键兼容。
> 
> 我将它移植到了 vscode 并微调适配。

2.Neovim 增强

比如 `<leader>rr` 代码重命名

特别地，在 Idea + Vscode 的 Neovim 插件（.ideavimrc + init.vim），对于调用编辑器动作接口，都做了统一适配。

这份配置记录了一年来，从化身八爪鱼敲键盘也无法退出 vim
的小白，到如今形成肌肉记忆的程序员，它吸收了众多设计思想：两本书，三四个开源仓库，十多个国内外视频，在各种编辑器摸爬滚打,删繁就简妥协后，获得相对平衡的结果。

3.AutoHotkey 增强

比如 <kbd>;</kbd> `lrr` 代码重命名（前面加个小写的`L`，代替 `<leader>` 键）

在插件 IDE.ahk 中的 `IdeAction` 类，封装了 1 方案的组合键。

</details>

### 🕷️ v1.4.0 爬虫零件箱

提供零件，可组合零件实现浏览器爬虫：点击网页元素，下载资源的自动化机器人。

适用场景：

- 害怕 Python 爬虫而封禁IP，或解析资源路径困难。
- 可复制的网页预览的文件（非图片）
- 上万条记录，需要人工点击下载。

```bash
CapslockMagic\bin\util
├── Animation.ahk     # 时间动画: 挂机运行非静止画面
├── FilePipe.ahk      # 文件管道：导入导出和文件名添加日期
├── FileStream.ahk    # 文件流：增删改查
├── Interceptor.ahk   # 过滤器：不必每个点开看
├── Internet.ahk      # 网络测试：是否断网
├── Location.ahk      # 定位器：网页元素坐标
└── Logger.ahk        # 日志：每条记录处理过程和结果
```

日志示例：每个表情代表执行了一种管道操作

``` bash
[2022-12-12 05:18:44] 4582-8 🙈 *** empty file
[2022-12-12 05:20:38] 4591-2 🐘 *** too big size
[2022-12-12 16:06:50] 4: ✅: source => destination | well-done
[2022-12-12 16:33:57] 9: 🈚⭐🐞: source ⇒ destination | not exist & create file & bug
```

###  ️🕶️ v1.5.0 HHKB兼容适配

![HHKB-win-keymap](bin/img/HHKB-win-keymap.png)

TODO: 兼容更BT的 60 配列，按常用功能进行整合重构，移除冷门应用

这样改键，为了兼顾 Mac 习惯，又不失caps常用功能，过渡自然

## 1分钟学会添加一个猴子词条

TODO: 语法嗅探、快捷短语、自定义函数，（特殊应用环境生效），集成进词条

## 进化史

`Magic` 继承了 `Capslock Enhancement` 的经典设计（类似 HHKB 键盘），弥补了它在 Windows 平台的空白。

`Magic` 吸收了 `MyKeymap` 的实现细节和设计灵感，并修复了脚本语言向上兼容，采用面向对象的现代编码风格，让开发者更容易拓展和上手维护。

`Magic` 进化了 **猴子输入法**，可以管理任意的用户指令集，获得念咒语般的魔法。

| 序号         | 功能特色   | Enhancement                                         | MyKeymap                                                      | Magic                                                             |
| ------------ | ---------- | --------------------------------------------------- | ------------------------------------------------------------- | ----------------------------------------------------------------- |
| 🌐            | Github     | [Vonng/Capslock](https://github.com/Vonng/Capslock) | [xianyukang/MyKeymap](https://github.com/xianyukang/MyKeymap) | [miozus/CapslockMagic](https://github.com/miozus/CapslockMagic)   |
| 💻            | 支持平台   | 主: MacOS </br> 次: Windows                         | 仅限 Windows11/10                                             | 主: Windows 11/10 </br> 次: MacOS                                 |
| ⌨️            | 推荐配列   | 87 键                                               | 60 键                                                         | 60 键                                                             |
| 🧰            | 开发软件   | Karabiner 单纯的字典风格                            | AutoHotkey V1 面向过程的脚本风格                              | AutoHotkey_H_V2 面向对象的现代风格，类似 JavaScript，支持多线程   |
| ⚙️            | 配置文件   | 鸿篇巨制的 json / yaml 文本                         | 内置网页服务，界面非常友好                                    | 源码即配置，拓展灵活，适合开发者                                  |
| 👾            | 启动程序   | ✅ 仅打开第一个                                      | ✅ 支持同类窗口切换                                            | ✅ 支持同类窗口切换                                                |
| 📺            | 窗口调整   | ✅ 需安装 Moom                                       | ✅ 调整位置和移动                                              | ✅ 调整位置和移动（仿写的 Moom）、支持禅模式                       |
| 🖱️            | 鼠标操作   | ✅ 需双手按住                                        | ✅ 需双手按住                                                  | ✅ 按下进入禅模式，可单手操作                                      |
| `I`          | 光标编辑   | ✅ 方向移动和前后删除                                | ✅ 需双手按住                                                  | ✅ 方向移动和前后删除                                              |
| 🐵            | 猴子输入法 | ❌                                                   | ✅ 分号模式：指令集                                            | ✅ 分号模式进阶版：用户词典、指令集等，支持词典同步 MacOS          |
| <kbd>;</kbd> | 分号特殊符 | ❌                                                   | ✅ 重排列到字母键位                                            | ✅ 重排列到字母键位（调优），支持 MacOS                            |
| 3️⃣            | 数字小键盘 | ❌                                                   | ✅ 数字模式                                                    | ✅ 数字小键盘 + <kbd>F1~12</kbd> ，支持 MacOS                      |
| 🤖            | 中英文管家 | ❌                                                   | ❌                                                             | ✅ 解决写代码又写注释的切换痛点                                    |
| 🦉            | 单手调试器 | ❌                                                   | ❌                                                             | ✅ 压缩的调试组合键（程序员特供）                                  |
| 🦑            | 宇宙编辑器 | ❌                                                   | ❌                                                             | ✅ 统一的 Idea + vscoDe 键位映射方案 + vim 增强热键 （程序员特供） |

## 五个人性化设计

🤖 **中英文管家**

优化了写代码注释的体验，让脚本托管软件对应的中英文状态以及切换。

- 开发者在各种编辑器 `VSCode`、`Intelj Idea`、`Vim` 写完注释后，按 <kbd>Caps</kbd> 可以直接返回到 `Normal` 模式。
- 如果切换到 `Notion` 写文档，默认使用中文，切回 IDE 默认变回英文。

<details>
<summary> 自动切换实现原理 </summary>
&nbsp;

- 按下 <kbd>Caps</kbd> （映射 <kbd>Esc</kbd>） 或鼠标单击时，脚本会使用图像识别，全屏检测一次 `中文输入法现在处于什么模式？`
  ，如果是中文，就切换回英文。
    - 默认微软拼音。如果用搜狗拼音，配置切换接口即可，甚至不用图像识别。
    - 特殊的中文标点符号：已内置在词典中，以备不时之需。
    - 闲鱼阿康的解决方案：推荐禁用中文输入法了。（太简单粗暴了。）
- 在中英文标点的细节上，为了避免被 InputHook 模式冲突， 特别声明了 中文标点输入 开关（chinsePunctuationHotkey），进行拦截

</details>

<details>
<summary>设计思想：下定决心忘记所有输入法的状态</summary>
&nbsp;

为你的常用程序分别设置初始状态，每次切换回来。它会默默自动初始化中文 / 英文输入法状态，然后你要做的。你只要敲键盘，忘记它的的状态。 (参考文章: [AHK 实现中英文输入法自由](https://www.jianshu.com/p/72f63e9f7c0e))

</details>

&nbsp;
📒 **内置猴子词典**

词典是全新的命名空间，本质是 Map 数据结构，作为底层支撑着猴子输入法，不会和本地输入法冲突。这是半年来积累的实践，每天都在用，打字重复三次就考虑入库，灵感式更新。如果你想重写自己的词典，它非常有参考价值。

<details>
<summary>映射键值编码规则</summary>
&nbsp;

- `小鹤双拼` 的拼音编码。比如 jxso（即全拼 jiasuo，加锁） ⇒ 🔒
    - 因为双拼能保证四个字母键，拼出两字词语，重码率低，这套规则的按键频率，分摊到手指也不累。
- 单词缩写，所读即所得。比如 acf ⇒ `@` `C`on `f` iguration

</details>

<details>
<summary>猴子词典涵盖范围</summary>
&nbsp;

- `emoji`：数据结构和算法 | 缓存 | 线程 | 设计模式 | 事务
- `cs`：计算机科学 | Spring 常用注解 | RESTful | 代码片段（如预防各种类型 NPE）
- `win`: PowerShell 终端命令
- `private`：完整中文标点符号 （无视输入法）| 按键符号
- `logo`：收集各种开发框架图标链接，装饰 Notion 标题

</details>

&nbsp;
🚫 **屏蔽热键**

屏蔽了微软 <kbd>Win</kbd> 键相关的 `一年也用不上几次但几百年都存在` 的组合键，做组合键的吝啬鬼。

🧩 **内置插件**

`Notion.ahk` 支持粘贴不同语言的代码块、调整`block`折叠或无序列表，左手删除字符，代码块语言格式；去掉粘贴文本格式等功能。

⏳ **动画计时器**

如果你网络请求，等待时间比较长，看上去像电脑死机，为什么不试试  `Timer` 动画呢？人有悲欢离合，月有阴晴圆缺。

## 常见问题

<details>
<summary> 1. 脚本可以设置开机自启吗？ </summary>
&nbsp;

可以。分两种情况。

1. 自带【管理员权限】的软件，只能【计划任务和程序】。因为一般管理员权限的软件都不能开机自启，都会面临的 PAC 问题。
  - 如果不给管理员权限，遇到有些系统软件，脚本就失效了。
  - 它需要管理员权限来控制 `sehll` ，降权打开软件（比如 VSCode）。

2. 不带【管理员权限】的软件， 将脚本的快捷方式，剪切放到开机自启的目录（ <kbd>win</kbd> + <kbd>R</kbd> 运行`shell:startup`）中即可。

</details>

<details>
<summary> 2. 脚本支持旧版的 AutoHotkey V1 吗？（脚本支持 Windows 7）吗？ </summary>
&nbsp;

`Magic` 早期也是从 V1 迭代过来，历史版本保存在 `/tools/release/AutoHotkey_V1` 目录下，可从
[AutoHotkey 官网地址](https://www.autohotkey.com/) 下载当前版本的配套软件（AutoHotkey_1.1.33.10+）直接运行。

- `magic_v1` 单机服务，简单的光标编辑等，想到什么功能就扔进去。
- `magic_v2` 拆分多个微服务，为不同的软件编写脚本，做了拆分，可见现在的雏形。

这两个版本，本人不再更新维护了，因为后面遇到了面向对象风格的版本，维护和拓展更方便。如果你在用 Windows7 ，可以参考修改，直接拿去用吧。

</details>

&nbsp;
>
> All my effort is the parody of Ruohang Feng (@Vonng) &amp; Salted Fish Akang (@xianyukang).
>
> 我所有的努力都是对冯若航和咸鱼阿康的拙劣模仿。
