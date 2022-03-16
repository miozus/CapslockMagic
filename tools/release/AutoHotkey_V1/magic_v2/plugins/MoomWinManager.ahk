#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;=====================================================================o
;                    Windows Manager
;---------------------------------------------------------------------o
; 每次移动 1/10 坐标位置
moveWin(direction)
{
    Tooltip, %direction%
    WinGetPos, pos_x, pos_y, Width, Height, A
    switch (direction)
    {
        case "←" : Winmove, A, , pos_x - 170, pos_y 
        case "→" : Winmove, A, , pos_x + 170, pos_y
        case "↑" : Winmove, A, , pos_x      , pos_y - 170
        case "↓" : Winmove, A, , pos_x      , pos_y + 170
        case "|" : Winmove, A, , (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
    }
    sleep, 25
    Tooltip
}
;---------------------------------------------------------------------o
; 快速移动到指定区域
zoomWin(direction)
{
    Tooltip, %direction%
    h := A_ScreenHeight
    w := A_ScreenWidth
    switch (direction)
    {
        case "→" : Winmove, A, , (w*2/3+21),     0, (w/3-20), (h)
        case "←" : Winmove, A, ,          0,     0,      973, (h)
        case "↑" : Winmove, A, ,          0,     0,      (w), (h/2)
        case "↓" : Winmove, A, ,          0, (h/2),      (w), (h/2)
        case "|" : Winmove, A, ,        882,     0,      845, (h)  ; 1/3 手工视觉
        case "↗" : Winmove, A, ,        907,     0,     2562, 1160 ; 2/3 手工视觉，卡在idea输出栏
    }
    sleep, 500
    Tooltip
}
;---------------------------------------------------------------------o
moveWinManager()
{
    Tooltip, 🔄
    loop {
        if getkeystate("h") = 1 {
            moveWin("←")
        }else if getkeystate("j") {
            moveWin("↓")
        }else if getkeystate("k") {
            moveWin("↑")
        }else if getkeystate("l") {
            moveWin("→")
        }else if getkeystate("space") {
            moveWin("|")
        } else if getkeystate("esc") {
            Tooltip, ⏹
            Sleep, 500
            Tooltip
            return
        }
        ; break if timeout is greater than 1.5s
        else if A_TimeIdlePhysical > 1500
        {
            Tooltip, ⌛
            Sleep, 500
            Tooltip
            return
        }
    }
}
;---------------------------------------------------------------------o
zoomWinManager()
{
    loop {
        if getkeystate("h") {
            zoomWin("←")
            return
        }else if getkeystate("j") {
            zoomWin("↓")
            return
        }else if getkeystate("k") {
            zoomWin("↑")
            return
        }else if getkeystate("l") {
            zoomWin("→")
            return
        }else if getkeystate("space") {
            zoomWin("|")
            return
        }else if getkeystate("]") {
            zoomWin("↗")
            return
        }
        ; break if timeout is greater than 1.5s
        else if A_TimeIdlePhysical > 1500
        {
            Tooltip, ⏳
            Sleep, 500
            Tooltip
            return
        }
    }
}
;---------------------------------------------------------------------o
turn2ProjectWinMode()
{
    Winmove, ahk_exe chrome.exe, , 907, 0, 1660, 1160 ;        ↗ 2/3
    Winmove, ahk_exe Code.exe,   , 0, 0, 973, 1440    ;  ← 1/3
    Winmove, ahk_exe idea64.exe, , -7, 0, 1734, 1448  ;  ← 2/3
    Winmove, ahk_exe Notion.exe, , 1718, 0, 842, 1440 ;        → 1/3
}
;---------------------------------------------------------------------o
turn2ReadWinMode()
{
    Winmove, ahk_exe chrome.exe, , -7, 0, 906, 1447   ;        ↗ 2/3
    ; Winmove, ahk_exe Code.exe, , 0, 0, 973, 1440    ;  ← 1/3
    ; Winmove, ahk_exe idea64.exe, , -7, 0, 1734, 1448  ;  ← 2/3
    ; Winmove, ahk_exe Notion.exe, , 1718, 0, 842, 1440 ;        → 1/3
}
;---------------------------------------------------------------------o
