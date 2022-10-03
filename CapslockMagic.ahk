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
; 全局配置
;
; 声明正在使用的中文输入法类型
; ---
; - MICROSOFT 微软拼音/搜狗五笔/手心输入法
; - QQ        QQ拼音
; - OTHER     搜狗拼音/其他
global kImeType := PinYinEnum.MICROSOFT
; 鼠标移速
global kMouseMoveSpeedFast := 97
global kMouseMoveSpeedSlow := 11
; 是否开启输入法保证中文标点[，。：？] 但分号特殊符不受影响，仍是英文标点
global EnableChinesePunctuation := true


;=====================================================================o
;                       CapsLock init
; 托盘图标
Animation.initTrayIcon()

; Hotkey Register Center
allHotkeys := []
allHotkeys.Push("*;")
allHotkeys.Push("*3")
allHotkeys.Push("*4")

#Include data\UserDictionary.ahk
#Include bin\util\Common.ahk
#Include bin\util\UserDictUtil.ahk
#Include bin\util\Animation.ahk
#Include bin\util\Dotfiles.ahk
#Include bin\util\Location.ahk
#Include bin\CapsLockEnhancement.ahk
#Include bin\DigitKeyboard.ahk
#Include bin\InputMethodEditor.ahk
#Include bin\MouseController.ahk
#Include bin\MoomWinManager.ahk
#Include bin\SemicolonHook.ahk
#Include bin\plugin\DebugKeyboard.ahk
#Include bin\plugin\GarbageCollector.ahk
#Include bin\plugin\IDE.ahk
#Include bin\plugin\Notion.ahk
#Include bin\plugin\Vim.ahk
#Include bin\plugin\Seeyon.ahk
 



;=====================================================================o
;                    DevUtl
!0:: Location.getMousePosCode()

;=====================================================================o
;                    Copy & Paste Enhancement
; c = copy
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


