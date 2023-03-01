class WxDevTools extends App.WxDevTools {

    static batch() {
        this.restart()
        Sleep 2000
        this.login()
    }

    ; 清空全部缓存和普通编译
    static restart()
    {
        Click "4034 57"
        Click "4039 97"
        Click "4023 170"
        ; 普通编译
        Send "^r"
        ; 编译等待
        Sleep 3000
    }

    static login()
    {
        ; 密码登录 > 登录 > 首页
        Sleep 4000
        Click "3819 626"
        Sleep 2000
        Click "3826 516"
        Sleep 2000
        Click "3674 858"
    }

    static testRegisterCreate() {
        Click "3771 301"
        SendText "机器猫"
        Send "{Tab}"
        SendText "372522196912162618"
        Send "{Tab}"
        SendText "贵州某户籍住址"
        Send "{Tab}"
        SendText "贵州某暂住地址"
        ;
        Click "3752 538"
        Sleep 200
        Click "3746 707"
        Sleep 500
        ;
        Click "3746 595"
        Sleep 200
        Click "3743 710"
        Sleep 500
        ;
        Click "3766 651"
        Sleep 200
        Click "4005 651"
        ;
        ; Click "WheelUp"
        Click "WheelDown"

    }
}