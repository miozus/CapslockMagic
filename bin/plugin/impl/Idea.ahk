; JetBrains Itellij Idea 快捷键指令
class Idea {


    class Jrebel {
        ; 热部署
        static compile() {
            Send "{blind!}^{F9}"
            Sleep 2500
            activateOrRun("ahk_exe chrome.exe")
            Send "{blind!}{F5}"
        }

        static hotspot() {
            Send "{blind}^{F9}"
            ToolTip "🫕"
        }

    }

    ; 运行当前上下文的程序
    static runContextCode() {
        Send "{Blind}^+c"
    }

    static closeTab() {
        Send "{blind}^#w"
    }

    static stop() {
        Send "{Blind}^{F2}"
    }

    static currentFileInContent() {
        Send "!{F1}1"
    }

    static implement() {
        Send "{blind}^!b"
    }

    static eidtVmOptions() {
        Send "!+e"
        Sleep 200
        Send "!v"
        Sleep 50
        Send "+{Enter}"
    }

    static focusPasteElementByIdeavim() {
        Send "{Blind}^c"
        Send "{Blind}^v"
        ; Send "{Blind}!{Tab}"
        ActivateOrRun("ahk_exe idea64.exe")
        Sleep 100
        Vim.searchByPaste()
    }

    static clearAll() {
        Send "{Blind}!8"
        Send "{Blind}^!+\"
        Send "{Blind}{Esc}"
        this.activateCursor()
    }

    static activateCursor() {
        Loop 2 {
            Send "^{Tab}"
        }
    }

    static runCmdPythonUnittest() {
        python := "E:/miniconda3/envs/autotest/python.exe"
        unittest := " e:/projects/IdeaProjects/gulimall/selenium/autotest/test/"
        cases := "order_test.py"
        Run python unittest cases
    }

    ; 重启当前服务
    static reloadCurrentService() {
        Send "!8"
        Sleep 200
        Send "^!c"
    }

    static delete()
    {
        if GetKeyState("Alt") = 0
            Send "^{Del}"
        else {
            Send "^+{Right}"
            Sleep 50
            Send "{Del}"
        }
    }

    static backspace()
    {
        if GetKeyState = 0
            Send "^{BS}"
        else
        {
            Send "^+{Left}"
            Sleep 50
            Send "{BS}"
        }
    }

    static batchClearOrFindLog(threadCount := 1, keyword := "null") {
        Loop threadCount
        {
            Send "{Tab}"
            if (keyword != "null")
            {
                Send "^f"
                Send keyword
            } else {
                Send "^#+d"    ; clear all
            }
            Send "!8"
            Send "!8"
            Sleep 250
            if (keyword != "null")
            {
                Send "{Up}"
            } else {
                Send "{Down}"
            }
            Sleep 200
        }
    }

    ; 切面：业务逻辑，自动切换窗口
    static around(self, func, args*) {
        try {
            ; 最常用：首先自动切换窗口
            if App.Idea.isExist() {
                func(self, args*)
            }
        } catch Error as e {
            ToolTip e.Message
            SetTimer () => ToolTip(), -3000
        }
    }

    ; 切面: 注册
    static __New() {

        fns := [
            this.clearAll,
        ]

        for _, fn in fns {
            tmp := fn    ; 由于读取一次性，必须临时储存
            fn_name := LTrim(tmp.Name, 'Idea.')
            this.DefineProp(fn_name, {
                call: (self, args*) => this.around(self, tmp, args*)
            })
        }

    }

}
