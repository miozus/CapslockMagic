; Garbage Collector
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
        ; ToolTip "  LAlt" GetKeyState("LAlt") " LWin" GetKeyState("LWin") " LCtrl" GetKeyState("LCtrl") 
        ; SetTimer () => ToolTip(), -1000
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
        Send "{Alt}"
        Send "{Alt}"
        if GetKeyState("LWin")
        {
            Send "{LWin Up}"
            Sleep 100
            Send "{Esc}"
        }
        ToolTip
        ; ToolTip "  LAlt" GetKeyState("LAlt") " LWin" GetKeyState("LWin") " LCtrl" GetKeyState("LCtrl") 
    }
    


    static disableOtherHotkey(thisHotkey)
    {
        global allHotkeys
        for index, value in allHotkeys
        {
            if (value != thisHotkey) {
                hotkey value, "off"
            }
        }
    }

    static enableOtherHotkey(thisHotkey)
    {
        global allHotkeys
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