;=====================================================================o
;               中文输入法特殊优待（默认中文状态使用英文字符）
;                   微软拼音让它进化了:在一个输入法中，中文和英文模式切换


; Input Method Editor
; 其他中文标点符号，已收录进分号模式的私有字典
#Hotif IME.exists() and EnableChinesePunctuation
,:: Send "{text}，"
.:: Send "{text}。"
+`;:: Send "{blind}{text}："
+/:: Send "{blind}{text}？"
#Hotif

; 声明正在使用的中文输入法类型
; ---
; - MICROSOFT 微软拼音/搜狗五笔/手心输入法
; - QQ        QQ拼音
; - OTHER     搜狗拼音/其他
class PinYinEnum {
    static MICROSOFT := { wParam: "0x001", name: "微软拼音/搜狗五笔/手心输入法", value: "Miocrosoft" }
    static QQ        := { wParam: "0x005", name: "QQ拼音", value: "QQ" }
    static OTHER     := { wParam: "0x005", name: "搜狗拼音/其他", value: "Other" }
}

; Input Method Editor
; 作者：知乎 @查理
; 时间：2022年3月
; 更新：https://www.zhihu.com/question/470805790/answer/2022570065
class IME {

    static wParam := kImeType.wParam
    static typeValue := kImeType.value

    ; 优先完成切换任务，再报告状态（相反的状态，估计发送信号有延迟; 多线程先后问题，用原子操作）
    static toggle() {
        if (this.exists()) {
            Send "^{Space}"
            ToolTip "EN"
        } else {
            Send "^{Space}"
            ToolTip "中"
        }
        SetTimer () => ToolTip(), -1000
    }

    ; @param language EN / 中文
    static set(language)
    {
        Sleep 50    ; 等一等是为了承接窗口切换的缓冲
        switch (language) {
            case "EN":
                if (this.exists() = 1) {
                    Send "^{Space}"
                    ToolTip "EN"
                }
            case "中文":
                if (this.exists() = 0) {
                    Send "^{Space}"
                    ToolTip "中"
                }
        }
        SetCapsLockState "AlwaysOff"    ; 热键切换一定概率出现大写 A
        SetTimer () => ToolTip(), -200
    }

    ; IMEの状態の取
    ;   対象： AHK_H v2.0.0以升
    ;   WinTitle : 対象Window (省略時:アクティブウィンドウ)
    ;   戻り値  1:ON 0:OFF
    ;   （但似乎找不到检测悬浮窗的接口，所以利用 AHK 搜图特性代替）
    ;   API: https://docs.microsoft.com/en-us/windows/win32/intl/wm-ime-control
    ;   API: https://docs.microsoft.com/en-us/previous-versions/windows/embedded/ms920833(v=msdn.10)
    ;   API: https://docs.microsoft.com/zh-cn/windows/win32/intl/input-method-manager-functions
    static exists(WinTitle := "A")
    {
        try {
            hWnd := WinGetID(WinTitle)
        } catch Error {
            ; ^Esc 开始菜单弹窗，卡死在找不到当前窗口
            return
        }
        DetectHiddenWindows True
        result := SendMessage(
            0x283,          ; Message : WM_IME_CONTROL
            this.wParam,    ; wParam  : IMC_GETCONVERSIONMODE
            0,              ; lParam  ： (NoArgs)
            ,               ; Control ： (Window)
            ; 获取当前输入法的模式
            "ahk_id " DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")
        )
        DetectHiddenWindows False
        ; 测试用例（英-中，新/旧，新旧/新旧）
        ; 微软拼音 0/1024-1/1025
        ; 搜狗五笔 0-1025
        ; 搜狗拼音 1025-1025（无效）类型要选 OTHER
        ; 手心    1024-1025
        ; 其他    0-1
        return (result == 1 or result == 1025)
    }

    static setIdeDefault(language := "EN")
    {
        MouseGetPos , , &ahkId
        try {
            ; 预防下拉选项框或虚拟机找不到窗口
            title := WinGetProcessName(ahkId)
        } catch Error {
            return
        }
        if InStr(title, "idea64.exe") or InStr(title, "Code.exe") or InStr(title, "ahk_exe chrome.exe")
        {
            this.set(language)
        }
    }

    ; 策略模式：保持原接口不变，实现方式根据场景可选
    ; 系统有时会自动降级兼容，太诡异了
    static isNotTypingPinYin() {
        return !(this.isTypingPinYinImg() or this.isTypingPinYinWin() or this.isTypingPinYinImgOld())
    }

    ; 适用蓝底白字老版本，Win11白皮肤接口失效，因为窗口常驻后台
    static isTypingPinYinWin() {
        switch this.typeValue {
            case "Microsoft":
                return WinExist("ahk_class Microsoft.IME.UIManager.CandidateWindow.Host")
            case "QQ":
                return WinExist("ahk_class QQPinyinCompWndTSF")
            default:
                return
        }
    }

    ; Win11: 适用新版微软拼音，截图桃心
    static isTypingPinYinImg() {
        CoordMode "Pixel"    ; 将下面的坐标解释为相对于屏幕而不是活动窗口.
        try {
            pixelExist := ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "img\IMElogo.png")
        } catch Error as e {
            return false
        }
        return PixelExist
    }

    ; Win10: 适用旧版微软拼音，截图笑脸
    static isTypingPinYinImgOld() {
        CoordMode "Pixel"    ; 将下面的坐标解释为相对于屏幕而不是活动窗口.
        try {
            pixelExist := ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "img\IMElogoOld.png")
        } catch Error as e {
            return false
        }
        return pixelExist
    }


    static commentCN(startStr := "") {
        SendText startStr " "
        IME.set("中文")
    }

}