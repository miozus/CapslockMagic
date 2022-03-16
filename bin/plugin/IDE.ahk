SendMode "Input"    ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

;=====================================================================o
;                    I need it 
;=====================================================================o
#Hotif !(WinActive("ahk_exe idea64.exe") or WinActive("ahk_exe Code.exe"))
;---------------------------------------------------------------------o
; 单手操作浏览页面(chrome：编辑网址/下拉菜单)
!d:: PgDn
!e:: PgUp
#Hotif
;---------------------------------------------------------------------o


;=====================================================================o
; #Hotif ideaAct or codeAct or termAct
#hotif WinActive("ahk_exe idea64.exe") or winActive("ahk_exe code.exe") or WinActive("ahk_exe WindowsTerminal.exe")
;---------------------------------------------------------------------o
; VIM 敏感: 自动切换输入法, 输入悬浮框存在时不会切换，Esc 可用来撤回打字拼写的错误
CapsLock::
{
    ; 如果正在打拼音，就不切换输入法
    if isNotTypingPinYin(){
        setIME("EN")
    }
    ; 如果先返回，图片消失了，就检测不到了，所以最后返回
    Send "{Esc}"
}
; 强化复制粘贴，光标只在两处徘徊时
; CapsLock & c::
; {
    ; Send "!{Tab}"
    ; Sleep 50
    ; Send "^v"
; }
#HotIf
;---------------------------------------------------------------------o


;=====================================================================o
#Hotif WinActive("ahk_exe idea64.exe")
;=====================================================================o
LCtrl & \:: javaDocViaMethodLine()

; Leetcode
LWin & h:: Send "{blind!#}^#!o"   ; submit
LWin & f:: Send "{blind!#}^#!t"   ; test
LWin & s:: Send "{blind!#}^#!p"   ; position
LWin & o:: Send "{blind!#}^#!0"   ; colapse
LWin & p:: Send "{blind!#}^#!0"   ; colapse
LWin & c:: batchClearOrFindLog(4)
LWin & v:: batchClearOrFindLog(4, "🔒")
; Lwin & n:: Send "{blind}#!n"   ; next
; #b::^!b    ; jump to implement
CapsLock & b:: Send "{blind}^!b"    ; jump to implement
CapsLock & w:: Send "{blind}^#w"    ; close current tab
CapsLock & 1:: Send "!{F1}1"
CapsLock & 2:: abstractVariable()
; CapsLock & 3::
CapsLock & 4:: runCmdPythonUnittest()

runCmdPythonUnittest() {
    ; command := "E:/miniconda3/envs/autotest/python.exe e:/projects/IdeaProjects/gulimall/selenium/autotest/test/authorize.py"
    python := "E:/miniconda3/envs/autotest/python.exe"
    unittest := " e:/projects/IdeaProjects/gulimall/selenium/autotest/test/" 
    cases := "order_test.py"
    ; Run A_ComSpec " /c " command
    ; ActivateOrRun("", command)
    ; ShellRun(python, unittest)
    Run python unittest cases
    ; tooltip python unittest cases
}


reloadCurrentService() {
    ; 重启当前服务
    Send "!8"
    Sleep 200
    Send "^!c"

}
CapsLock & 5::
{
    ; 热部署
    Send "{blind!}^{F9}"
    Sleep 2500
    activateOrRun("ahk_exe chrome.exe")
    Send "{blind!}{F5}"
    
}
;---------------------------------------------------------------------o
CapsLock & 7:: 
{
    if GetKeyState("Alt") = 1
    {
        eidtVmOptions()
        ; Send "^a^v"
    }
}
CapsLock & x:: Send "{Blind}^{F2}" ; 停止运行当前程序
CapsLock & z:: Send "{Blind}^+c" ; 运行当前上下文的程序
;---------------------------------------------------------------------o
; 根据软件快捷键特性，重写方法: Insert 模式成功率高
CapsLock & .:: 
{
    if GetKeyState("Alt") = 0
        Send "^{Del}" 
    else
    {
        Send "^+{Right}"
        Sleep 50
        Send "{Del}"
    } 
}
;---------------------------------------------------------------------o
CapsLock & n:: 
{
    if GetKeyState("Alt") = 0
        Send "^{BS}" 
    else 
    {
        Send "^+{Left}"
        Sleep 50
        Send "{BS}"
    }
}

