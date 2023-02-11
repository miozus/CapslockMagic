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
            App.Idea.activate()
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