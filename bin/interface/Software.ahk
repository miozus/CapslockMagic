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
    
    ; 拓展 AOP 失败
    ; 继承父类，两者互不影响，表现在以下几个方面
    ; 1.super 指向父类但是属性只读 , this 指代它所在的距离最近的 class 内部属性（相当于self）
    ; 2.加载 __New 比子类快，
    ; 3.重写名称相同的方法，会覆盖掉，不会调用父类的模板
    ; 子类 __New 定义 this.DefineProp 调用父类切面，导致死循环 StackOverFlow

}