; VIM 敏感: 在中文注释、普通模式和插入模式的边界，自动切换输入法
:?*b0:o//::
:?*b0:a//::
:?*b0:i//::
:?*b0://::
{
    setIME("中文")
}
#HotIf
;---------------------------------------------------------------------o
; 当前行直接注释方法名称
; - 免去每次手动跳转到方法
; - 冗余操作：接口也行
javaDocViaMethodLine()
{
    Send "{Text}^2W"
    Send "{Blind}^\"
    Send "{Text}B"
    Send "{Blind}^\"
}
; r寄存器：强化提取变量
abstractVariable(){
    send "{Blind}!{Enter}"
    sleep 500  
    send "va{Enter}" ; 提取变量
    send "{Enter}"
    sleep 50  
    send "{Enter}"
    send "{Esc}"
    send '{Text}^W"rywo' ; vim：复制变量，另起一行
}


;=====================================================================o
#Hotif WinActive("ahk_exe Code.exe")
;---------------------------------------------------------------------o
; VIM 敏感: 在中文注释、普通模式和插入模式的边界，自动切换输入法
;djdjfdsdjdk;dfsjl
; djsl 
:*?b0:o;::
:*?b0:a;::
:*?b0:i;::
:*?b0:;::
{
    setIME("中文")
}
; ElasticSearch Plugins like kibana
; CapsLock & 5:: Send "^#!{Enter}"  ; Run Query
; CapsLock & 5:: Send "^+{F5}"  ; Run Query
; CapsLock & b:: saveRestAPI()
#Hotif
;---------------------------------------------------------------------o


;=====================================================================o
#Hotif WinActive("ahk_exe Postman.exe")
;---------------------------------------------------------------------o
CoordMode "Mouse", "Window"
CapsLock & b::
{
    ; 保存结果为样本
    Click "1138 690 1"
    Click "1123 730 1"
}
#Hotif 
;---------------------------------------------------------------------o

;=====================================================================o
#Hotif WinActive("ahk_exe chrome.exe")
;=====================================================================o
CapsLock & 2:: focusPasteElementByIdeavim()
#Hotif

;=====================================================================o
#Hotif WinActive("ahk_exe switcheroo.exe")
;---------------------------------------------------------------------o
; 选择第 n 个显示标签的窗口; 配合字母检索 + 数字，起飞！
1:: selectWin(1)
2:: selectWin(2)
3:: selectWin(3)
4:: selectWin(4)
5:: selectWin(5)
;---------------------------------------------------------------------o
selectWin(index:=1){
    index--
    Send "{Down " index "}"
    Send "{Enter}"
}
#Hotif
;---------------------------------------------------------------------o


;=====================================================================o
;                    Code Macro
;---------------------------------------------------------------------o
trimTitleNumber() {
    Send "^#r"
    Send "!r"         ; activate regex
    Sleep 100
    Send "{text}^(\d+[\.\s]+)+"  ; always lose
    Send "{Tab}"
    Send "{LShift down}{Home}{LShift up}{Del}"
    Sleep 100
    Send "^!{Enter}"
    Send "{Esc}"
    Sleep 200
}
;---------------------------------------------------------------------o
saveRestAPI()
{
    ; 充分利用 VIM 特性,自动保存接口结果
    ; 正则匹配大写的方法,用 nN 切换, ? 逆向查找 n
    ; s?^[PGD]
    Send "{Esc}"
    Sleep 100
    Send "{text}wly$"
    Send "^2"
    Sleep 100
    Send "^s"
    Sleep 100
    Send "!1"
    Sleep 100
    Send "{F2}"
    Send "^v"
}
;---------------------------------------------------------------------o


;=====================================================================o
;                    Idea Macro
;---------------------------------------------------------------------o
batchClearOrFindLog(threadCount:=1, keyword :="null" )
{
    Loop threadCount
    {
        Send "{Tab}"
        if (keyword != "null")
        {
            Send "^f"    
            Send keyword
        } else {
            Send "^#+d"   ; clear all
        }
        Send "!8"
        Send "!8"
        Sleep 250
        if (keyword != "null")
        {
            Send "{Up}"
        } else {
            Send "{Down}"
        }
        Sleep 200
    }
}
;---------------------------------------------------------------------o
eidtVmOptions(){
    Send "!+e"
    Sleep 200
    Send "!v"
    Sleep 50
    Send "+{Enter}"
}
;---------------------------------------------------------------------o
focusPasteElementByIdeavim() {
    Send "{Blind}^c"
    Send "{Blind}^v"
    ; Send "{Blind}!{Tab}"
    ActivateOrRun("ahk_exe idea64.exe")
    Sleep 100
    Send "{Blind}/"
    Send "{Blind}^r"
    Send "{Blind}{+}"
    Send "{Blind}{Enter}"
}

