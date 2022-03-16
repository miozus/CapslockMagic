#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;=====================================================================o
;                    Typing Style
;-------------------------------------------------------------------o
; for QQ pinyin return EN origin mark symbol, suit for Notion
; CapsLock & Space:: Send, ^`
;
; 在编辑模式下频繁移动和删除，概率触发切换成大写，所以只用原生的^{space}
; programer habit input symbol, benefit for programer
;
`:: sendInput, {text}`` ; 2021/08/26 间隔点·
/:: sendInput, {text}/
>:: sendInput, {text}>
<:: sendInput, {text}<  ; 2021/08/26 书名号《》
[:: sendInput, {text}[  ; 2021/09/06 中括号【】
]:: sendInput, {text}]
+[:: sendInput, {text}{ ; 2021/09/06 大括号｛｝
+]:: sendInput, {text}}
+4:: sendInput, {text}$ ; 2021/09/13 挂羊头￥
+6:: sendInput, {text}^ ; 2021/09/13 省略号……
;-------------------------------------------------------------------o

;=====================================================================o
;                    补充被屏蔽的符号（小鹤双拼）
;-------------------------------------------------------------------o
;
; 例一：
; 王小峰 {1967 年出生在吉林省九台市 [过去称九台县（介于吉林市和长春市﹝吉林省
; 省会﹞之间）]} 现在是北京某媒体记者。
;
; 例二：
; 【图画文字】用图画来表示意思的文字。特点是用整幅图画表示意思，本身不能分解成字，
; 没有固定的读法。参看 1378 页〖象形文字〗。（《现代汉语词典》修订本）
;
:*:uumkhc::《》
:*:vskohc::【】
:*:dakohc::｛｝
:*:uglthc::……
:*:jmgedm::·
:*:gxyhtz::￥
;-------------------------------------------------------------------o


;=====================================================================o
;                    IME Status ToolTip
;-------------------------------------------------------------------o
; 短按切换中英文输入法，长按仍旧上档键
; 作者：知乎 @查理
; 时间：2021年9月
; 更新链接2：https://www.zhihu.com/question/470805790/answer/2022570065
;-----------------------------------------------------------
~$RShift:: return
~$RShift up:: switchIME()
;------------------------------------------------------------------o
switchIME()
{
    timeInterval := 50  ; 此数值96次测试表现稳定, 变量放函数之外可能会被污染
    if (A_TimeSincePriorHotkey > timeInterval && A_PriorKey = "RShift") {
        ToolTip
        if (hasIME()=1) {
            send, ^{space}
            ToolTip, EN ;shift得反着提示，提示切换后的状态。
        } else {
            send, ^{space}
            ToolTip, 中
        }
        sleep, 1000
        ToolTip
    }
}
;-------------------------------------------------------------------o
setIME(language)
{
    sleep, 50 ; 等一等是为了承接窗口切换的缓冲
    if % language == "中文"
    {
        if (hasIME()=0) {
            send, ^{space}
            ToolTip, 中
        }
    } else if % language == "EN" {
        if (hasIME()=1) {
            send, ^{space}
            ToolTip, EN
        }
    }
    sleep, 50
    SetCapsLockState, alwaysoff ; 避免有时突然大写，破坏我的vim
    Sleep, 1000 ; 悬浮提示（如有）1秒后消失
    ToolTip
}
;-------------------------------------------------------------------o
; 功能：输入法状态提示
; 环境：win10+搜狗输入法，输入法状态切换用默认的shift键。
; 初代作者：CSDN @sunwind
; 更新链接1：https://blog.csdn.net/liuyukuan/article/details/82291632
;-------------------------------------------------------------------o
showIMETooltip()
{
    MouseGetPos, , , WhichWindow, WhichControl
    WinGetPos, winx, winy, , , %WhichWindow%
    ControlGetPos, x, y, w, h, %WhichControl%, ahk_id %WhichWindow%
    ~ ToolTip, %WhichControl%`nX%X%`tY%Y%`nW%W%`t%H%

    if (isNotEditInFocus()=0) 
    {
        if (hasIME()=1)
            ToolTip,中
        else
            ToolTip,EN
    }

}
;------------------------------------------------------------------o
isNotEditInFocus()
{
    Global EDIT_MODE
    ControlGetFocus theFocus, A ; 取得目前活動窗口 的焦點之控件标识符
    return !(inStr(theFocus, "Edit")
            or (theFocus = "Scintilla1") ;把查到是文字編輯卻不含Edit名的theFucus加進來
            or (theFocus ="DirectUIHWND1")
            or (EDIT_MODE = 1))
}
;-----------------------------------------------------------
; IMEの状態の取得
;   対象： AHK v1.0.34以降
;   WinTitle : 対象Window (省略時:アクティブウィンドウ)
;   戻り値  1:ON 0:OFF
;-----------------------------------------------------------
hasIME(WinTitle:="")
{
    ifEqual WinTitle, , SetEnv, WinTitle, A
    WinGet, hWnd, ID, %WinTitle%
    DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint, hWnd, Uint)
    
    ;Message : WM_IME_CONTROL  wParam:IMC_GETOPENSTATUS
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows, ON
    SendMessage 0x283, 0x005, 0, , ahk_id %DefaultIMEWnd%
    DetectHiddenWindows, %DetectSave%
    Return ErrorLevel
}
;-------------------------------------------------------------------o

