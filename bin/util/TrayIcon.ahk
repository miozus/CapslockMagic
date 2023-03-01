; 托盘图标管理
class TrayIcon {

    static turn() {
        ;  停用脚本，为了打字
        if A_IsSuspended {
            Traytip "⏸️ 已暂停"
            TraySetIcon("bin\img\capslock_pause.ico", 1, 1)
            SetTimer () => Traytip(), -1000
        } else {
            Traytip "🖤 继续运行"
            TraySetIcon("bin\img\capslock_run.ico", 1, 1)
            SetTimer () => Traytip(), -1000
        }
    }

    static init() {
        TraySetIcon("bin\img\capslock_run.ico", 1, 1)
        ToolTip "🖤"
        SetTimer () => ToolTip(), -500
    }

}