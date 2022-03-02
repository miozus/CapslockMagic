;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode "Input"    ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

;=====================================================================o
;                    中文输入法特殊优待（默认中文状态使用英文字符）
;    微软输入法特供添加英文输入法，中文输入法切换
;        中文输入法必须关闭：
;            每个窗口记住不同的输入法状态
;            智能检测上下文语境，物理语境等
;            * 还要锁死英文标点符kk
;---------------------------------------------------------------------o
global keyboardLayoutId := Map(
    "中文", 134481924,
    "EN", 67699721,
)
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
        setIME("EN")
        ToolTip "EN" 
    } else {
        setIME("中文")
        ToolTip "中"
    }
    SetTimer () => ToolTip(), -200
}
;---------------------------------------------------------------------o
setIME(language)
{
    Sleep 50 ; 等一等是为了承接窗口切换的缓冲
    PostMessage(0x50, 0, keyboardLayoutId[language],, WinGetTitle("A"))
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
    ; 可能有用
    return not WinExist("ahk_class Microsoft.IME.UIManager.CandidateWindow.Host")
}
;---------------------------------------------------------------------o
; IMEの状態の取（获取默认输入法的状态，第三方输入法设为默认，且删除其他输入法，关闭每个窗口不同的输入法）
;   対象： AHK v2.0.0以升
;   WinTitle : 対象Window (省略時:アクティブウィンドウ)
;   戻り値  1:ON 0:OFF
;   API: https://docs.microsoft.com/zh-cn/windows/win32/intl/input-method-manager-functions
;   via: https://www.jianshu.com/p/c1b412c25712
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
    ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", hWnd, "UInt", 0)
    InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
    DetectHiddenWindows False
    ; 1 非英文状态
    ; 0 英文状态
    return InputLocaleID == keyboardLayoutId["中文"]
}
;---------------------------------------------------------------------o