# 简介

> [中文文档](https://github.com/miozus/CapslockMagic) | [README](https://github.com/miozus/CapslockMagic/blob/master/README_EN.md) | [Karabiner Gallery](https://ke-complex-modifications.pqrs.org/#caps_lock_magic) | [Github Repo](https://github.com/miozus/CapslockMagic) | [Gitee Repo](https://gitee.com/miozus/CapslockMagic)
>
> Make Capslock Great Three!
> 
> <a href="https://github.com/thqby/AutoHotkey_H"> <img src="https://img.shields.io/badge/AutoHotkey__H-thqby-orange?style=flat&logo=GitHub"></a> <a href="https://github.com/miozus/CapslockMagic"> <img src="https://img.shields.io/badge/CapslockMagic-1.4.9-brightengreen?style=flat&logo=ClickUp"></a> <a href="https://jq.qq.com/?_wv=1027&k=iiuN83v3"> <img src="https://img.shields.io/badge/QQ群-1026918136-yellow?style=flat&logo=TencentQQ"></a>


**Capslock Magic 是一套跨平台、跨应用的键映射的解决方案，它将 ⇪ CapsLock（大写锁定键）改造为一个强力的功能修饰键（✱ Hyper ），还改造了 <kbd>3</kbd> <kbd>4</kbd> <kbd>;</kbd> 按键，拓展日常功能。奇迹般地提高操作效率与生产力。**

**它积极响应变化，保持源码随时可改，引导你进化出合适的自己的快捷键风格。**


#### 进化史

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