; v = paste | clipboard
CapsLock & v:: 
{
    ; Ditto
    ; Send "{blind}^+!b"
    App.Ditto.active()
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


; 应用魔法值（枚举类）：管理软件自定义快捷键
class App {
    
    class Everything {
        static active() {
            Send "{blind}!+f"
        }
    }

    class Ditto {
        
        static active() {
            Send "{blind}^+!b"
        }

        static paste(index) {
            Send "{Blind}^+!" index
        }
    }
    
    class Java {
        static JDK := "C:\Users\miozus\.jdks\jdk1.8.0_202\bin\java"
    }

}

; a = appearence | window | shot 
CapsLock & a:: 
{
    ; 魔鬼逻辑：当前区块内，此键永远为按下，无论方法渗透多深都无法改变
    ; 跳出问题，大括号之外释放热键
    if GetKeyState("LAlt", "p") {
        Window.move()
    }
    else if GetKeyState("LWin", "p") {
        Mouse.move()
    } 
    else if GetKeyState("LCtrl", "p") {
        Window.zoom()
    }
    else {
        return
    }
    GC.ModifyKey()
}

; shot 2 text
<!+a::
{
    python3 := "E:\miniconda3\envs\textshot\pythonw.exe"
    textshot := " E:\projects\Python\textshot\textshot.py"
    args := " chi_sim+eng" ; 优先简体中文，其次英文
    ; args := " chi_sim"
    ShellRun(python3, textshot args)
}

; d = database | api docs
CapsLock & d:: 
{
    if GetKeyState("Alt")  
    {
        path := A_Programs "\Apifox.lnk"
        ActivateOrRun("ahk_exe Apifox.exe", path)
        ; path := A_Programs "\Postman\Postman.lnk"
        ; activateOrRun("ahk_exe Postman.exe", path)
    } else if GetKeyState("Ctrl") 
    {
        path := A_Desktop "\Another Redis Desktop Manager.lnk"
        ; path := A_Programs "\RDM\RDM.lnk"
        activateOrRun("ahk_exe Another Redis Desktop Manager.exe", path)
    } else if GetKeyState("LWin")  
    {
        path := A_Programs "\DevDocs.lnk"
        activateOrRun("ahk_exe DevDocs.exe", path)
    }
    else
    {
        path := A_ProgramsCommon "\PremiumSoft\Navicat Premium 16.lnk"
        activateOrRun("ahk_exe navicat.exe", path)
    }
}

; f = find | search cabinet
CapsLock & f:: 
{
    if GetKeyState("Ctrl") 
        ; 资源管理器
        activateOrRun("ahk_class CabinetWClass","")
    else {
        ; if not WinExist("ahk_exe Illustrator.exe") {
            ; everything
            App.Everything.active()
        ; } else {
            ; activateOrRun("ahk_exe Illustrator.exe")
        ; }
    }
    IME.set("EN")
}

; g = google
CapsLock & g:: 
{
    if GetKeyState("Alt") 
    {
        ; 谷歌搜索选中文字
        Send "^c"
        ClipWait 2
        Sleep 50
        Run "https://www.google.com/search?q=" A_Clipboard 
    }
    else
    {
        path := A_AppData "\Microsoft\Internet Explorer\Quick Launch\Google Chrome.lnk"
        activateOrRun("ahk_exe chrome.exe", path)
    }
}

; e = editor
CapsLock & e:: 
{
    if GetKeyState("Alt") 
    {
        ; path := A_Programs "\Microsoft Edge.lnk"
        ; activateOrRun("ahk_exe msedge.exe", path)
        path := "E:\seeyon\project\安顺市平坝区煤矿企业产销量综合监管平台项目\UML\协同分析业务流程设计稿.drawio"
        activateOrRun("ahk_exe draw.io.exe", path)
    }
    else {
        path := A_Programs "\Notion Enhanced.lnk"
        activateOrRun("ahk_exe Notion Enhanced.exe", path)
        IME.set("中文")
    }
}

; r = run | develop | java | back-end
CapsLock & r:: 
{
    if GetKeyState("Alt")  
    {
        Seeyon.activeFormDesigner()
        ; path := A_Programs "\JetBrains Toolbox\GoLand.lnk"
        ; activateOrRun("ahk_exe goland64.exe", path)
        ; if winExist("ahk_exe javaw.exe") or winExist("VisualVM 2.1 ahk_exe java.exe")
            ; WinActivate
        ; else
            ; visualvm := "E:\Java\visualvm_21\bin\visualvm"
            ; params := " --jdkhome C:\Users\miozus\.jdks\corretto-1.8.0_322"
            ; activateOrRun(visualvm, "wt.exe " visualvm, params) 
    }
    else if GetKeyState("LWin") {
        ; Apache JMeter
        jmeter := "E:\Java\apache-jmeter-5.4.1\bin\jmeter.bat"
        params := " -t E:\Java\apache-jmeter-5.4.1\MyTest\谷粒商城压力测试.jmx"
        activateOrRun("Apache JMeter", "wt.exe " jmeter, params)
    }
    else if GetKeyState("Ctrl")  
    {
        ; todesk
        ActivateOrRun("ahk_exe ToDesk.exe", "")
        ; arthas
        ; arthas := App.Java.JDK
        ; params :=  " -jar E:\Java\arthas-packaging-3.5.3-bin\arthas-boot.jar"
        ; activateOrRun(arthas, "wt.exe " arthas, params)
    } else {
        ; excel := "ahk_exe EXCEL.EXE"
        ; ActivateOrRun(excel)
        ; if WinExist("ahk_exe goland64.exe") {
            ; activateOrRun("ahk_exe goland64.exe")
        ; } else {

        
        ; ppt := "ahk_exe POWERPNT.EXE"
        ; ActivateOrRun(ppt)

        if WinExist("ahk_exe idea64.exe") {
            path := A_Programs "\JetBrains Toolbox\IntelliJ IDEA Ultimate.lnk"
            activateOrRun("ahk_exe idea64.exe", path)
        }
    }
}

; t = terminal | develop | front-end
    CapsLock & t:: 
{
    if GetKeyState("Alt")  
    {
        ; path := "bin\util\Windows Terminal.lnk"
        ; activateOrRun("ahk_exe WindowsTerminal.exe", path)
        path := "bin\util\Tabby Terminal.lnk"
        activateOrRun("ahk_exe Tabby.exe", path)

    } 
    else if getKeyState("Ctrl") 
    {
        path := A_StartMenuCommon "\Programs\Git\Git Bash.lnk"
        activateOrRun("ahk_exe mintty.exe", path,  "--cd-to-home")
    } 
    else if getKeyState("LWin") 
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


; y = why | reload script 脚本暂停标记，至少留一组快捷键控制脚本重启
#SuspendExempt
CapsLock & y:: 
{
    ; if GetKeyState("Alt")  
    ; {
      ;  ; Edit this AHK
        ; path := A_Programs "\Visual Studio Code\Visual Studio Code.lnk"
        ; activateOrRun("CapslockPlus_V2H ahk_exe Code.exe", path, A_WorkingDir)
    ; }
    ; else if GetKeyState("Ctrl") 
    ; {
        ; SuspendScript()
    ; }
    ; else if GetKeyState("LWin") 
    ; {
     ;;   search for help
     ;;   Run "https://wyagd001.github.io/v2/docs/AutoHotkey.htm"
     ;;   Run "D:\TOOLS\AutoHotKey\AutoHotkey_H v2.chm"
        ; path :=  "tools\AutoHotkey_V2L_CN.chm"
        ; activateOrRun("AutoHotkey v2", path)
        ; Send "!s^a"
        
    ; }
    ; else
    ; {
        ; if winExist("ahk_class AutoHotkey")
        ; {
            ; WinActivate
        ; }
        ; else
        ; {
            ; 设计悬浮动画，再重载本脚本，因为重载太快，后面很难放出来
            if WinActive("ahk_exe Code.exe")
            {
                Send "{Esc}" ; 奇怪的动作，可能为了保持干净工作台
                Send "^s" ; 合并动作常用
            }
            Reload
        ; }
    ; }
}

; 停用脚本
SuspendScript() {
    Suspend
    Animation.switchTrayIcon() 
}