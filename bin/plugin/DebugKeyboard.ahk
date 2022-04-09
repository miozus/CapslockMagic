SendMode "Input"    ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

;=====================================================================o
;               Intelj Keymap for debug

global EnableDebugKeyboard := false

; 调试小键盘
; ---
; - 进入：
;   - 一次性：按住 <4> 不松手步入
;   - 循环使用：分号模式输入 dbg 开启
; - 退出：
;   - 明示：<Esc>
;   - 静默：AIOS 增删改代码时，打开计算器时默默退出
*4::
{
    global EnableDebugKeyboard
    thisHotkey := A_ThisHotkey
    disableOtherHotkey(thisHotkey)
    EnableDebugKeyboard := true
    ToolTip "🦉"
    keywait "4" 
    EnableDebugKeyboard := false
    if (A_PriorKey == "4" && A_TimeSinceThisHotkey < 350)
    {
        Send "{blind}4"
    }
    enableOtherHotkey(thisHotkey)
    ToolTip
}

#Hotif EnableDebugKeyboard
^1:: Debug.stepOverForce()
*1:: Debug.stepOver()
^2:: Debug.stepIntoForce()
*2:: Debug.stepIntoSmart()
^3:: Debug.stepOut()
*3:: Debug.resumeProgram()

*5:: Hotspot.refresh()
*6:: Debug.reboot()
*[:: SourceHunter.usage()
*]:: SourceHunter.hierarchy()
*\:: Debug.run2Cursor()

*A:: Debug.exitSilent()
*I:: Debug.exitSilent()
*O:: Debug.exitSilent()
*S:: Debug.exitSilent()
*C:: Debug.exitSilent()

^Tab:: Hotspot.refresh()
*Tab:: Chrome.refresh()
^Esc:: Debug.view()
*Esc:: Debug.exit()
*Space:: Debug.evaluate()
#Hotif

; Intelj IDEA 调试动作
; ---
; docs: https://www.cnblogs.com/chiangchou/p/idea-debug.html
class Debug {

    Enable := false
    
    ; view , when contion is true
    static view() {
        Send "{blind}^+{F8}" 
        ToolTip "🔍"
    }

    ; Run to Cursor
    static run2Cursor() {
        Send "{blind}!{F9}" 
        ToolTip "I"
    }

    ; Run debug
    static reboot() {
        Send "{blind}^!d" 
        ToolTip "🐞"
    }

    ; next breakpoint, let me go
    static resumeProgram() {
        Send "{blind}{F9}" 
        ToolTip "▶️"
    }

    ; step into [ any ] detail [infinity] if entrance exists
    static stepIntoForce() {
        Send "{blind}!+{F7}" 
        ToolTip "↘️!"
    }

    ; step into [custom] detail [once] if entrance exists
    static stepInto() {
        Send "{blind}{F7}" 
        ToolTip "↘️"
    }

    ; step into [custom] detail [once] you can choose one
    static stepIntoSmart() {
        Send "{blind}+{F7}" 
        ToolTip "↘️"
    }

    ;  step over [no] detail like N ext keyword in vim
    static stepOver() {
        Send "{blind}{F8}" 
        ToolTip "⬇️"
    }

    ; preview last step 
    static stepOverForce() {
        Send "{blind}!+{F8}" 
        ToolTip "⬇️!"
    }

    ; undo step into like over
    static stepOut() {
        Send "{blind}+{F8}" 
        ToolTip "↗️"
    }

    ; open calculate statement
    static evaluateExpression() {
        Send "{blind}!{F8}" 
        ToolTip "🧮"
    }

    static stopDebug(){
        Send "{blind}^{F2}" 
        ToolTip "⏹️"
    }
    
    ; exit and remap as origin key
    static exitSilent() {
        originKey := LTrim A_ThisHotkey, '*'
        Send "{Blind}" originKey 
        this.exit()
    }
    
    ; exit dbg state
    static exit() {
        global EnableDebugKeyboard
        EnableDebugKeyboard := false
        ToolTip "💨"
        SetTimer () => ToolTip(), -1000
    }


    ; 计算表达式
    static evaluate() {
        global EnableDebugKeyboard
        this.evaluateExpression()
        Sleep 500
        this.exit()
    }

    ; 启动开关
    static toggle() {
        global EnableDebugKeyboard
        EnableDebugKeyboard := !EnableDebugKeyboard
        if EnableDebugKeyboard {
            ToolTip "🦉"
        } else {
            ToolTip "💨"
        }
        SetTimer () => ToolTip(), -1000
    }
    
}


; Devtools and Jrebel be like
class Hotspot {
    
    static refresh() {
        Send "{blind}^{F9}" 
        ToolTip "🫕"
    }
}

class Chrome {

    static refresh() {
        path := A_AppData "\Microsoft\Internet Explorer\Quick Launch\Google Chrome.lnk"
        activateOrRun("ahk_exe chrome.exe", path)
        Send "{Blind}^r"
    }
}

; 接口管理工具
class ApiFox {

    static post(){
        path := A_Programs "\Apifox.lnk"
        ActivateOrRun("ahk_exe Apifox.exe", path)
        Send "{Blind}^{Enter}"
    }
}
; 源码猎手
class SourceHunter {

   ; 在哪关联使用
   static usage() {
        Send "{blind}!+{F7}" 
        ToolTip "👥"
   }

   ; 它的继承实现类子孙
   static hierarchy() {
        Send "{blind}^h" 
        ToolTip "👶"
   }
   
}