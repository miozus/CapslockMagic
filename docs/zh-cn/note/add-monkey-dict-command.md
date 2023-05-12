# 手摸手教你 1 分钟添加一个猴子词条之快捷短语

最简单的 `语法嗅探` 词条，打开 `\bin\data\dict\dict_xxx.ahk` 新增一条映射关系就可以了。例如增加 emoji 表情

```autohotkey

emojiDict := Map(
    ...
    ; 新增
    "gzh", "⛩️", ; 公众号
    "xcx", "🐣", ; 小程序
)

```

按下 <kbd>Caps</kbd> + <kbd>Y</kbd> 刷新，使用最新更改的文件。

按下 <kbd>;</kbd> <kbd>g</kbd> <kbd>z</kbd> <kbd>h</kbd> 看看魔法的效果吧。

> 注意： 如果添加新的词典分类文件 `dict_xxx.ahk`，请在 `UserDictionary.ahk` 使用`#Include` 语法引用进来。