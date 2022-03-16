#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;=====================================================================o
;                    Notion
;-------------------------------------------------------------------o
; 功能： 1.粘贴代码，或并选择对应的高亮语言，或追加相对路径作补充说明；
;       2.粘贴折叠块，制作网址收藏，或粘贴报错信息
; 作者：查理
; 时间：2021年8月26日
;
;   键\修饰	       ✱	                    ⌘	                   ⌃
;     F1	     Java	                 JavaScript              JSON
;     F2	     XML	                 YAML
;     F3	     HTML	                 Bash
;     1	     pasteCodeByIndentLevel  pasteRelativePathByLastIDE
;     2	     refBookmark
;     3	     pasteRedError
;     4	     increLevel              decreLevel
;     5	     runCurrentTest          autoCommentJavadoc  pasteToggleByVscode
;-------------------------------------------------------------------o
; Config
global INDENT_LEVEL := 0
;-------------------------------------------------------------------o
; Paste with code languge style
CapsLock & F1::
    if GetKeyState("alt") == 1
    {
        pasteCodeAs("JavaScript")
    }else if GetKeyState("ctrl") = 1 {
        pasteCodeAs("JSON")
    } else {
        pasteCodeAs("Java")
    }
return
;-------------------------------------------------------------------o
CapsLock & F2::
    if GetKeyState("alt") == 0
    {
        pasteCodeAs("XML")
    } else {
        pasteCodeAs("YAML")
    }
return
;-------------------------------------------------------------------o
CapsLock & F3::
    if GetKeyState("alt") == 0
    {
        pasteCodeAs("HTML")
    } else {
        pasteCodeAs("Bash")
    }
return
;-------------------------------------------------------------------o
; Code Paste+tab*0
CapsLock & 1::
    if GetKeyState("alt") == 0
    {
        pasteCodeByIndentLevel()
    } else {
        pasteRelativePathByLastIDE()
    }
return
;-------------------------------------------------------------------o
; Ref Bookmark
CapsLock & 2::
    send, ^+7
    send, {Text}参考
    send, {Enter}
    send, ^v
    send, {Down}
    send, {Enter}
return
;-------------------------------------------------------------------o
; Paste with Red Error toggle or clipboard tag
CapsLock & 3::
    if GetKeyState("alt") = 0
    {
        pasteToggleStartWith()
    } else {
        pasteToggleStartWith("🐞")
    }
return
;-------------------------------------------------------------------o
; Remeber what INDENT_LEVEL you will use
CapsLock & 4::
    ; Reload this ahk will reset to 0
    if GetKeyState("alt") = 1 {
        INDENT_LEVEL -= 2
    } else if GetKeyState("ctrl")  = 1 {
        INDENT_LEVEL--
    } else {
        INDENT_LEVEL += 2
    }
    ; except negative number
    if INDENT_LEVEL < 0 
    {
        INDENT_LEVEL := 0
    }
    ToolTip, % INDENT_LEVEL
return
;-------------------------------------------------------------------o
pasteToggleByVscode(lines)
{ WinActivate, ahk_exe Notion.exe sleep, 100
    ; Steps:
    ; /^\d[ ]/           -> "### "
    ; /^(\d[\.]|\d[ ])+/ -> ""
    ; 1) contenxt -> txt -> vscode(regex, replace format)
    ; 2) Notion: > toggele mode with Empty title (Enter)
    ; 3) AHK: call this with loop, counts lines, cursor on zero line
    loop, % lines {
        send, !{Tab}
        sleep, 200
        send, {down}
        send, yy
        sleep, 200
        WinActivate, ahk_exe Notion.exe
        send, ^v
        sleep, 50
        send, {Enter}
    }
}
;-------------------------------------------------------------------o
pasteCodeByIndentLevel()
{
    ToolTip, % INDENT_LEVEL
    send, ^+8
    send, ^v
    send, ^a
    loop, % INDENT_LEVEL {
        send, +{Tab}
    }
    send, ^!m
}
;-------------------------------------------------------------------o
pasteCodeAs(language)
{
    pasteCodeByIndentLevel()
    sleep, 200
    send, ^/
    sleep, 300
    sendInput, % language
    sleep, 700
    if (hasIME()=1) {
        ; 输入法中文状态时
        send, {Enter}
        sleep, 50
    }
    send, {Enter}
}
;-------------------------------------------------------------------o
pasteRelativePathByLastIDE()
{
    ; switch to copy relative path
    send, !{Tab}
    sleep, 500
    send, ^+a
    sleep, 1000
    ; crpa = copy relative path activate at IDEA & vscode
    send, {Text}crpa
    send, {Enter}
    sleep, 25
    WinActivate, ahk_exe Notion.exe
    sleep, 25
    send, ^v
}
;-------------------------------------------------------------------o
pasteToggleStartWith(tag:="null")
{
    ; 默认值留空，则跳过这步；否则按参数打标签;因为非空!=""判断写法总为真
    send, ^+7
    if % tag != "null" {
        sendinput, {text}``%tag%`` :%A_Space%
    }
    send, ^v
    send, {Enter}
}
;-------------------------------------------------------------------o
autoCommentJavadoc(){
    ; Auto line comment with java at notion code
    loop, %INDENT_LEVEL%
    {
        send, {down}{home}
        send, {text}// 
        send, {space}
    }
}