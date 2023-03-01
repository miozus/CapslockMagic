CoordMode "Mouse" ; 开启鼠标获取相对于屏幕的坐标，备忘录模式
CoordMode "Caret"


;=====================================================================o
;                     CapsLock Mouse Controller

;   键\修饰	        ✱	        ⌘!	           ⌥#         +       ^
;   Enter       左键N击       选中一词         选中整行
;   Up             ↑                                    减速
;   Down           ↓                                    减速
;   Left           ←                                    减速
;   Right          →                                    减速

CapsLock & Up::
{
    MouseMove 0, -10, 0, "R"
}

CapsLock & Down::
{
    MouseMove 0, 10, 0, "R"
}

CapsLock & Left::
{
    MouseMove -10, 0, 0, "R"
}

CapsLock & Right::
{
    MouseMove 10, 0, 0, "R"
}

CapsLock & Enter::
{
    if GetKeyState("Alt") = 1
    {
        SendEvent "{RButton}"
    }
    else if GetKeyState("LWin") = 1
    {
        sendEvent "^{Left}^+{Right}"
        Send "^c"
    }
    else if GetKeyState("Ctrl") = 1
    {
        SendEvent "{End}+{Home}"
    } else {
        ; 模拟鼠标点击
        SendEvent "{Blind}{LButton down}"
        KeyWait "Enter"
        SendEvent "{Blind}{LButton up}"
        IME.setIdeDefault("EN")
    }

}

; 物理鼠标点击
~LButton::
{
    IME.setIdeDefault("EN")
    ; MouseShadowAvatar.signPhysical()
}

~LButton up::
{
    ; 清空输入法显示状态了
    ; Sleep 500
    ; ToolTip
}


; 鼠标禅模式(BlockInput)
; ----
; - 管理员身份运行脚本才生效，阻塞所有输入设备与计算机交互，监听按下的物理逻辑状态
; - UAC 问题，可通过 shell 降权，以普通用户权限启动应用，已实现在 common 插件里
; - 脚本所有热键（功能），仍然有效；甚至作废的组合，死灰复燃；所以只按字母键就好
; - 外部嵌套函数的所有组合键已锁死按下状态，无法改变（闭包），甚至{Blind} 盲从模式也失效了，获取状态永远为 1
class Mouse {

    static move()
    {
        MouseShadowAvatar.sign()
        ToolTip "🖱️"
        ; 安静地监听键盘输入
        this.onKeyPress()
    }

    static speedUp(event, OFFSET := 97)
    {
        OFFSET := kMouseMoveSpeedFast
        OFFSET_SLOW := kMouseMoveSpeedSlow
        if GetKeyState("a", "p")
        {
            OFFSET := OFFSET_SLOW
        }
        ToolTip event
        this.doMove(event, OFFSET)
        SetTimer () => ToolTip(), -500
    }

    static doMove(event, OFFSET := 97)
    {
        global CurrentMousePosX, CurrentMousePosY
        WingetPos &x, &y, &w, &h, "A"
        x0 := w / 4
        y0 := h / 4
        switch (event)
        {
            case "↑": MouseMove 0, -OFFSET, 0, "R"
            case "↓": MouseMove 0, +OFFSET, 0, "R"
            case "←": MouseMove -OFFSET, 0, 0, "R"
            case "→": MouseMove +OFFSET, 0, 0, "R"
            case "🖱️": Click
            case "⚙️": Click "Right"
            case "⏫": Click "WheelUp"
            case "⏬": Click "WheelDown"
            case "◀": Click "XButton2"
            case "▶": Click "XButton1"
            case "💕": Send "^c"
            case "💌": Send "^v"
                ;  w e r
                ;   s d f
                ;    x c v
            case "w": mousemove x + x0 * 1 * 0.4, y + y0 * 0.1    , 0 ; [1, 1]
            case "e": mousemove x + x0 * 2      , y + y0 * 0.1    , 0 ; [2, 1]
            case "r": mousemove x + x0 * 3 * 1.2, y + y0 * 0.1    , 0 ; [3, 1]
            case "s": mousemove x + x0 * 1 * 0.4, y + y0 * 2      , 0 ; [1, 2]
            case "d": mousemove x + x0 * 2      , y + y0 * 2      , 0 ; [2, 2]
            case "f": mousemove x + x0 * 3 * 1.2, y + y0 * 2      , 0 ; [3, 2]
            case "x": mousemove x + x0 * 1 * 0.4, y + y0 * 3 * 1.2, 0 ; [1, 3]
            case "c": mousemove x + x0 * 2      , y + y0 * 3 * 1.2, 0 ; [2, 3]
            case "v": mousemove x + x0 * 3 * 1.2, y + y0 * 3 * 1.2, 0 ; [3, 3]
            default:
                return
        }
        MouseGetPos &CurrentMousePosX, &CurrentMousePosY
    }

