# 手摸手教你 1 分钟添加一个猴子词条之魔法命令

刚才是静态的指令，这个是动态的。

> 需求背景：我在写 vue2 页面，每次绑定点击事件 `@click=clickMethod`，新增函数需要定位到 methods 的部分，再手写函数，写多了，我突然想到，可以将这个过程保存为“编写方法”的快捷键操作。

### 1. 给魔法起名字

手动打开 （或在vscode使用 <kbd>␣</kbd> <kbd>e</kbd> 搜索 monkey）`\bin\MonkeyIME.ahk` ，在最后的条件分支，再添加新的分支

```autohotkey
; 原文
...
case "vv": Vim.find("view")

; 添加（im = implement）
case "im": Vim.implement()  
```

### 2. 实现魔法

此时打开 `\bin\util\Vim.ahk` (或者光标移动到 Vim.`find` 按快捷键 <kbd>␣</kbd> <kbd>d</kbd> 跳转实现类文件) , 然后根据实际需要实现脚本

```
class Vim {
    
    ; 剪切板的单词，填写到 methods 下面
    static implement() {
        this.find("methods")
        Send "{Esc}"
        SendText "o"
        SendText A_Clipboard '(){},'
    }

}
```

### 3. 注册魔法

因为跨软件全局通用的功能，要特别谨慎，注册后生效，顺便解释其含义，避免长时间遗忘了。

打开文件 `\bin\data\dict_secret.ahk` 

```autohotkey
    "vv", "view",
    ; 新增下面一行即可
    "im", "implement",
```

按下 <kbd>Caps</kbd> + <kbd>Y</kbd> 刷新，使用最新更改的文件。

### 4.使用魔法

到业务场景中，按下 <kbd>;</kbd> <kbd>i</kbd> <kbd>m</kbd> 看看效果吧

> 刚开始魔法出现意想不到的效果，试着在实现功能的脚本中，增加 `Sleep 1000` 语句，减速整个过程，查看是哪里衔接有问题。

```autohotkey

  ; 失败1: 按o换行未生效，尝试增加按o后的延迟 50ms
  markertap(){},methods: {

  ; 失败2：成功率提高，但会打乱原代码，尝试增加按o前延迟 100ms
  methmarkertap(){},ods: {
    
    markertap(){},
    markertap(){},
    
  ; 失败3：剪切板正常，但粘贴有时为空，尝试增加剪切板前延迟 150ms
    markertap(){},methods: {
    
    markertap(){},
    
  ; 失败4：粘贴之后出现误触，尝试增加粘贴后，按Esc返回普通模式
    methods: {
    markertap(){},/
    markertap(){},
    ds/
    ds

  ; 成功率提高，尝试减少衔接的延迟并不断重试...

```

最终定稿

```autohotkey

class Vim {
    
    ; 剪切板的单词，填写到 methods 下面
    static implement() {
        this.find("methods")
        Send "{Esc}"
        Sleep 50
        SendText "o"
        Sleep 100
        SendText A_Clipboard '(){},'
        Sleep 50
        Send "{Esc}"
    }

}
```

这样一个跨应用的猴子词条就完成了。后面想到新的细节，再完善它。