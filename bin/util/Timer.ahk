; 动画计时器（单位：秒）
class Timer {

    ; 显示当前时间(5秒钟)
    static showDatetime() {
        Loop 5 {
            tooltip FormatTime(, "yyyy-MM-dd ddd HH:mm:ss") 
            Sleep 1000
        }
    }

    ; 二进制沙漏:2
    static get2HourGlass(count := 2, msg := "") {
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
    static get2HoldUmbrella(count := 2, msg := "") {
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
    static get2RainyThunder(count := 2, msg := "") {
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
    static get3EarthRotation(count := 3, msg := "") {
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
    static get4ShrinkBlock(count := 4, msg := "") {
        if msg != "" {
            msg := " " msg
        }
        Loop count {
            this.get4ShrinkBlockDrop(count, msg)
        }
        tooltip
    }

    ; 缩小方块：4
    static get4ShrinkBlockDrop(count := 4, msg := "") {
        switch Mod(A_Index, 4) {
            case 1: tooltip "⬛" msg
            case 2: tooltip "◼" msg
            case 3: tooltip "◾" msg
            case 0: tooltip "▪" msg
        }
        Sleep 1000
    }

    ; 月球自转：8
    static get8MoonRetation(count := 8, msg := "") {
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
    static get12Clock(count := 12, msg := "") {
        if msg != "" {
            msg := " " msg
        }
        Loop count {
            switch Mod(A_Index, 12) {
                case 1: tooltip "🕐" msg
                case 2: tooltip "🕑" msg
                case 3: tooltip "🕒" msg
                case 4: tooltip "🕓" msg
                case 5: tooltip "🕔" msg
                case 6: tooltip "🕕" msg
                case 7: tooltip "🕖" msg
                case 8: tooltip "🕗" msg
                case 9: tooltip "🕘" msg
                case 10: tooltip "🕙" msg
                case 11: tooltip "🕚" msg
                case 0: tooltip "🕛" msg
            }
            Sleep 1000
        }
        tooltip
    }

}
