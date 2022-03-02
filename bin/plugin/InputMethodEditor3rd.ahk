;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode "Input"    ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

;=====================================================================o
;               中文输入法特殊优待（默认中文状态使用英文字符）
;                   第三方输入法（如QQ拼音、搜狗）
;---------------------------------------------------------------------o
; 其他中文标点符号，已收录进分号模式的私有字典
#Hotif hasIME()
,:: Send "{text}，"
.:: Send "{text}。"
+`;:: Send "{text}："
+/:: Send "{text}？"
#Hotif
;---------------------------------------------------------------------o


;=====================================================================o
;                    IME Status ToolTip
;---------------------------------------------------------------------o
; 功能：短按切换中英文输入法，长按仍旧上档键
; 作者：知乎 @查理
; 时间：2021年9月
; 更新：https://www.zhihu.com/question/470805790/answer/2022570065
;---------------------------------------------------------------------o
~$RShift:: return
~$RShift up::
{
    ; 延迟间隔: 经过96次测试，大于50则短按稳定, 变量放函数之外可能会被污染
    if (A_TimeSincePriorHotkey > 50 && A_PriorKey = "RShift") {
        switchIME()
    }
}
;---------------------------------------------------------------------o
switchIME() {
    ; 优先完成切换任务，再报告状态（相反的状态，估计发送信号有延迟; 多线程先后问题，用原子操作）
    if (hasIME() = 1) {
        Send "^{Space}"
        ToolTip "EN" 
    } else {
        Send "^{Space}"
        ToolTip "中"
    }
    SetTimer () => ToolTip(), -1000
}
;---------------------------------------------------------------------o
setIME(language)
{
    Sleep 50 ; 等一等是为了承接窗口切换的缓冲
    switch (language) {
        case "EN":
            if (hasIME() = 1) {
                Send "^{Space}"
                ToolTip "EN"
            }
        case "中文":
            if (hasIME() = 0) {
                Send "^{Space}"
                ToolTip "中"
            }
    }
    SetCapsLockState "AlwaysOff"  ; 热键切换一定概率出现大写 A
    SetTimer () => ToolTip(), -200
}
;---------------------------------------------------------------------o
setIDEIME(language:="EN")
{
    MouseGetPos , , ahkId
    title := WinGetProcessName(ahkId)
    if InStr(title, "idea64.exe") or InStr(title, "Code.exe")
    {
        setIME(language)
    }
}
;---------------------------------------------------------------------o
isNotTypingPinYin() {
    return not WinExist("ahk_class QQPinyinCompWndTSF")
}
;---------------------------------------------------------------------o
; IMEの状態の取（获取默认输入法的状态，第三方输入法设为默认，且删除其他输入法）
;   対象： AHK v2.0.0以升
;   WinTitle : 対象Window (省略時:アクティブウィンドウ)
;   戻り値  1:ON 0:OFF
;   API: https://docs.microsoft.com/en-us/previous-versions/windows/embedded/ms920838(v=msdn.10)
;   API: https://docs.microsoft.com/zh-cn/windows/win32/intl/input-method-manager-functions
;---------------------------------------------------------------------o
hasIME(WinTitle:="A")
{
    try {
        hWnd := WinGetID(WinTitle)
    } catch Err {
        ; ^Esc 开始菜单弹窗，卡死在找不到当前窗口
        return
    }
    DetectHiddenWindows True
    result := SendMessage(
            0x283,  ; Message : WM_IME_CONTROL
            0x005,  ; wParam  : IMC_GETOPENSTATUS
            0,      ; lParam  ： (NoArgs)
            ,       ; Control ： (Window)
            ; 当前窗口是否激活了默认输入法
            ; Retrieves the default window handle to the IME class.
            "ahk_id " DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")
            )
    DetectHiddenWindows False
    ; 1 非英文状态
    ; 0 英文状态
    ; the default window handle to the IME class if successful, or NULL otherwise.
    return result
}
;---------------------------------------------------------------------o