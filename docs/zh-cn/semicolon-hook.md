# ; 分号特殊符（特舒服）

![分号特殊符](../img/semicolon-keyboard.png)

按住分号 <kbd>;</kbd> **不松手**，进入“分号特殊符模式”，同时轻敲 <kbd>第二个键</kbd> ，实际输出对应键位上方的字符。松开 <kbd>;</kbd> 立即退出。

#### 示例

<kbd>;</kbd> + <kbd>a</kbd> 实际输出 <kbd>*</kbd>

### 设计思路

这样排布设计来自咸鱼阿康， 我们都用 Vim，所以本人优化的方向，也在于提升 Vim 体验。

#### 1. 元素定位

- <kbd>H</kbd> `%` 定位括号：修改函数参数。
- <kbd>J</kbd> `;` 定位上个操作位置，使用频繁高。
- <kbd>K</kbd> `` ` `` 反引号常用来写文档，引用代码。
- <kbd>L</kbd> `"` 定位字符串，天天见。因为占用了分号键，就让邻居顺便补偿给它。
- <kbd>E</kbd> `^` <kbd>U</kbd> `$` 定位语句开头/末尾，注意观察数字键上 Vim
  和正则表达式，对于前后的按键刚好反过来。这太反人类了!因为这个设定折磨我太久，所以使用分号模式时仿佛看到沙漠绿洲。
- <kbd>B</kbd> `{` 定位大括号内，bracket 原生操作大小括号，放在一起。 <kbd>;</kbd> <kbd>shift</kbd> <kbd>B</kbd> = `)`
- <kbd>Q</kbd> `(` 定位小括号内  <kbd>;</kbd> <kbd>shift</kbd> <kbd>Q</kbd> = `}`
- <kbd>Y</kbd> `@` 执行宏，小技巧常用 `qq` 开启记录，左右搭配。也不至于误触。

#### 2. 游戏见闻

- <kbd>N</kbd> `-` <kbd>M</kbd> `+` 我玩游戏发现的，物品计数器左边小右边大，符合直觉。
- <kbd>S</kbd> <kbd>E</kbd> <kbd>D</kbd> <kbd>F</kbd> 看上去正好像方向键 `<` `^` `>`
  左手刚好放在热键区。我思考过，游戏中左手默认方向键 <kbd>W</kbd> <kbd>A</kbd> <kbd>S</kbd> <kbd>D</kbd>
  是因为小拇指可以方便按修饰键，太浪费了。

#### 3. 单词缩写

- <kbd>V</kbd> `|` Vertical 垂直线，V 字母从中间对称分开，V 键大概在键盘的中央（<kbd>;</kbd> <kbd>shift</kbd> <kbd>V</kbd>
  组合键映射为中文顿号 `、` ）。
- <kbd>T</kbd> `~` Tide 波浪线（<kbd>;</kbd> <kbd>shift</kbd> <kbd>T</kbd> 组合键映射为 4 个空格）。
- <kbd>C</kbd> `.` comma / dot / period 点。这里按两个键映射一个键的原因，一是可用脚本保证必须输出英文字符，不受中文句号影响；二是
  JQ 元素定位类语法 `$.` 的连击。
- <kbd>X</kbd> `_` Xia Hua Xian 下划线。
- <kbd>G</kbd> `!` Gan Tan Hao 感叹号。
- <kbd>D</kbd> `=` Deng Hao 等号。

#### 4. 常用操作

- <kbd>Z</kbd> 撤销操作：如果打错字或误删，撤销就好了。
- <kbd>O</kbd> 切换输入法：能不用手掌按 <kbd>Ctrl</kbd> 键，就不要去按了，让双手保持在热键区。

