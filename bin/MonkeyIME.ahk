#Include plugin\impl\WinOS.ahk
#Include plugin\impl\Git.ahk

; 分号短语命令
class SemicolonAbbr {

    static execute(typo)
    {
        switch typo
        {
            ; ====  人性化设计 ====
            case "oo": IME.toggle()    ; 如果第一次没切换成功，将就连按切换
            case "mm": Mouse.move()
            case "dbg": Debug.toggle()
            case "hey": Sleep 500    ; 测试专用
            case "os": Run A_ScriptDir
                ; ====  操作系统 ====
            case "dl": WinOS.Desktop.next()
            case "opc": WinOS.Folder.picture()
            case "ow": WinOS.Folder.personal()
            case "or": WinOS.Folder.recycle()
            case "ox": WinOS.Folder.downloads()
            case "quit": WinOS.Window.close()
            case "ee": WinOS.Window.stickOnTop()
            case "tm": WinOS.Manager.task()
            case "sleep": WinOS.Power.sleep()
            case "reboot": WinOS.Power.slideToReboot()
            case "shutdown": WinOS.Power.slideToShutdown()
            case "dd": WinOS.Dock.hidden()
            case "dh": WinOS.Desktop.previous()
            case "dl": WinOS.Desktop.next()
            case "no": WinOS.Editor.notepad()
            case "rex": WinOS.Manager.explorerReload()
            case "dt": Timer.showDatetime()
                ; ====  应用管理 ====
            case "spy": App.AHK.winSpy()
            case "wsc": App.AHK.winSoundComponent()
            case "wx": App.WeChat.activate()
            case "1": App.dittoPaste(1)
            case "2": App.dittoPaste(2)
            case "3": App.dittoPaste(3)
            case "4": App.dittoPaste(4)
            case "5": App.dittoPaste(5)
                ; ====  宇宙编辑器 ====
            case "ca": Idea.clearAll()
            case "lgi": IDE.Log.info()
            case "lgg": IDE.Log.infoPaste()
            case "cc": Vim.EditJavaCommentTitle()
            case "il": Vim.inputChineseInDdoubleQuotes()    ; 引号中输入中文
            case "cil": Vim.changeCnCommentInDoubleQuotes()
            case "list": Vim.surroundWithList()
            case "roui": UI.convert(TagRemap.ElementToUview2)
            case "tt": Vim.paste2LastLineUp()
            case "gg": Vim.paste2LastLineReplace()
            case "bb": Vim.paste2LastLineDown()
            case "vsa": Vim.swapArg()
            case "ln": IdeVim.markernext()
            case "lj": IdeVim.actionquickFix()
            case "lo": IdeVim.outlinefocus()
            case "lz": IdeVim.actiontoggleZenMode()
            case "lf": IdeVim.actionformatDocument()
            case "le": IdeVim.actionquickOpen()
            case "la": IdeVim.findInFiles()
            case "ls": IdeVim.viewexplorer()
            case "lgh": IdeVim.gitlensshowQuickFileHistory()
            case "lb": IdeVim.toggleBreakpoint()
            case "ldd": IdeVim.debugStart()
            case "lrr": IdeVim.rename()
            case "H": IdeVim.tabPreview()
            case "L": IdeVim.tabNext()
                ; ====  开发工具 ====
            case "ms": Locator.getMousePositionCode()
            case "px": Locator.getPixelSearchCode()
            case "pl": Locator.getPixelElementCode()
                ; ====  日常办公 ====
            case "docs": Website.Docs.king()
            case "gen": Website.codeGen()
            case "json": Website.excel2json()
            case "gpt": Website.chatGpt()
            case "devst": BatchLauncher.devStart()
            case "devex": BatchLauncher.devExit()
            case "gmst": BatchLauncher.gameStart()
            case "gmex": BatchLauncher.gameExit()
                ; ====  电脑控制 ====
            case "sound": App.AHK.winSoundComponent()
            case "hosts": App.DNS.run()
            case "mute": Send "{Volume_Mute}"
            case "mic": SoundVolume.switchVolumeAndMicrophone()
                ; ====  前端编码 ====
            case "vi": Vim.find("import")
            case "vm": Vim.find("methods")
            case "vs": Vim.find("style ")
            case "vd": Vim.find("data()")
            case "vv": Vim.find("view")
            case "im": Vim.implement()
                ; ====  浏览器 ====
            case "ot": Chrome.oneTab()
                ; ====  数字键盘 ====
            case "np1": Numpad.numpad1()
            case "np2": Numpad.numpad2()
            case "np3": Numpad.numpad3()
            case "np4": Numpad.numpad4()
                ; ====  版本管理 ====
            case "gm": Git.commitAllByComment()
                ; ====  快速测试 ====
            case "re": UnitTest.testFunction()
            default:
                return false
        }
        return true
    }
}

class UnitTest {

    static testFunction() {

    }
}

;=====================================================================o
; 猴子输入法
; 优先: 无命令词典（纯文字）；优先打印自定义短语，支持跨平台导出，输入法通用
; 其次: 自定义脚本功能
;
; 官方文档说，switch 命中就返回，没有落下直通，所以不用 return
; 但一种观点认为，命中后返回，可以提前结束 hook 监听输入，防止垂直落下。
class MonkeyIME {

    static enterSemicolonAbbr(ih) {
        ToolTip "🙈"
        ih.start()
        ih.wait()
        ih.stop()
        if (ih.Match)
        {
            try {
                value := "{text}" userDict[ih.Match]
                Send value
                CursorUtil.moveLeft(value)
                return
            }
            ; 带命令词典: 功能比较重
            ToolTip "🙉 " secretDict[ih.Match]
            SemicolonAbbr.execute(ih.Match)
        } else {
            ; 未收录词典，猴子跑了
            ToolTip "💨"
        }
        SetTimer () => Tooltip(), -500
    }


}

class CursorUtil {

    static moveLeft(value) {

        if inSemicolon(value) {
            Send "{Left 3}"
            return
        }

        if inComment(value) {
            Send "{Left 2}"
            return
        }

        if inCouple(value) {
            Send "{Left}"
            return
        }

        ; Java
        inSemicolon(value) {
            HayStack := '");'
            needle := SubStr(value, -3, 3)
            return InStr(HayStack, needle, false, -1)
        }

        ; 注解字符：如以括号和字符串结尾，光标向左偏移2位（Spring注解）
        inComment(value) {
            HayStack := '")'
            needle := SubStr(value, -2, 2)
            return InStr(HayStack, needle, false, -1)
        }

        ; 成对符号：如以成对符号(右)结尾，光标向左偏移1位
        inCouple(value) {
            HayStack := ")`]`}>）〉》】｝’”"
            needle := SubStr(value, -1, 1)
            return InStr(HayStack, needle, false, -1)
        }

    }

}