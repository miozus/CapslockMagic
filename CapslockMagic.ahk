;=====================================================================o
;                                                              
; 
;  ▄████▄   ▄▄▄       ██▓███    ██████  ██▓     ▒█████   ▄████▄   ██ ▄█▀
; ▒██▀ ▀█  ▒████▄    ▓██░  ██▒▒██    ▒ ▓██▒    ▒██▒  ██▒▒██▀ ▀█   ██▄█▒ 
; ▒▓█    ▄ ▒██  ▀█▄  ▓██░ ██▓▒░ ▓██▄   ▒██░    ▒██░  ██▒▒▓█    ▄ ▓███▄░ 
; ▒▓▓▄ ▄██▒░██▄▄▄▄██ ▒██▄█▓▒ ▒  ▒   ██▒▒██░    ▒██   ██░▒▓▓▄ ▄██▒▓██ █▄ 
; ▒ ▓███▀ ░ ▓█   ▓██▒▒██▒ ░  ░▒██████▒▒░██████▒░ ████▓▒░▒ ▓███▀ ░▒██▒ █▄
; ░ ░▒ ▒  ░ ▒▒   ▓▒█░▒▓▒░ ░  ░▒ ▒▓▒ ▒ ░░ ▒░▓  ░░ ▒░▒░▒░ ░ ░▒ ▒  ░▒ ▒▒ ▓▒
;   ░  ▒     ▒   ▒▒ ░░▒ ░     ░ ░▒  ░ ░░ ░ ▒  ░  ░ ▒ ▒░   ░  ▒   ░ ░▒ ▒░
; ░          ░   ▒   ░░       ░  ░  ░    ░ ░   ░ ░ ░ ▒  ░        ░ ░░ ░ 
; ░ ░            ░  ░               ░      ░  ░    ░ ░  ░ ░      ░  ░   
; ░                                                     ░               
;
;                                            AHK H-beta.3-fixed.3-thqby
;                                                        Author: miozus

 
SendMode "Input"          ; 速度快
SetWorkingDir A_ScriptDir ; 当前脚本目录，就是脚本运行目录
InstallKeybdHook          ; 无条件安装键盘钩子,防止丢失

;=====================================================================o
;                       CapsLock init


; 全局配置类

; 声明正在使用的中文输入法
; MICROSOFT_PINYIN 微软拼音/搜狗五笔/手心输入法
; QQ_PINYIN        QQ拼音
; OTHER_PINYIN     搜狗拼音/其他
global kImeType := ImeTypeEnum.MICROSOFT_PINYIN
; 鼠标移速
global kMouseMoveSpeedFast := 97
global kMouseMoveSpeedSlow := 11

; 托盘图标
Animation.initTrayIcon()

; Hotkey Register Center
allHotkeys := []
allHotkeys.Push("*;")
allHotkeys.Push("*3")

#Include bin\util\Common.ahk
#Include bin\util\AutoConfiguration.ahk
#Include bin\util\UserDictUtils.ahk
#Include data\UserDictionary.ahk
#Include bin\CapsLockEnhancement.ahk
#Include bin\DigitKeyboard.ahk
#Include bin\InputMethodEditor.ahk
#Include bin\MouseMove.ahk
#Include bin\MoomWinManager.ahk
#Include bin\SemicolonHook.ahk
#Include bin\plugin\GarbageCollector.ahk
#Include bin\plugin\IDE.ahk
#Include bin\plugin\Notion.ahk
#Include bin\plugin\Vim.ahk
; #Include bin\plugin\Premiere.ahk




;=====================================================================o
;                    Copy & Paste Enhancement

; 强化复制粘贴，光标只在两处徘徊时
CapsLock & c::
{
    if !GetKeyState("Alt") {
        Send "^c"
        ClipWait 4
    } else {
        ; 正则去掉换行符号
        A_Clipboard := ""
        Send "^c"
        ClipWait 4
        A_Clipboard := RegExReplace(A_Clipboard, "`r`n")
    }
    Sleep 100
    Send "!{Tab}"
    Sleep 200
    Send "^v"
}

