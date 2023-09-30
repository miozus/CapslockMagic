#Include GarbageCollector.ahk

; Integrated Development Environment
class IDE {

    static run() {
        Send "{blind!}^{F9}"
    }
    
    static git() {
        Send "!0"
    }

    ; 开始调试
    static debug() {
        Send "^+d"
    }

    ; 服务监控
    static service() {
        ; 特大事故 2023-05-18 2023.2 EPA 版本失效
        Send "{Blind}!7"
    }

    ; 终端
    static terminal() {
        ; 尝试连按两次 Alt 可以解除终端的 ctrl 键锁定
        Send "{Blind!#^}!{F12}"
        ; GC.ModifyKeyPhysical()
    }

    ; 输入法管家
    static esc() {
        ; 如果先返回，图片消失了，就检测不到了，所以最后返回
        Send "{Esc}"
        ; 异步调用，提升速度
        SetTimer () => IME.set("EN"), -200
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


    ; 打印日志方便调试
    class Log {

        static info()
        {
            if (App.Vscode.isActive()) {
                SendText "console.log()"
            } else if (App.Idea.isActive()) {
                SendText "log.info()"
            }
            Send "{Left}"
        }
        

        ; 前提：[NORMAL] Ctrl+C / y 拷贝
        static infoPaste()
        {
            Send "{Esc}"
            Sleep 200
            SendText "o"
            Sleep 300
            ; if (App.Vscode.isActive()) {
                SendText "console.log()"
                Sleep 50
                Send '{Left}"' A_Clipboard '{Right}, ' A_Clipboard '{Right};'
            ; } else if (App.Idea.isActive()) {
            ;     SendText "log.info()"
            ;     Sleep 50
            ;     Send '{Left}"' A_Clipboard
            ;     SendText ' {}'
            ;     Send '{Right}, ' A_Clipboard '{Right};'
            ; }
            Send "{Esc}"
        }

    }

}