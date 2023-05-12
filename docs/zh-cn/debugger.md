# 🦉 V1.2.0 单手调试器

![debugger](../img/debug-keyboard.png)

封装了 JetBrains Intellij Idea 键位映射风格的调试快捷键。按下组合键后，它先自动激活 Idea 窗口（如有，没有则作罢），通过快捷键，触发对应的功能。

- 进入（二选一）
    - 按住生效：按住数字键 <kbd>4</kbd> 不松手
    - 猴子输入法 <kbd>;</kbd> `dbg` 开启禅模式
- 退出
    - 主动：<kbd>Esc</kbd>
    - 被动：<kbd>A</kbd> <kbd>I</kbd> <kbd>O</kbd> <kbd>S</kbd> 增删改代码时，或 <kbd>␣</kbd> 打开调试计算器时默默退出

特别地，同时按下（第三个键） <kbd>Ctrl</kbd> 键，左上角按键都获得增强功能。


#### 示例

- 按下 <kbd>4</kbd> + <kbd>1</kbd> ，触发 `stepOver` 快捷键，程序执行当前语句，高亮下一行语句。
- 按下 <kbd>4</kbd> + <kbd>3</kbd> ，触发 `resume` 快捷键，程序放行当前断点，执行到下一个断点。
- 按下 <kbd>4</kbd> + <kbd>5</kbd> ，触发 `hotspot` 快捷键，执行 Jrebel 热部署的编译功能，相当于按下小斧头。

