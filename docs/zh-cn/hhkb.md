#  ️🕶️ v1.5.0 HHKB兼容适配

![HHKB-win-keymap](../img/HHKB-win-keymap.png)

> 注意：作者使用 `/tools/reg/switch_keymap_lctrl_lalt.reg` 脚本，将系统键位左下角的 <kbd>Alt</kbd> 和 <kbd>Ctrl</kbd> 互换，最终效果为“空格键相邻左边是 <kbd>Ctrl</kbd> 键”

这样改键，为了兼顾 Mac 习惯，又不失 <kbd>caps</kbd> 常用功能，从普通键盘到 60 配列的 `HHKB` 过渡自然，瞬间适应。

本次版本更新做了代码重构

* X 插件拆分
  - 控制器：X_KB(keyboard)
  - 实现类：impl + interface + common + util

* 移除冷门应用: [爬虫零件箱](https://github.com/miozus/SpiderToolbox) (拆分出去的项目)。

* 增加按键转换注册表脚本，修改映射左侧两键 <kbd>Alt</kbd> <-> <kbd>Ctrl</kbd>

* 修复：检测图片太慢而导致500ms，在 IDE 环境异步进程 200ms 后，自动将设置为英文