    ; 设定的键位重复时，reload 脚本检测不出，运行时乱按会陷入死循环，需要仔细排查重复
    static onKeyPress()
    {
        BlockInput "On"
        loop
        {
            if GetKeyState("h", "P") {
                this.speedUp("←")
            } else if GetKeyState("j", "p") {
                this.speedUp("↓")
            } else if GetKeyState("k", "p") {
                this.speedUp("↑")
            } else if GetKeyState("l", "p") {
                this.speedUp("→")
            } else if GetKeyState("i", "p") {
                this.speedUp("🖱️")
            } else if GetKeyState("o", "p") {
                this.speedUp("⚙️")
            } else if GetKeyState("n", "p") {
                this.speedUp("◀")
            } else if GetKeyState("m", "p") {
                this.speedUp("▶")
            } else if GetKeyState("u", "p") {
                ; 习惯 cpas + U / P 滚屏翻页; 按住不放时，会受外部起始逻辑影响，变成 ^{WU}
                this.speedUp("⏫")
            } else if GetKeyState("p", "p") {
                this.speedUp("⏬")
            } else if GetKeyState("q", "p") {
                this.speedUp("💕")
            } else if GetKeyState("z", "p") {
                this.speedUp("💌")
            } else if GetKeyState("a", "p") {
                ; 起始容易误触，所以置空
            } else if GetKeyState("b", "p") {
                MouseShadowAvatar.switchPosition("🐱")
            } else if GetKeyState("g", "p") {
                MouseShadowAvatar.switchPosition("👥")
            } else if GetKeyState("w", "p") {
                this.speedUp("w")
            } else if GetKeyState("e", "p") {
                this.speedUp("e")
            } else if GetKeyState("r", "p") {
                this.speedUp("r")
            } else if GetKeyState("s", "p") {
                this.speedUp("s")
            } else if GetKeyState("d", "p") {
                this.speedUp("d")
            } else if GetKeyState("f", "p") {
                this.speedUp("f")
            } else if GetKeyState("x", "p") {
                this.speedUp("x")
            } else if GetKeyState("c", "p") {
                this.speedUp("c")
            } else if GetKeyState("v", "p") {
                this.speedUp("v")
            } else if GetKeyState("Space", "p") {
                ToolTip "⏹" ; 物理按键停止
                break
            } else if GetKeyState("Esc", "p") {
                ToolTip "⏹" ; 物理按键停止
                break
            } else if A_TimeIdlePhysical > 2000 {
                ToolTip "⌛" ; 超时自动停止
                break
            }
        }
        BlockInput "Off"
    }

}

; 备忘录模式：记录鼠标（坐标）影分身
global mouseMemoCount := 0
global mouseClickCount := 0

; 鼠标影分身（水波纹）
; ---
; 每次点击鼠标，会掀起水面涟漪，留下分身，返回上次位置
; @Deprecated
class MouseShadowAvatar {

    ; 获取屏幕坐标，留下影分身，可返回原处
    static sign()
    {
        global BeforeMousePosX, BeforeMousePosY, CaretX, CaretY
        MouseGetPos &BeforeMousePosX, &BeforeMousePosY
        ; 如果无法获取 IDE 的编辑区光标时，设定两个一样
        try if !CaretGetPos(&CaretX, &CaretY)
        {
            CaretX := BeforeMousePosX
            CaretY := BeforeMousePosY
        }
    }

    static signPhysical()
    {
        global mouseClickCount
        global BeforeMousePosX, BeforeMousePosY, CaretX, CaretY, CurrentMousePosX, CurrentMousePosY
        if (mouseClickCount != 0) {
            ; 两元素交换需要第三方支援
            CaretX := BeforeMousePosX
            caretY := BeforeMousePosY
            MouseGetPos &CurrentMousePosX, &CurrentMousePosY
            BeforeMousePosX := CurrentMousePosX
            BeforeMousePosY := CurrentMousePosY
        } else {
            ; 初始化副本和第三个元素
            MouseGetPos &CurrentMousePosX, &CurrentMousePosY
            BeforeMousePosX := CurrentMousePosX
            BeforeMousePosY := CurrentMousePosY
            CaretX := CurrentMousePosX
            caretY := CurrentMousePosY
        }
        mouseClickCount++
    }


    static switchPosition(event)
    {
        global mouseMemoCount
        switch (Mod(mouseMemoCount, 2))
        {
            case 0: this.doSwitch(event)
            case 1: this.doSwitch("↩")
        }
        mouseMemoCount++
    }

    static doSwitch(event)
    {
        ToolTip event
        global BeforeMousePosX, BeforeMousePosY, CaretX, CaretY, CurrentMousePosX, CurrentMousePosY
        switch (event)
        {
            ; 编辑模式：工字型光标位置
            case "🐱": MouseMove CaretX, CaretY
            case "↩": MouseMove CurrentMousePosX, CurrentMousePosY
                ; 禅模式之前的鼠标位置（但ahk能力有限，在ide里两者混同了）
            case "👥": MouseMove BeforeMousePosX, BeforeMousePosY
        }
        SetTimer () => ToolTip(), -500
    }
}