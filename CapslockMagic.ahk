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




;=====================================================================o
;                       CapsLock Global Setting
;
; 我的键盘布局 (HHKB ¯‗¯‗‗‗) ，其实任意键盘都兼容适配
;
; ,-----------------------------------------------------------.
; |Esc|  1|  2|  3|  4|  5|  6|  7|  8|  9|  0|  -|  =| \| `  |
; |-----------------------------------------------------------|
; |Tab  |  Q|  W|  E|  R|  T|  Y|  U|  I|  O|  P|  [|  ]|BackS|
; |-----------------------------------------------------------|
; |Caps  |  A|  S|  D|  F|  G|  H|  J|  K|  L|  ;|  '| Return |
; |-----------------------------------------------------------|
; |Shift   |  Z|  X|  C|  V|  B|  N|  M|  ,|  .|  /|Shift |Fn |
; |-----------------------------------------------------------|
; |    |Alt |Ctrl  |         Space         |Win  |Alt |       |
; `-----------------------------------------------------------'
;
;
SendMode "Input"             ; 速度快
SetWorkingDir A_ScriptDir    ; 当前脚本目录，就是脚本运行目录
InstallKeybdHook             ; 无条件安装键盘钩子,防止丢失
DetectHiddenWindows True     ; 虚拟桌面：打开检测隐藏窗口，自动跳转桌面
;
; 全局配置开始 =============
;
; 鼠标移速
global kMouseMoveSpeedFast := 97
global kMouseMoveSpeedSlow := 11
; 是否开启输入法保证中文标点[，。：？] 但分号特殊符不受影响，仍是英文标点
global EnableChinesePunctuation := true
; 声明正在使用的中文输入法类型
; ---
; - MICROSOFT 微软拼音/搜狗五笔/手心输入法
; - QQ        QQ拼音
; - OTHER     搜狗拼音/其他
global kImeType := PinYinEnum.MICROSOFT

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
#Include data\Application.ahk
#Include data\Website.ahk
#Include bin\common\Common.ahk
#Include bin\util\Animation.ahk
#Include bin\util\Dotfiles.ahk
#Include bin\util\Location.ahk
#Include bin\util\Vim.ahk
#Include bin\CapsLockEnhancement.ahk
#Include bin\DigitKeyboard.ahk
#Include bin\SystemIME.ahk
#Include bin\MouseController.ahk
#Include bin\SemicolonHook.ahk
#Include bin\plugin\DebugKB.ahk
#Include bin\plugin\GarbageKB.ahk
#Include bin\plugin\NotionKB.ahk
#Include bin\plugin\IDEKB.ahk
#Include bin\MoomWinManager.ahk

; 全局配置结束 ===========

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
        App.apifox.run()
    } else if GetKeyState("Ctrl")
    {
        App.redisManager.run()
    } else
    {
        App.navicat.run()
    }
}

; f = find | search cabinet
CapsLock & f::
{
    if GetKeyState("Ctrl") {
        WinOS.Manager.explorer()
    }
    else {
        App.everything()
    }
    IME.set("EN")
}

; g = google
CapsLock & g::
{
    if GetKeyState("Alt")
    {
        App.Chrome.searchSelected()
    }
    else
    {
        App.Chrome.run()
    }
}

; e = editor
CapsLock & e::
{
    if GetKeyState("Alt")
    {
        App.drawio()
    }
    else {
        App.notion()
    }
}

; r = run | develop | java | back-end
CapsLock & r::
{
    if GetKeyState("Ctrl")
    {
        App.Uniapp.activate()
    }
    else if GetKeyState("LWin") {
        App.jmeter()
    }
    else if GetKeyState("Alt")
    {
        App.todesk.run()
    } else {
        App.Idea.activate()
    }
}

; t = terminal | develop | front-end
CapsLock & t::
{
    if GetKeyState("Ctrl")
    {
        App.Tabby.run()
    }
    else if getKeyState("Alt")
    {
        App.WxDevTools.activate()
    }
    else if getKeyState("LWin")
    {
        App.hwMirror()
    }
    else
    {
        App.Vscode.run()
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
    App.ditto()
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