;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode "Input"    ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

;=====================================================================o
;                    Window Manager

class Window {

    ; 每次移动 1/10 （宽度）量相对坐标
    static moveWin(direction)
    {
        ToolTip direction
        try {
            WinGetPos &pos_x, &pos_y, &Width, &Height, "A"
            h := A_ScreenHeight
            w := A_ScreenWidth
            d := (h/10)
        } catch (Error) {
            ; 刚启动尚未未激活窗口时，找不到窗口；需等待几秒
            return
        }
        switch (direction)
        {
            case "↑" : WinMove pos_x          , pos_y - d       ,,, "A"         
            case "↓" : WinMove pos_x          , pos_y + d       ,,, "A"         
            case "←" : WinMove pos_x - d      , pos_y           ,,, "A"    
            case "→" : WinMove pos_x + d      , pos_y           ,,, "A"   
            case "|" : WinMove (w/2)-(Width/3), (h/2)-(Height/2),,, "A"                                           
        }
        Sleep 25
        Tooltip
    }

    ; 快速移动到指定区域: 如需通用适配，请用内置函数按比例放缩
    static zoomWin(direction)
    {
        ToolTip direction
        h := A_ScreenHeight
        w := A_ScreenWidth
        try {
            switch (direction)
            {
                case "(" : winmove  0     , 0  , w/2  , h    , "A" ; 1/2 下
                case ")" : winmove  w/2   , 0  , w/2  , h    , "A" ; 1/2 下
                case "↑" : winmove  0     , 0  , w    , h/2  , "A" ; 1/2 上
                case "↓" : winmove  0     , h/2, w    , h/2  , "A" ; 1/2 下
                case "←" : winmove  0     , 0  , w/3  , h    , "A" ; 1/3 左
                case "→" : winmove  w*2/3 , 0  , w/3  , h    , "A" ; 1/3 右
                case "|" : winmove  w/3   , 0  , w/3  , h    , "A" ; 1/3 中
                case "[" : winmove  0     , 0  , w*2/3, h    , "A" ; 2/3 左
                case "]" : winmove  w/3   , 0  , w*2/3, h    , "A" ; 2/3 右
                case "n" : winmove  w/4   , h/6, w/2  , h*2/3, "A" ; 视觉中央
                case "m" : winmaximize "A"
                case "," : winminimize "A" 
                case "." : winrestore  "A" ; vim 复刻上次操作
            }
        } catch Error {
            ToolTip "未找到焦点窗口"
        }
        SetTimer () => Tooltip(), -1000
    }

    static move()
    {
        ToolTip "🔄"
        BlockInput "On"
        loop 
        {
            if GetKeyState("h", "p") {
                this.moveWin("←")
            } else if GetKeyState("j", "p") {
                this.moveWin("↓")
            } else if GetKeyState("k", "p") {
                this.moveWin("↑")
            } else if GetKeyState("l", "p") {
                this.moveWin("→")
            } else if GetKeyState("Space", "p") {
                this.moveWin("|")
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

    }

    static zoom()
    {
        ToolTip "🔄"
        BlockInput "On"
        loop {
            if GetKeyState("h", "p") {
                this.zoomWin("←")
                break
            } else if GetKeyState("j", "p") {
                this.zoomWin("↓")
                break
            } else if GetKeyState("k", "p") {
                this.zoomWin("↑")
                break
            } else if GetKeyState("l", "p") {
                this.zoomWin("→")
                break
            } else if GetKeyState("Space", "p") {
                this.zoomWin("|")
                break
            } else if GetKeyState("[", "p") {
                this.zoomWin("[")
                break
            } else if GetKeyState("]", "p") {
                this.zoomWin("]")
                break
            } else if GetKeyState("n", "p") {
                this.zoomWin("n")
                break
            } else if GetKeyState("m", "p") {
                this.zoomWin("m")
                break
            } else if GetKeyState(",", "p") {
                this.zoomWin(",")
                break
            } else if GetKeyState(".", "p") {
                this.zoomWin(".")
                break
            } else if GetKeyState("i", "p") {
                this.zoomWin("(")
                break
            } else if GetKeyState("o", "p") {
                this.zoomWin(")")
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

    
}