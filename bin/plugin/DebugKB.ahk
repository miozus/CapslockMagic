#Include impl\Debug.ahk
#Include impl\IDE.ahk
#Include impl\Idea.ahk
#Include ..\..\data\Application.ahk

;=====================================================================o
;               Intelj Keymap for debug

global EnableDebugKeyboard := false

#Hotif EnableDebugKeyboard
^1:: Debug.stepOverForce()
*1:: Debug.stepOver()
^2:: Debug.stepIntoForce()
*2:: Debug.stepIntoSmart()
^3:: Debug.stepOut()
*3:: Debug.resumeProgram()

*5:: Idea.Jrebel.hotspot()
*6:: Debug.reboot()
*[:: IDE.usage()
*]:: IDE.hierarchy()
*\:: Debug.run2Cursor()

*A:: Debug.exitSilent()
*I:: Debug.exitSilent()
*O:: Debug.exitSilent()
*S:: Debug.exitSilent()
*C:: Debug.exitSilent()

^Tab:: Idea.Jrebel.hotspot()
*Tab:: App.Chrome.refresh()
^Esc:: Debug.view()
*Esc:: Debug.exit()
*Space:: Debug.evaluate()
#Hotif

; 调试小键盘
; ---
; - 进入：
;   - 一次性：按住 <4> 不松手步入
;   - 循环使用：分号模式输入 dbg 开启
; - 退出：
;   - 明示：<Esc>
;   - 静默：AIOS 增删改代码时，打开计算器时默默退出
*4::
{
    global EnableDebugKeyboard
    thisHotkey := A_ThisHotkey
    GC.disableOtherHotkey(thisHotkey)
    EnableDebugKeyboard := true
    ToolTip "🦉"
    keywait "4"
    EnableDebugKeyboard := false
    if (A_PriorKey == "4" && A_TimeSinceThisHotkey < 350)
    {
        Send "{blind}4"
    }
    GC.enableOtherHotkey(thisHotkey)
    ToolTip
}