CapsLock & v:: 
{
    ; Ditto
    Send "{blind}^+!b"
}

; 魔法键：因地制宜，每个程序专属技能，默认鼠标返回上个点击位置，需要重写
; CapsLock & b::
; {
    ; switchMousePos("🐱‍👤")
; }

; 看电视
CapsLock & 8:: Send "{Media_Play_Pause}"



;=====================================================================o
;                      Application                          

CapsLock & a:: 
{
    ; 魔鬼逻辑：当前区块内，此键永远为按下，无论方法渗透多深都无法改变
    ; 跳出问题，大括号之外释放热键
    if GetKeyState("LAlt", "p") = 1
    {
        Window.move()
    }
    else if GetKeyState("LWin", "p") = 1
    {
        Mouse.move()
    } 
    else if GetKeyState("LCtrl", "p") = 1
    {
        Window.zoom()
    }
    else {
        return
    }
    GC.ModifyKey()
}

CapsLock & d:: 
{
    if GetKeyState("Alt") = 1 
    {
        path := A_Programs "\Postman\Postman.lnk"
        activateOrRun("ahk_exe Postman.exe", path)
    } else if GetKeyState("Ctrl") = 1
    {
        path := A_Desktop "\RDM.lnk"
        ; path := A_Programs "\RDM\RDM.lnk"
        activateOrRun("ahk_exe rdm.exe", path)
    } else if GetKeyState("LWin") = 1 
    {
        path := A_Programs "\DevDocs.lnk"
        activateOrRun("ahk_exe DevDocs.exe", path)
    }
    else
    {
        if winexist("ahk_exe Photoshop.exe") {
            activateOrRun("ahk_exe Photoshop.exe")
        } else {
            path := A_ProgramsCommon "\PremiumSoft\Navicat 15 for MySQL.lnk"
            activateOrRun("ahk_exe navicat.exe", path)
        }
    }
}

CapsLock & f:: 
{
    if GetKeyState("LWin") 
    {
        path := A_Programs "Apifox.lnk"
        ActivateOrRun("ahk_exe Apifox.exe", path)
    } else if GetKeyState("Ctrl") 
        ; 资源管理器
        activateOrRun("ahk_class CabinetWClass","")
    else {
        ; if not WinExist("ahk_exe Illustrator.exe") {
            ; everything
            Send "{blind}^+!f"
        ; } else {
            ; activateOrRun("ahk_exe Illustrator.exe")
        ; }
    }
    IME.set("EN")
}

CapsLock & g:: 
{
    if GetKeyState("Alt") = 1
    {
        ; 谷歌搜索选中文字
        Send "^c"
        ClipWait 2
        Sleep 50
        Run "https://www.google.com/search?q=" A_Clipboard 
    }
    else
    {
        ; path := A_StartMenuCommon "\Programs\Google Chrome.lnk"
        path := A_AppData "\Microsoft\Internet Explorer\Quick Launch\Google Chrome.lnk"
        activateOrRun("ahk_exe chrome.exe", path)
    }
}
CapsLock & e:: 
{
    if GetKeyState("Alt") == 1
    {
        path := A_Programs "\Microsoft Edge.lnk"
        activateOrRun("ahk_exe msedge.exe", path)
    }
    else {
        path := A_Programs "\Notion Enhanced.lnk"
        activateOrRun("ahk_exe Notion Enhanced.exe", path)
        IME.set("中文")
    }
}

