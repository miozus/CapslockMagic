; Integrated Development Environment
class IDE {

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

        ; 前提：Ctrl+C / y 拷贝
        static infoPaste()
        {
            Send "{Esc}"
            SendText "o"
            Sleep 100
            if (App.Vscode.isActive()) {
                Send "console.log()"
                Send '{Left}"' A_Clipboard '{Right}, ' A_Clipboard '{Right};'
            } else if (App.Idea.isActive()) {
                Send "log.info()"
                Send '{Left}"' A_Clipboard
                SendText ' {}'
                Send '{Right}, ' A_Clipboard '{Right};'
            }
            Send "{Esc}"
        }

    }

}
