; 启动器：常用软件
class Launcher {

    ; === 环境 =================================================

    class Java {
        static JDK := "C:\Users\miozus\.jdks\jdk1.8.0_202\bin\java"
    }

    ; === 开发 =================================================

    class Idea extends Program {
        static __New() {
            this.title := "ahk_class SunAwtFrame ahk_exe idea64.exe"
            this.path := A_Programs "\JetBrains Toolbox\IntelliJ IDEA Ultimate.lnk"
        }
    }

    class Vscode extends Program {
        static __New() {
            this.title := "ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe"
            this.path := A_Programs "\Visual Studio Code\Visual Studio Code.lnk"
        }
    }

    class Uniapp extends Program {
        static __New() {
            this.title := "ahk_class Qt5QWindowIcon ahk_exe HBuilderX.exe"
            this.path := A_Desktop "\HBuilder X.lnk"
        }

        static closeForce() {
            this.activate()
            Send "!{F4}"
        }
    }

    class WxDevTools extends Program {
        static __New() {
            this.title := "ahk_class Chrome_WidgetWin_1 ahk_exe wechatdevtools.exe"
            this.path := ""
        }
    }

    class Tabby extends Program {
        static __New() {
            this.title := "ahk_class Chrome_WidgetWin_1 ahk_exe Tabby.exe"
            this.path := "bin\util\Tabby Terminal.lnk"
        }
    }

    class Terminal extends Program {
        static __New() {
            this.title := "ahk_exe WindowsTerminal.exe"
            this.path := "bin\util\Windows Terminal.lnk"
        }
    }


    ; === 数据 =================================================

    class Navicat extends Program {
        static __New() {
            this.title := "ahk_class TNavicatMainForm ahk_exe navicat.exe"
            this.path := A_ProgramsCommon "\PremiumSoft\Navicat Premium 16.lnk"
        }
    }

    class RedisManager extends Program {
        static __New() {
            this.title := "ahk_exe Another Redis Desktop Manager.exe"
            this.path := A_Desktop "\Another Redis Desktop Manager.lnk"
        }
    }

    ; === 测试 =================================================

    class Apifox extends Program {

        static __New() {
            this.title := "ahk_class Chrome_WidgetWin_1 ahk_exe Apifox.exe"
            this.path := A_Programs "\Apifox.lnk"
        }

        static submit() {
            this.activate()
            Send "{Blind}^{Enter}"
        }
    }

    static jmeter() {
        jmeter := "E:\Java\apache-jmeter-5.4.1\bin\jmeter.bat"
        params := " -t E:\Java\apache-jmeter-5.4.1\MyTest\谷粒商城压力测试.jmx"
        title := "Apache JMeter"
        activateOrRun(title, "wt.exe " jmeter, params)
    }

    ; === 监控 =================================================

    static visualVM() {
        title := "E:\Java\visualvm_21\bin\visualvm"
        params := " --jdkhome " Launcher.Java.JDK
        activateOrRun(title, "wt.exe " title, params)
    }

    static arthas() {
        title := Launcher.Java.JDK
        params := " -jar E:\Java\arthas-packaging-3.5.3-bin\arthas-boot.jar"
        activateOrRun(title, "wt.exe " title, params)
    }


    class Todesk extends Program {
        static __New() {
            this.title := "ahk_exe ToDesk.exe"
            this.path := ""
        }
    }


    ; === 浏览器 =================================================

    class Chrome extends Program {

        static __New() {
            this.path := A_AppData "\Microsoft\Internet Explorer\Quick Launch\Google Chrome.lnk"
            this.title := "ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe"
        }

        static searchSelected() {
            Send "^c"
            ClipWait 2
            Sleep 50
            Run "https://www.google.com/search?q=" A_Clipboard
        }

        static refresh() {
            this.activate()
            Send "{Blind}^r"
        }
    }


    ; 谷歌搜索选中文字

    static edge() {
        path := A_Programs "\Microsoft Edge.lnk"
        title := "ahk_exe msedge.exe"
        activateOrRun(title, path)
    }

    ; === 笔记 =================================================

    static notion() {
        path := A_Programs "\Notion.lnk"
        title := "ahk_exe Notion.exe"
        activateOrRun(title, path)
        IME.set("中文")
    }

    static notionEnhance() {
        path := A_Programs "\Notion Enhanced.lnk"
        title := "ahk_exe Notion Enhanced.exe"
        activateOrRun(title, path)
    }

