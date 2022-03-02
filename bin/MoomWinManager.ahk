;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode "Input"    ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

;=====================================================================o
;                    Windows Manager

; 每次移动 1/10 （宽度）量相对坐标
moveWin(direction)
{
    ToolTip direction
    try {
        WinGetPos &pos_x, &pos_y, &Width, &Height, "A"
        h := A_ScreenHeight
        w := A_ScreenWidth
    } catch (Error) {
        ; 刚启动尚未未激活窗口时，找不到窗口；需等待几秒
        return
    }
    switch (direction)
    {
        case "↑" : WinMove pos_x          , pos_y - 170     ,,, "A"         
        case "↓" : WinMove pos_x          , pos_y + 170     ,,, "A"         
        case "←" : WinMove pos_x - 170    , pos_y           ,,, "A"    
        case "→" : WinMove pos_x + 170    , pos_y           ,,, "A"   
        case "|" : WinMove (w/2)-(Width/2), (h/2)-(Height/2),,, "A"                                           
    }
    Sleep 25
    Tooltip
}

; 快速移动到指定区域: 如需通用适配，请用内置函数按比例放缩
zoomWin(direction)
{
    ToolTip direction
    h := A_ScreenHeight
    w := A_ScreenWidth
    try {
        switch (direction)
        {
            ; 九宫格布局，长宽等分 3 * 3
            case "↑" : WinMove          0,     0,      (w), (h/2), "A"         
            case "↓" : WinMove          0, (h/2),      (w), (h/2), "A"         
            case "←" : WinMove          0,     0,      853,  1440, "A"       
            case "→" : WinMove       1706,     0,      854,  1440, "A"       
            case "|" : WinMove        853,     0,      853,  1440, "A"       
            case "↖" : WinMove         -7,     0,     1741,   682, "A" ; 2*1 卡在 console
            case "↗" : WinMove        958,     0,     1609,   682, "A" ; 2*1 卡在 console
            case "[" : WinMove         -7,     0,     1720,  1447, "A" ; 2*3 左右
            case "]" : WinMove        958,     0,     1609,  1160, "A" ; 2*2 右上卡在idea输出栏         
            case "↙" : WinMove         -7,  1109,     1733,   340, "A" ; 2*1/4 等于 console
            case "↘" : WinMove        963,   756,     1609,   682, "A" ; 2*1 不档网页内容
            ; 六块腹肌布局，长宽等分 3 * 2  正好应对QWE ASD ZXC 布局
            case "e" : WinMove       1713,     0,      854,   763, "A" ; ↗ 1/3 * 1/2
            case "d" : WinMove       1713,   754,      854,   684, "A" ; ↘ 1/3 * 1/2
            ; 常规三化：小，中，大
            case "m" : WinMinimize "A"
            case "," : WinMaximize "A" 
            case "." : WinRestore "A" ; Vim 复刻上次操作
        }
        
    } catch Error {
        ToolTip "未找到焦点窗口"
    }
    SetTimer () => Tooltip(), -1000
}

moveWinGenMode()
{
    ToolTip "🔄"
    BlockInput "On"
    loop 
    {
        if GetKeyState("h", "p") {
            moveWin("←")
        } else if GetKeyState("j", "p") {
            moveWin("↓")
        } else if GetKeyState("k", "p") {
            moveWin("↑")
        } else if GetKeyState("l", "p") {
            moveWin("→")
        } else if GetKeyState("Space", "p") {
            moveWin("|")
        } else if GetKeyState("Esc", "p") {
            ToolTip "⏹" ; 物理按键停止
            break
        }
        else if A_TimeIdlePhysical > 1500 {
            ToolTip "⌛" ; 超时自动停止
            break
        }
    }
    BlockInput "Off"
    ; 收尾阶段，按下外部逻辑锁死的键，解除锁定(不要按 CapsLock 停止)
    Send "{Alt}{Ctrl}"
    if GetKeyState("LWin")
    {
        Send "{LWin}"
        Sleep 100
        Send "{Esc}"
    }
    Sleep 100
    ToolTip
    ; TODO: 诡异的开始菜单弹窗，除了作废它，还有其他解法吗？A_MaskKey 在此处失效了
    ; ToolTip "  LAlt" GetKeyState("LAlt") " LWin" GetKeyState("LWin") " LCtrl" GetKeyState("LCtrl") 
}

zoomWinManager()
{
    ToolTip "🔄"
    BlockInput "On"
    loop {
        if GetKeyState("h", "p") {
            zoomWin("←")
            break
        } else if GetKeyState("j", "p") {
            zoomWin("↓")
            break
        } else if GetKeyState("k", "p") {
            zoomWin("↑")
            break
        } else if GetKeyState("l", "p") {
            zoomWin("→")
            break
        } else if GetKeyState("Space", "p") {
            zoomWin("|")
            break
        } else if GetKeyState("[", "p") {
            zoomWin("[")
            break
        } else if GetKeyState("]", "p") {
            zoomWin("]")
            break
        } else if GetKeyState("-", "p") {
            zoomWin("↖")
            break
        } else if GetKeyState("=", "p") {
            zoomWin("↗")
            break
        } else if GetKeyState(";", "p") {
            zoomWin("↙")
            break
        } else if GetKeyState("'", "p") {
            zoomWin("↘")
            break
        } else if GetKeyState("e", "p") {
            zoomWin("e")
            break
        } else if GetKeyState("d", "p") {
            zoomWin("d")
            break
        } else if GetKeyState("m", "p") {
            zoomWin("m")
            break
        } else if GetKeyState(",", "p") {
            zoomWin(",")
            break
        } else if GetKeyState(".", "p") {
            zoomWin(".")
            break
        }
        ; break if timeout is greater than 1.5s
        else if A_TimeIdlePhysical > 1500
        {
            ToolTip "⏳"
            SetTimer () => Tooltip(), -500
            break
        }
    }
    BlockInput "Off"
}

alterProjectWinFrame()
{
    WinMove  907, 0, 1660, 1160,"ahk_exe chrome.exe"  ;        ↗ 2/3
    WinMove  0, 0, 973, 1440   ,"ahk_exe Code.exe"    ;  ← 1/3
    WinMove  -7, 0, 1734, 1448 ,"ahk_exe idea64.exe"  ;  ← 2/3
    WinMove  1718, 0, 842, 1440,"ahk_exe Notion.exe"  ;        → 1/3
}

turn2ReadWinMode()
{
    WinMove  -7, 0, 906, 1447  ,"ahk_exe chrome.exe"  ;        ↗ 2/3
}
