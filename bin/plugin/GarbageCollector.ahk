SendMode "Input"    ; Recommended for new scripts due to its superior  speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

;=====================================================================o
;                    Windows Garbage
;---------------------------------------------------------------------o
; WindowsOS
#h:: ; 听写，几乎没有麦克风
#c:: ; Cortana，人工智障
#p:: ; 投影屏幕，没有别的屏幕，单机版
#s:: ; 搜索，# 本身已经自带了
#f:: ; 反馈中心，几十年没反馈过问题
#u:: ; 轻松设置中心，一年不用一次
#n:: ; 日历
^#n:: ; 讲述人，不用了
#Pause:: ; 关于本机，一年不用一次
#b:: ; 显示隐藏托盘，用手点击或者win召唤即可，为idea让步
^#f:: ; 搜索本地电脑，没有局域网
#a:: ; 不需要拉出系统控制通知栏了，让位鼠标
^Esc:: ; 弹出开始菜单
!Esc:: ; 切换系统窗口签
!Space:: ; 窗口大小切换
~$<#!r::
#q::  ; 搜索
^#s:: ; 设置语音识别
{
}
;---------------------------------------------------------------------o
; 屏蔽开始菜单功能，仍保留组合键功能
~LAlt::
~LWin::
{
    SendEvent "{Blind}{vkE8}"
}

;---------------------------------------------------------------------o
; 强化复制、粘贴、保存（Mac ⌘）
<!c::Send "{blind!}^c"
<!v::Send "{blind!}^v"
<!s::Send "{blind!}^s"
<!x::Send "{blind!}^x"
<!z::Send "{blind!}^z"
<!a::Send "{blind!}^a"

class WindowsDock {

    static hidden() {
        Send "{RWin}"
        Sleep 50
        Send "{Esc}"
        Send "{Esc}"
    }
    
}

class GC {

    ; 收尾阶段，按下外部逻辑锁死的键，解除锁定(不要按 CapsLock 停止)
    static ModifyKey() {
        if GetKeyState("LWin")
        {
            Send "{LWin Up}"
            Sleep 100
            Send "{Esc}"
        }
        if GetKeyState("Alt")
        {
            Send "{Alt Up}"
        }
        if GetKeyState("Ctrl")
        {
            Send "{Ctrl Up}"
        }
        Sleep 100
        ToolTip "  LAlt" GetKeyState("LAlt") " LWin" GetKeyState("LWin") " LCtrl" GetKeyState("LCtrl") 
        SetTimer () => ToolTip(), -1000
    }

    static ModifyKeyDocker() {
        if GetKeyState("Alt")
        {
            Tooltip "Alt"
            Send "{Alt Up}"
        }
        if GetKeyState("Ctrl")
        {
            Tooltip "Ctrl"
            Send "{Ctrl Up}"
        }
        ToolTip
        ; ToolTip "  LAlt" GetKeyState("LAlt") " LWin" GetKeyState("LWin") " LCtrl" GetKeyState("LCtrl") 
    }

    static ModifyKeyPhysical() {
        Send "{Alt}{Ctrl}"
        if GetKeyState("LWin")
        {
            Send "{LWin Up}"
            Sleep 100
            Send "{Esc}"
        }
        Sleep 100
        ToolTip
        ; ToolTip "  LAlt" GetKeyState("LAlt") " LWin" GetKeyState("LWin") " LCtrl" GetKeyState("LCtrl") 
    }
    


    static disableOtherHotkey(thisHotkey)
    {
        global allHotkeys, EnableChinesePunctuation := false
        for index, value in allHotkeys
        {
            if (value != thisHotkey) {
                hotkey value, "off"
            }
        }
    }

    static enableOtherHotkey(thisHotkey)
    {
        global allHotkeys, EnableChinesePunctuation := true
        for index, value in allHotkeys
        {
            if (value != thisHotkey) {
                hotkey value, "on"
            }
        }
    }

    static disableAllHotkey()
    {
        global allHotkeys 
        for index, value in allHotkeys
            hotkey value, "off"
    }
    
}