CapsLock & r:: 
{
    if GetKeyState("Alt") = 1 
    {
        path := A_Programs "\JetBrains Toolbox\GoLand.lnk"
        activateOrRun("ahk_exe goland64.exe", path)
        ; if winExist("ahk_exe javaw.exe") or winExist("VisualVM 2.1 ahk_exe java.exe")
            ; WinActivate
        ; else
            ; visualvm_21
            ; activateOrRun("Windows PowerShell", "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.6.10571.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe", "E:\Java\visualvm_21\bin\visualvm --jdkhome C:\Users\lss81\.jdks\adopt-openjdk-14.0.2")
    }
    else if GetKeyState("LWin") == 1 {
        ; Apache JMeter
        path :=  "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.6.10571.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe"
        params :=  "E:\Java\apache-jmeter-5.4.1\bin\jmeter.bat -t E:\Java\apache-jmeter-5.4.1\MyTest\谷粒商城压力测试.jmx"
        activateOrRun("Apache JMeter", path, params)
    }
    else if GetKeyState("Ctrl") = 1 
    {
        ; arthas
        path :=  "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.6.10571.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe"
        param :=  "C:\Users\lss81\.jdks\adopt-openjdk-14.0.2\bin\java -jar E:\Java\arthas-packaging-3.5.3-bin\arthas-boot.jar"
        activateOrRun("Windows PowerShell", path, params)
    } else {
        path := A_Programs "\JetBrains Toolbox\IntelliJ IDEA Ultimate Early Access Program.lnk"
        activateOrRun("ahk_exe idea64.exe", path)
    }
}

CapsLock & t:: 
{
    if GetKeyState("Alt") = 1 
    {
        ; path :=  "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.10.2714.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe"
        path := "bin\util\Windows Terminal.lnk"
        activateOrRun("ahk_exe WindowsTerminal.exe", path)

    } 
    else if getKeyState("Ctrl") = 1
    {
        path := A_StartMenuCommon "\Programs\Git\Git Bash.lnk"
        activateOrRun("ahk_exe mintty.exe", path,  "--cd-to-home")
    } 
    else if getKeyState("LWin") = 1
    {
        if WinExist("ahk_exe HwMirror.exe") 
            WinActivate
    } 
    else
    {
        path := A_Programs "\Visual Studio Code\Visual Studio Code.lnk"
        activateOrRun("ahk_exe Code.exe", path)
    }
}

; CapsLock & z::
; {
    ; if getKeyState("Alt") {
        ; DevUtils.getPixelSearchCode()
    ; } else {
        ; DevUtils.getMousePosCode()
    ; }
; }

#SuspendExempt
CapsLock & y:: 
{
    if GetKeyState("Alt")  = 1
    {
        ; Edit this AHK
        path := A_Programs "\Visual Studio Code\Visual Studio Code.lnk"
        activateOrRun("CapslockPlus_V2H ahk_exe Code.exe", path, A_WorkingDir)
    }
    else if GetKeyState("Ctrl") = 1
    {
        SuspendScript()
    }
    else if GetKeyState("LWin") = 1
    {
        ; search for help
        ; Run "https://wyagd001.github.io/v2/docs/AutoHotkey.htm"
        ; Run "D:\TOOLS\AutoHotKey\AutoHotkey_H v2.chm"
        path :=  "D:\TOOLS\AutoHotKey\docs\AutoHotkey_V2L_CN.chm"
        activateOrRun("AutoHotkey v2", path)
        Send "!s^a"
        
    }
    else
    {
        if winExist("ahk_class AutoHotkey")
            WinActivate
        else
        {
            ; 设计悬浮动画，再重载本脚本，因为重载太快，后面很难放出来
            if WinActive("ahk_exe Code.exe")
            {
                Send "{Esc}" ; 奇怪的动作，可能为了保持干净工作台
                Send "^s" ; 合并动作常用
            }
            Reload
        }
    }
}


; 停用脚本
SuspendScript() {
    Suspend
    Animation.switchTrayIcon() 
}

; =====================================================================o
;                      自动优化格式编辑区，快速删除用 vim
; ---------------------------------------------------------------------o