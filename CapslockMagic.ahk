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
;                                                        Author: miozus
;                                       AHK version: thqby/AutoHotkey_H


SendMode "Input"             ; 速度快
SetWorkingDir A_ScriptDir    ; 当前脚本目录，就是脚本运行目录
InstallKeybdHook             ; 无条件安装键盘钩子,防止丢失
DetectHiddenWindows True     ; 虚拟桌面：打开检测隐藏窗口


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
#Include data\Program.ahk
#Include bin\util\Common.ahk
#Include bin\util\UserDictUtil.ahk
#Include bin\util\Animation.ahk
#Include bin\util\Dotfiles.ahk
#Include bin\CapsLockEnhancement.ahk
#Include bin\DigitKeyboard.ahk
#Include bin\DebugKeyboard.ahk
#Include bin\InputMethodEditor.ahk
#Include bin\MouseController.ahk
#Include bin\SemicolonHook.ahk
#Include bin\plugin\GarbageCollector.ahk
#Include bin\plugin\IDE.ahk
#Include bin\plugin\Notion.ahk
#Include bin\plugin\Vim.ahk
#Include bin\MoomWinManager.ahk


;=====================================================================o
;                      Application

; a = appearence | window | shot
CapsLock & a::
{
    ; 魔鬼逻辑：当前{}大括号内，caps+a永远为按下，方法内无法修改此前提
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


; d = database | api docs
CapsLock & d::
{
    if GetKeyState("Alt")
    {
        Launcher.apifox.run()
    } else if GetKeyState("Ctrl")
    {
        Launcher.redisManager.run()
    } else
    {
        Launcher.navicat.run()
    }
}

; f = find | search cabinet
CapsLock & f::
{
    if GetKeyState("Ctrl") {
        Launcher.explorer()
    }
    else {
        Launcher.everything()
    }
    IME.set("EN")
}

; g = google
CapsLock & g::
{
    if GetKeyState("Alt")
    {
        Launcher.Chrome.searchSelected()
    }
    else
    {
        Launcher.Chrome.run()
    }
}

; e = editor
CapsLock & e::
{
    if GetKeyState("Alt")
    {
        Launcher.drawio()
    }
    else {
        Launcher.notion()
    }
}

; r = run | develop | java | back-end
CapsLock & r::
{
    if GetKeyState("Ctrl")
    {
        Launcher.Uniapp.activate()
    }
    else if GetKeyState("LWin") {
        Launcher.jmeter()
    }
    else if GetKeyState("Alt")
    {
        Launcher.todesk.run()
    } else {
        Launcher.Idea.activate()
    }
}

; t = terminal | develop | front-end
CapsLock & t::
{
    if GetKeyState("Ctrl")
    {
        Launcher.WxDevTools.activate()
    }
    else if getKeyState("Alt")
    {
        Launcher.Tabby.run()
    }
    else if getKeyState("LWin")
    {
        Launcher.hwMirror()
    }
    else
    {
        Launcher.Vscode.run()
    }
}


;=====================================================================o
;                    DevUtil
; !0:: Location.getMousePosCode()
; 看电视
CapsLock & 8:: Send "{Media_Play_Pause}"

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
    Launcher.ditto()
}

; y = why | reload script 脚本暂停标记，至少留一组快捷键控制脚本重启
#SuspendExempt
CapsLock & y::
{
    ; 设计悬浮动画，再重载本脚本，因为重载太快，后面很难放出来
    if WinActive("ahk_exe Code.exe")
    {
        Send "{Esc}"    ; 奇怪的动作，可能为了保持干净工作台
        Send "^s"    ; 合并动作常用
    }
    Reload
}

; 停用脚本
SuspendScript() {
    Suspend
    Animation.switchTrayIcon()
}