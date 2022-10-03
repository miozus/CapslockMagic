
SendMode "Input"
SetWorkingDir A_ScriptDir
FileEncoding "UTF-8"

; 动画合集
class Animation {

    static switchTrayIcon() {
        ;  停用脚本，为了打字
        if A_IsSuspended {
            Traytip "⏸️ 已暂停"
            TraySetIcon("bin\img\capslock_pause.ico", 1, 1)
            SetTimer () => Traytip(), -1000
        } else {
            Traytip "🖤 继续运行"
            TraySetIcon("bin\img\capslock_run.ico", 1, 1)
            SetTimer () => Traytip(), -1000
        }
    }

    static initTrayIcon() {
        TraySetIcon("bin\img\capslock_run.ico", 1, 1)
        ToolTip "🖤"
        SetTimer () => ToolTip(), -500
    }

    ; 爆炸动画，持续1.2s
    static bombExploseGif() {
        ToolTip "-----"
        Sleep 100
        ToolTip "*----"
        Sleep 50
        ToolTip "**---"
        Sleep 50
        ToolTip "***--"
        Sleep 50
        ToolTip "****-"
        Sleep 100
        ToolTip " 💣 "
        Sleep 150
        ToolTip "      "
        Sleep 25
        ToolTip " 💣 "
        Sleep 150
        ToolTip "      "
        Sleep 25
        ToolTip " 💥 "
        Sleep 500
        ToolTip
    }
}

; 动画计时器（单位：秒）
class Timer {

    ; 二进制沙漏:2
    static hourGlass(count:=2, msg:="") {
        if msg != "" {
            msg := " " msg
        }
        Loop count {
            if Mod(A_Index, 2) {
                tooltip "⏳" msg
            } else {
                tooltip "⌛" msg
            }
            Sleep 1000
        }
        tooltip
    }

    ; 下雨打伞:2
    static holdUmbrella(count:=2, msg:="") {
        if msg != "" {
            msg := " " msg
        }
        Loop count {
            if Mod(A_Index, 2) {
                tooltip "☂" msg
            } else {
                tooltip "☔" msg
            }
            Sleep 1000
        }
        tooltip
    }

    ; 下大雨打伞:2
    static rainyThunder(count:=2, msg:="") {
        if msg != "" {
            msg := " " msg
        }
        Loop count {
            if Mod(A_Index, 2) {
                tooltip "🌧" msg
            } else {
                tooltip "⛈" msg
            }
            Sleep 1000
        }
        tooltip
    }
    

    ; 自转地球：3
    static earthRotation(count:=3, msg:="") {
        if msg != "" {
            msg := " " msg
        }
        Loop count {
            switch Mod(A_Index, 3) {
                case 1: tooltip "🌍" msg
                case 2: tooltip "🌎" msg
                case 0: tooltip "🌏" msg
            }
            Sleep 1000
        }
        tooltip
    }

    ; 缩小方块：4
    static shrinkBlock(count:=4, msg:="") {
        if msg != "" {
            msg := " " msg
        }
        Loop count {
            switch Mod(A_Index, 4) {
                case 1: tooltip "⬛" msg
                case 2: tooltip "◼" msg
                case 3: tooltip "◾" msg
                case 0: tooltip "▪" msg
            }
            Sleep 1000
        }
        tooltip
    }
    
    ; 月球自转：8
    static moonRetation(count:=8, msg:="") {
        if msg != "" {
            msg := " " msg
        }
        Loop count {
            switch Mod(A_Index, 8) {
               case 1: tooltip "🌑" msg
               case 2: tooltip "🌒" msg
               case 3: tooltip "🌓" msg
               case 4: tooltip "🌔" msg
               case 5: tooltip "🌕" msg
               case 6: tooltip "🌖" msg
               case 7: tooltip "🌗" msg
               case 0: tooltip "🌘" msg
            }
            Sleep 1000
        }
        tooltip
    }
    
    ; 时钟: 12
    static clockTwelve(count:=12, msg:="") {
        if msg != "" {
            msg := " " msg
        }
        Loop count {
            switch Mod(A_Index, 12) {
                case  1: tooltip "🕐" msg
                case  2: tooltip "🕑" msg
                case  3: tooltip "🕒" msg
                case  4: tooltip "🕓" msg
                case  5: tooltip "🕔" msg
                case  6: tooltip "🕕" msg
                case  7: tooltip "🕖" msg
                case  8: tooltip "🕗" msg
                case  9: tooltip "🕘" msg
                case 10: tooltip "🕙" msg
                case 11: tooltip "🕚" msg
                case  0: tooltip "🕛" msg 
            }
            Sleep 1000
        }
        tooltip
    }


}
