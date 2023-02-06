SendMode "Input"
SetWorkingDir A_ScriptDir

;=====================================================================o
;                    I need it
;=====================================================================o
; 单手操作浏览页面(chrome：编辑网址/下拉菜单)
#Hotif Enviorment.hasNotIde()
!d::PgDn
!e::PgUp
#Hotif

;=====================================================================o
; 所有代码编辑器
#hotif Enviorment.hasIde()
CapsLock:: Ide.Esc()
CapsLock & 2:: Ide.terminal()
CapsLock & 4:: Ide.service()
CapsLock & 5:: Ide.debug()
#HotIf

;=====================================================================o
; 仅限大脑喷射编辑器 IDEA
#Hotif Enviorment.hasJetBrains()
LCtrl & \:: Vim.javaDocViaMethodLine()
CapsLock & 5:: Idea.Jrebel.compile()
CapsLock & 7:: Idea.eidtVmOptions()
CapsLock & b:: Idea.implement()
CapsLock & .:: Idea.delete()
CapsLock & n:: Idea.backspace()
CapsLock & w:: Idea.closeTab()
CapsLock & x:: Idea.stop()
CapsLock & z:: Idea.runContextCode()
#HotIf

;=====================================================================o
; 仅限谷歌浏览器
#Hotif Enviorment.hasGoogle()
CapsLock & 2:: Idea.focusPasteElementByIdeavim()
#Hotif


;=====================================================================o
;                       implement
class Ide {

    ; 开始调试
    static debug() {
        Send "^+d"
    }

    ; 服务监控
    static service() {
        Send "!8"
    }

    ; 终端
    static terminal() {
        Send "!{F12}"
    }

    ; 输入法管家
    static esc() {
        ; 如果正在打拼音，就不切换输入法
        if IME.isNotTypingPinYin() {
            IME.set("EN")
        }
        ; 如果先返回，图片消失了，就检测不到了，所以最后返回
        Send "{Esc}"
    }

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

; Idea 快捷键指令
class Idea {

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
            if Launcher.Idea.isExist() {
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


class IdeVim {

    ; <leader> n 下一个错误
    static markernext() {
        Send "{Bind}{F2}"
    }

    ; <leader> j 快速修复
    static actionquickFix() {
        Send "{Bind}!{Enter}"
    }

    ; <leader> o 大纲
    static outlinefocus() {
        Send "{Bind}!{F7}"
    }

    ; <leader> z 禅模式
    static actiontoggleZenMode() {
        Send "{Bind}^kz"
    }

    ; <leader> f 排版
    static actionformatDocument() {
        Send "{Bind}^!l"
    }

    ; <leader> e 转到文件
    static actionquickOpen() {
        Send "{Bind}^+n"
    }

    ; <leader> a 文件中查找
    static findInFiles() {
        Send "{Bind}^c"
        Send "{Bind}^+f"
        Send "{Bind}^v"
    }

    ; <leader> s 资源浏览器中查看该文件
    static viewexplorer() {
        Send "{Bind}^1"
    }

    ; <leader> h  该文件版本历史
    static gitlensshowQuickFileHistory() {
        Send "{Bind}^+gh"
    }

    ; <leader> b 该行打断点
    static toggleBreakpoint() {
        Send "{Bind}^{F8}"
    }

    ; <leader> dd 开始调试
    static debugStart() {
        Send "{Bind}{F5}"
    }

    ; <leader> rr 重构：重命名
    static rename() {
        Send "{Bind}+{F6}"
    }

    ; <leader> H 标签：上一个
    static tabPreview() {
        Send "{Bind}^+["

    }

    ; <leader> L 标签：下一个
    static tabNext() {
        Send "{Bind}^+]"
    }

}


class Enviorment {

    static hasIde() {
        ides := ["idea64.exe", "code.exe", "goland64.exe", "WindowsTerminal.exe", "Tabby.exe", "ToDesk.exe"]
        for ide in ides
            if WinActive("ahk_exe" ide)
                return true
        return false
    }

    static hasNotIde() {
        return !this.hasIde()
    }

    static hasJetBrains() {
        return WinActive("ahk_exe idea64.exe") or WinActive("ahk_exe goland64.exe")
    }

    static hasGoogle() {
        return WinActive("ahk_exe chrome.exe")
    }
}