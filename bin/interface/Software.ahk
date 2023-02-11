#Include ..\common\Common.ahk

; 软件控制常用方法
class Software {

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

    static isActive() {
        return WinActive(this.title)
    }

}