    static drawio() {
        path := "E:\seeyon\project\安顺市平坝区煤矿企业产销量综合监管平台项目\UML\协同分析业务流程设计稿.drawio"
        title := "ahk_exe draw.io.exe"
        activateOrRun(title, path)
    }

    ; === 办公 =================================================

    static excel() {
        title := "ahk_exe EXCEL.EXE"
        activateOrRun(title)
    }

    static ppt() {
        title := "ahk_exe POWERPNT.EXE"
        activateOrRun(title)
    }

    ; === 其他 =================================================

    static everything() {
        Send "{blind}!+f"
    }

    static ditto() {
        Send "{blind}^+!b"
    }

    static dittoPaste(index) {
        Launcher.ditto()
        Loop index {
            Send "{Blind}{Down}"
            Sleep 50
        }
        Send "{Blind}{Enter}"
    }

    static hwMirror() {
        if WinExist("ahk_exe HwMirror.exe") {
            WinActivate
        }
    }

    ; 资源管理器
    static explorer() {
        activateOrRun("ahk_class CabinetWClass", "")
    }

    static explorerReload() {
        path := "tools\重启资源管理器.exe"
        ActivateOrRun("", path, "", "")
    }

    static notepad() {
        pasteInNotepad()
        path := "notepad"
        activateOrRun("记事本", path, "", "")
    }

    class Ahk {

        static help() {
            ;   Run "https://wyagd001.github.io/v2/docs/AutoHotkey.htm"
            ;   Run "D:\TOOLS\AutoHotKey\AutoHotkey_H v2.chm"
            path := "tools\AutoHotkey_V2L_CN.chm"
            title := "AutoHotkey v2"
            activateOrRun(title, path)
            Send "!s^a"
        }

        static edit() {
            path := A_Programs "\Visual Studio Code\Visual Studio Code.lnk"
            title := "CapslockPlus_V2H ahk_exe Code.exe"
            activateOrRun(title, path, A_WorkingDir)
        }

        static activate() {
            if winexist("ahk_class autohotkey")
            {
                winActivate
            }
        }

        static winSpy() {
            activateOrRun("ahk_exe WindowSpy.exe", "bin\plugin\WindowSpy.ahk")
        }

    }

    class TxCouldGame extends Program {
        static __New() {
            this.title := "ahk_class Qt5152QWindowIcon ahk_exe START.exe"
            this.path := A_Programs "\腾讯游戏\START\START.lnk"
        }
    }

}


; ======================================================================

; 一键启动
class BatchLauncher {

    static devStart() {
        Launcher.TxCouldGame.close()
        Launcher.Idea.run()
        Launcher.Vscode.run()
        Launcher.Uniapp.run()
        Launcher.Chrome.run()
    }

    static devExit() {

        Launcher.Idea.close()
        Launcher.Uniapp.closeForce()
        Launcher.Navicat.close()
        Launcher.RedisManager.close()
        Launcher.Todesk.close()
        Launcher.Tabby.close()
        Launcher.Terminal.close()
        Launcher.Apifox.close()
        ; 多个窗口
        Loop 2 {
            Launcher.Vscode.close()
            Launcher.WxDevTools.close()
        }
        ; 延迟出现的窗口
        SetTimer () => Launcher.WxDevTools.close(), -2000
    }

    static gameStart() {
        this.devExit()
        Launcher.TxCouldGame.run()
    }

    static gameExit() {
        Launcher.TxCouldGame.close()
    }
}

;; ======================================================================


;; 常用网站
class Website {

    static docs() {
        Run "https://docs.qq.com/desktop/"
    }

    static codeGen() {
        Run "https://cloud.codegen.cc/"
    }

    static alg4() {
        Run "https://visualgo.net/zh/sorting"
    }

    static excel2json() {
        Run "https://tableconvert.com/excel-to-json"
    }

    static chatGpt() {
        Run "https://gpt.chatapi.art/"
    }

}


;; ======================================================================

; 软件控制常用方法
class Program {

    static title := ""
    static path := ""

    ; 激活或运行
    static run() {
        activateOrRun(this.title, this.path)
    }

    ; 激活
    static activate() {
        if WinExist(this.title) {
            WinActivate
        }
    }

    ; 关闭
    static close() {
        if WinExist(this.title) {
            WinClose
        }
    }

    static isExist() {
        return WinExist(this.title)
    }

}