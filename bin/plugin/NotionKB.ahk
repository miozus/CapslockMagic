#Include impl\Notion.ahk

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
; 鼠标前进和后退
XButton1:: ^[
XButton2:: ^]

; format
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
^o:: Notion.cursorCallBack()
#Hotif
;---------------------------------------------------------------------o