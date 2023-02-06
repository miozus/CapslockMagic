SendMode "Input"
SetWorkingDir A_ScriptDir

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
    GC.disableOtherHotkey(thisHotkey)
    EnableDebugKeyboard := true
    ToolTip "🦉"
    keywait "4"
    EnableDebugKeyboard := false
    if (A_PriorKey == "4" && A_TimeSinceThisHotkey < 350)
    {
        Send "{blind}4"
    }
    GC.enableOtherHotkey(thisHotkey)
    ToolTip
}

#Hotif EnableDebugKeyboard
^1:: Debug.stepOverForce()
*1:: Debug.stepOver()
^2:: Debug.stepIntoForce()
*2:: Debug.stepIntoSmart()
^3:: Debug.stepOut()
*3:: Debug.resumeProgram()

*5:: Idea.Jrebel.hotspot()
*6:: Debug.reboot()
*[:: Ide.usage()
*]:: Ide.hierarchy()
*\:: Debug.run2Cursor()

*A:: Debug.exitSilent()
*I:: Debug.exitSilent()
*O:: Debug.exitSilent()
*S:: Debug.exitSilent()
*C:: Debug.exitSilent()

^Tab:: Idea.Jrebel.hotspot()
*Tab:: Launcher.Google.refresh()
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

    static stopDebug() {
        Send "{blind}^{F2}"
        ToolTip "⏹️"
    }

    ; exit and remap as origin key
    static exitSilent() {
        originKey := LTrim(A_ThisHotkey, '*')
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


    ; 切面：业务逻辑，自动切换窗口
    static around(self, func, args*) {
        try {
            ; 最常用：首先自动切换窗口
            Launcher.Idea.activate()
            func(self, args*)
        } catch Error as e {
            ToolTip e.Message
            SetTimer () => ToolTip(), -3000
        }
    }

    ; 切面: 注册
    static __New() {

        fns := [
            this.stepOver,
            this.stepIntoSmart,
            this.resumeProgram
        ]

        for _, fn in fns {
            tmp := fn    ; 由于读取一次性，必须临时储存
            fn_name := LTrim(tmp.Name, 'Debug.')
            this.DefineProp(fn_name, {
                call: (self, args*) => this.around(self, tmp, args*)
            })
        }

    }

}