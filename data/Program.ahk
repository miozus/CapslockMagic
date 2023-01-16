; 启动器：常用软件
class Launcher {

    ; === 环境 =================================================

    class Java {
        static JDK := "C:\Users\miozus\.jdks\jdk1.8.0_202\bin\java"
    }

    ; === 开发 =================================================

    static idea() {
        if WinExist("ahk_class SunAwtFrame ahk_exe idea64.exe") {
            path := A_Programs "\JetBrains Toolbox\IntelliJ IDEA Ultimate.lnk"
            activateOrRun("ahk_class SunAwtFrame ahk_exe idea64.exe", path)
        }
    }

    static vscode() {
        path := A_Programs "\Visual Studio Code\Visual Studio Code.lnk"
        activateOrRun("ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe", path)
    }

    static uniapp() {
        path := A_Desktop "\HBuilder X.lnk"
        activateOrRun("ahk_class Qt5QWindowIcon ahk_exe HBuilderX.exe", path)
    }

    static wxDevTools() {
        activateOrRun("ahk_class Chrome_WidgetWin_1 ahk_exe wechatdevtools.exe", "")
    }

    static tabby() {
        path := "bin\util\Tabby Terminal.lnk"
        activateOrRun("ahk_class Chrome_WidgetWin_1 ahk_exe Tabby.exe", path)
    }

    static terminal() {
        path := "bin\util\Windows Terminal.lnk"
        activateOrRun("ahk_exe WindowsTerminal.exe", path)
    }

    ; === 数据 =================================================

    static navicat() {
        path := A_ProgramsCommon "\PremiumSoft\Navicat Premium 16.lnk"
        activateOrRun("ahk_class TNavicatMainForm ahk_exe navicat.exe", path)
    }

    static redisManager() {
        path := A_Desktop "\Another Redis Desktop Manager.lnk"
        activateOrRun("ahk_exe Another Redis Desktop Manager.exe", path)
    }

    ; === 测试 =================================================

    static apifox() {
        path := A_Programs "\Apifox.lnk"
        ActivateOrRun("ahk_class Chrome_WidgetWin_1 ahk_exe Apifox.exe", path)
    }

    static jmeter() {
        jmeter := "E:\Java\apache-jmeter-5.4.1\bin\jmeter.bat"
        params := " -t E:\Java\apache-jmeter-5.4.1\MyTest\谷粒商城压力测试.jmx"
        activateOrRun("Apache JMeter", "wt.exe " jmeter, params)
    }

    ; === 监控 =================================================

    static visualVM() {
        visualvm := "E:\Java\visualvm_21\bin\visualvm"
        params := " --jdkhome " Launcher.Java.JDK
        activateOrRun(visualvm, "wt.exe " visualvm, params)
    }

    static arthas() {
        arthas := Launcher.Java.JDK
        params := " -jar E:\Java\arthas-packaging-3.5.3-bin\arthas-boot.jar"
        activateOrRun(arthas, "wt.exe " arthas, params)
    }

    static todesk() {
        ActivateOrRun("ahk_exe ToDesk.exe", "")
    }

    ; === 浏览器 =================================================

    static google() {
        path := A_AppData "\Microsoft\Internet Explorer\Quick Launch\Google Chrome.lnk"
        activateOrRun("ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe", path)
    }

    ; 谷歌搜索选中文字
    static googleSearch() {
        Send "^c"
        ClipWait 2
        Sleep 50
        Run "https://www.google.com/search?q=" A_Clipboard
    }

    static edge() {
        path := A_Programs "\Microsoft Edge.lnk"
        activateOrRun("ahk_exe msedge.exe", path)
    }

    ; === 笔记 =================================================

    static notion() {
        path := A_Programs "\Notion.lnk"
        activateOrRun("ahk_exe Notion.exe", path)
        IME.set("中文")
    }

    static notionEnhance() {
        path := A_Programs "\Notion Enhanced.lnk"
        activateOrRun("ahk_exe Notion Enhanced.exe", path)
    }

    static drawio() {
        path := "E:\path\to\file.drawio"
        activateOrRun("ahk_exe draw.io.exe", path)
    }

    ; === 办公 =================================================

    static excel() {
        activateOrRun("ahk_exe EXCEL.EXE")
    }

    static ppt() {
        activateOrRun("ahk_exe POWERPNT.EXE")
    }

    ; === 其他 =================================================

    static everything() {
        Send "{blind}!+f"
    }

    static ditto() {
        Send "{blind}^+!b"
    }

    ; 设置快捷键直接粘贴：但vscode快捷键被占用
    ; @Deprecated
    static dittoPasteShotcutKey(index) {
        Send "{Blind}^+!" index
    }

    static dittoPaste(index) {
        Launcher.ditto()
        Send "{Blind}{Down}" index
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


    static ahkHelp() {
        ;   Run "https://wyagd001.github.io/v2/docs/AutoHotkey.htm"
        ;   Run "D:\TOOLS\AutoHotKey\AutoHotkey_H v2.chm"
        path := "tools\AutoHotkey_V2L_CN.chm"
        activateOrRun("AutoHotkey v2", path)
        Send "!s^a"
    }

    static ahkEditor() {
        path := A_Programs "\Visual Studio Code\Visual Studio Code.lnk"
        activateOrRun("CapslockPlus_V2H ahk_exe Code.exe", path, A_WorkingDir)
    }

    static ahk() {
        if winexist("ahk_class autohotkey")
        {
            winActivate
        }
    }

}

; ======================================================================


; 常用网站
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

; ======================================================================

; 一键启动
class Startup {

    static devEco() {
        Launcher.idea()
        Launcher.uniapp()
        Launcher.google()
    }
}