; IDE 统一动作，通过VIM操作
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
