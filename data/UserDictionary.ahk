;=====================================================================o
;
;   userDict
;
;   密令（key）命名规则：小鹤双拼四字母 / 单词或语句首字母 
;   使用方法：轻按分号键 ; 显示窗口，输入密令（key）

; 猴子词典分类
#Include ./dict/secret.ahk
#Include ./dict/emoji.ahk
#Include ./dict/logo.ahk
#Include ./dict/private.ahk
#Include ./dict/terminal.ahk
#Include ./dict/computer.ahk
; 转换工具
#Include ../bin/util/UserDictUtil.ahk

global userDict := DictUtil.concat([emojiDict, computerDict, privateDict, logoDict, terminalDict])

; 真实案例：猴子词典转换为第三方输入法词库的代码
; global macDictionary := UserDict.concat([emojiDict, computerDict, privateDict, logoDict])

; CapsLock & 9:: 
; {
    ; 猴子词典 -> 苹果词典
    ; Converter.convert(macDictionary, DictTypeEnum.MAC)

    ; 猴子词典 <- 苹果词典（弹窗选择文件）
    ; Converter.parse()

    ; 猴子词典 <- 苹果词典（文件目录，可选） 
    ; fileDir := "./dist/userdict4macos.plist"
    ; Converter.parse(fileDir)

; }


