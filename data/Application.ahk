#Include ..\bin\interface\Software.ahk

; 启动器：常用软件
class App {

    ; === 环境 =================================================

    class Java {
        static JDK := "C:\Users\miozus\.jdks\jdk1.8.0_202\bin\java"
    }

    ; === 开发 =================================================

    class Idea extends Software {
        static __New() {
            this.title := "ahk_class SunAwtFrame ahk_exe idea64.exe"
            this.path := A_Programs "\JetBrains Toolbox\IntelliJ IDEA Ultimate.lnk"
        }
    }

    class Vscode extends Software {
        static __New() {
            this.title := "ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe"
            this.path := A_Programs "\Visual Studio Code\Visual Studio Code.lnk"
        }
    }

    class Uniapp extends Software {
        static __New() {
            this.title := "ahk_class Qt5QWindowIcon ahk_exe HBuilderX.exe"
            this.path := A_Desktop "\HBuilder X.lnk"
        }

        static closeForce() {
            this.activate()
            Send "!{F4}"
        }
    }

    class WxDevTools extends Software {
        static __New() {
            this.title := "ahk_class Chrome_WidgetWin_1 ahk_exe wechatdevtools.exe"
            this.path := ""
        }
    }

    class Tabby extends Software {
        static __New() {
            this.title := "ahk_class Chrome_WidgetWin_1 ahk_exe Tabby.exe"
            this.path := "tools\Tabby Terminal.lnk"
        }
    }

    class Terminal extends Software {
        static __New() {
            this.title := "ahk_exe WindowsTerminal.exe"
            this.path := "tools\Windows Terminal.lnk"
        }
    }


    ; === 数据 =================================================

    class Navicat extends Software {
        static __New() {
            this.title := "ahk_class TNavicatMainForm ahk_exe navicat.exe"
            this.path := A_ProgramsCommon "\PremiumSoft\Navicat Premium 16.lnk"
        }
    }

    class RedisManager extends Software {
        static __New() {
            this.title := "ahk_exe Another Redis Desktop Manager.exe"
            this.path := A_Desktop "\Another Redis Desktop Manager.lnk"
        }
    }
    
    ; === 网络 =================================================

    class DNS extends Software {
        
        static __New() {
            this.args :=  " C:\Windows\System32\drivers\etc\hosts"
            this.title := "hosts - Visual Studio Code"
            this.path := App.Vscode.path
        }

    }

    ; === 测试 =================================================

    class Apifox extends Software {

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
        params := " --jdkhome " App.Java.JDK
        activateOrRun(title, "wt.exe " title, params)
    }

    static arthas() {
        title := App.Java.JDK
        params := " -jar E:\Java\arthas-packaging-3.5.3-bin\arthas-boot.jar"
        activateOrRun(title, "wt.exe " title, params)
    }


    class Todesk extends Software {
        static __New() {
            this.title := "ahk_exe ToDesk.exe"
            this.path := ""
        }
    }


    ; === 浏览器 =================================================

    class Chrome extends Software {

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
    
    class Figma extends Software {

        static __New() {
            this.title := " Figma - Google Chrome ahk_class Chrome_WidgetWin_1"
            this.path := "https://www.figma.com/file/IMSlvvPACLl36rzjMPnv98/uView1-UI-Kit-%EF%BC%88Probe%EF%BC%89-(Community)?type=design&node-id=2258-4073&t=yMPcmikHeRq4HIJP-0"
        }
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

    class Wemeet extends Software {
        static __New() {
            this.title := "ahk_class TXGuiFoundation ahk_exe wemeetapp.exe"
            this.path := A_Programs "\腾讯会议.lnk"
        }
        
    }

    ; === 其他 =================================================

    static eaudic() {
        Send "{blind}!+m"
    }

    static everything() {
        Send "{blind}!+f"
    }

    static ditto() {
        Send "{blind}^+!b"
    }

    static dittoPaste(index) {
        App.ditto()
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

    class AHK {

        static help() {
            ;   Run "https://wyagd001.github.io/v2/docs/"
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
            activateOrRun("ahk_exe WindowSpy.exe", A_ScriptDir "\bin\util\WindowSpy.ahk")
        }

        static winSoundComponent() {
            ActivateOrRun("Sound Components ahk_class AutoHotkeyGUI ahk_exe AutoHotkey64.exe", A_ScriptDir "\bin\util\SoundComponent.ahk")
        }

    }

    class TxCouldGame extends Software {
        static __New() {
            this.title := "ahk_class Qt5152QWindowIcon ahk_exe START.exe"
            this.path := A_Programs "\腾讯游戏\START\START.lnk"
        }
    }

    class WeChat extends Software {
        static __New() {
            this.title := "ahk_class WeChatMainWndForPC ahk_exe WeChat.exe"
            this.path := A_Programs "\微信\微信.lnk"
        }
    }

    class QQLive extends Software {
        static __New() {
            this.title := "ahk_class TXGuiFoundation ahk_exe QQLive.exe"
            this.path := A_Programs "\腾讯软件\腾讯视频\腾讯视频.lnk"
        }
    }

}


; ======================================================================

; 一键启动
class BatchLauncher {

    static devStart()
    {
        ; 腾出内存
        App.TxCouldGame.close()
        App.Wemeet.close()
        App.QQLive.close()
        ; 运行工具
        App.Idea.run()
        App.Vscode.run()
        ; App.Uniapp.run()
        App.Chrome.run()
    }

    static devExit()
    {
        App.Idea.close()
        App.Uniapp.closeForce()
        App.Navicat.close()
        App.RedisManager.close()
        App.Todesk.close()
        App.Tabby.close()
        App.Terminal.close()
        App.Apifox.close()
        ; 多个窗口
        Loop 2 {
            Sleep 1000
            App.Vscode.close()
            App.WxDevTools.close()
        }
        ; 延迟出现的窗口
        SetTimer () => App.WxDevTools.close(), -2000
    }

    static gameStart() {
        this.devExit()
        App.TxCouldGame.run()
    }

    static gameExit() {
        App.TxCouldGame.close()
    }
}

;; ======================================================================

; 运行环境
class Enviorment {

    static hasIde() {
        ides := [
            App.Idea,
            App.Vscode,
            App.Terminal,
            App.Tabby,
            App.Todesk,
        ]
        for ide in ides
            if WinActive(ide.Title)
                return true
        return false
    }

    static hasNotIde() {
        return !this.hasIde()
    }

}