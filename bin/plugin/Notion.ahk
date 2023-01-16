;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode "Input"    ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

;=====================================================================o
;                    Notion
;---------------------------------------------------------------------o
; 功能 1.粘贴代码，或并选择对应的高亮语言，或追加相对路径作补充说明；
;      2.粘贴折叠块，制作网址收藏，或粘贴报错信息
; 作者 知乎 @查理
; 更新
;     2021/08/26 基本框架完成
;     2021/09/18 为适应 68 键，压缩 F1~F3 至 1~3
;     2021/10/17 解锁钩子模式，模块重构，上面功能区，下面接口，上下文管理更加严格
;     
; 键\修饰      ✱	     ^               #             ⌘/!
;  1	 pasteCode     JavaScript       JSON         Java	     
;  2	 refBookmark   YAML             HTML          XML	     
;  3	 pasteToggle   pasteToggle🐞         
;  4	 increLevel    decreLevel
;  5 runCurrentTest pasteToggleByVscode pasteInNotepad commentByDoubleSlash 
;
;---------------------------------------------------------------------o
global INDENT_LEVEL := 0
;---------------------------------------------------------------------o

;=====================================================================o
;#Hotif WinActive("ahk_exe Notion Enhanced.exe")
#Hotif WinActive("ahk_exe notion.exe")
;---------------------------------------------------------------------o
; 复用上次格式样式
; 居然映射成 ESC 和 ^v 这太诡异了; 不要留空格;
CapsLock & b:: Send "{Blind}^+h"
CapsLock & x:: Send "{Blind}{Backspace}"
CapsLock & Space:: Send "{Blind}{Enter}"
; 鼠标前进和后退
XButton1:: ^[
XButton2:: ^]
;---------------------------------------------------------------------o
CapsLock & f::
{
    if GetKeyState("Ctrl") {
        Notion.switchCodeAsFormat("Java")
    } else if GetKeyState("Alt") {
        Notion.editCaption()
    } else {
        Notion.cleanVariableFormat()
    }
}

CapsLock & s::
{
    if GetKeyState("Alt") {
        Send "{Blind!}^+7"
    } else {
        Send "{Blind!}^+5"
    }
}
CapsLock & 1::
{
    if GetKeyState("Alt") {
        Notion.pasteCodeAs("Java")
    } else if GetKeyState("LWin") {
        Notion.pasteCodeAs("JSON")
    } else if GetKeyState("Ctrl") {
        Notion.pasteCodeAs("JavaScript")
    } else {
        ; Code Paste+tab*0
        Notion.pasteCode()
    }
}
;---------------------------------------------------------------------o
; Ref Bookmark
CapsLock & 2::
{
    if GetKeyState("Alt") {
        Notion.pasteCodeAs("XML")
    } else if GetKeyState("LWin") {
        Notion.pasteCodeAs("HTML")
    } else if GetKeyState("Ctrl") {
        Notion.pasteCodeAs("YAML")
    } else {
        Notion.refBookmark()
    }
}
;---------------------------------------------------------------------o
; Paste with Red Error toggle or clipboard tag
CapsLock & 3::
{
    if GetKeyState("Alt") = 0
    {
        Notion.pasteToggleStartWith()
    } else {
        Send "{Enter}"
        Send "{BS}"
        Notion.pasteToggleStartWith("🐞")
    }
}
;---------------------------------------------------------------------o
; Remeber what INDENT_LEVEL you will use
CapsLock & 4::
{
    global INDENT_LEVEL 
    ; Reload this ahk will reset to 0
    if GetKeyState("Alt") = 1 {
        INDENT_LEVEL -= 2
    } else if GetKeyState("Ctrl")  = 1 {
        INDENT_LEVEL--
    } else {
        INDENT_LEVEL += 2
    }
    ; except negative number
    if INDENT_LEVEL < 0 
    {
        INDENT_LEVEL := 0
    }
    ToolTip INDENT_LEVEL
    SetTimer () => ToolTip(), -1000
}
;---------------------------------------------------------------------o
CapsLock & 5:: Notion.commentByDoubleSlash()
LAlt & v:: Notion.pasteCodeSingleLine()
#Hotif
;---------------------------------------------------------------------o

;---------------------------------------------------------------------o

class Notion {
    
    static editCaption() {
        Send "{Blind!}^!m"
    }

    static refBookmark()
    {
        ; Send "^+7"
        ; Send "{Text}参考"
        ; Send "{Enter}"
        Send "^v"
        Send "{Down}"
        Send "{Enter}"
        Sleep 100
        this.editCaption()
    }

    static pasteCode()
    {
        Send "{Blind!#+}^+8"
        Send "{Blind!#+}^v"
        Send "{Blind!#+}^a"
        Send "+{Tab " INDENT_LEVEL "}"
        Send "^!m"
    }

    static pasteCodeAs(language)
    {
        ToolTip "⇤ " INDENT_LEVEL
        Notion.pasteCode()
        Sleep 200
        Send "{blind!#}^/"
        Sleep 300
        Send language
        Sleep 700
        if (IME.exists() = 1) {
            ; 输入法中文状态时
            Send "{Enter}"
            Sleep 50
        }
        Send "{Enter}"
        SetTimer () => Tooltip(), -1000
    }

    static pasteRelativePathByLastIDE()
    {
        ; switch to copy relative path
        Send "!{Tab}"
        Sleep 500
        Send "^+a"
        Sleep 1000
        ; crpa = copy relative path activate at IDEA & vscode
        Send "{Text}crpa"
        Send "{Enter}"
        Sleep 25
        WinActivate "ahk_exe Notion.exe"
        Sleep 25
        Send "^v"
    }

    static pasteToggleStartWith(tag:="null")
    {
        ; 默认值留空，则跳过这步
        ; 否则按参数打标签;因为非空!=""判断写法总为真
        ; 诡异机制，变量抢先于字符串输出了，只有加 50 延迟区分出来
        Send "^+7"
        if tag != "null" {
            Send "{Text}" tag
            Sleep 50
        }
        Send "^v"
        Send "{Enter}"
    }

    static commentByDoubleSlash(){
        ; Auto line comment with java at Notion code
        Loop INDENT_LEVEL
        {
            Send "{down}{home}"
            Send "{text}// " 
        }
    }

    static cleanVariableFormat() {
        Send "{Blind}{LButton}"
        Send "{Blind}^a^e^e^b^b^i^i"
    }
    static switchCodeAsFormat(language) {
        Send "{Blind^}{LButton}"
        Send "{blind!#}^/"
        Sleep 50
        Send "{Text}" language
        Sleep 700
        Send "{Enter}"

    }

    static pasteCodeSingleLine(){
        Send "{Bind!}^v"
        Sleep 50
        Send "{Bind!}{BackSpace}"
        Send "{Bind!}{Home}" ; 删除头部空白
        Send "{Bind!}^{Right}"
        Send "{Bind!}^{Left}"
        Send "{Bind!}^{BackSpace}"
        Send "{Bind!}{End}{Enter}{Tab}" ; 另一一行
        ; Send "{Bind!}^{Tab}" ; 中文注释
    }
}