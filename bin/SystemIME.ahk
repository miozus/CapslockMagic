;=====================================================================o
;               中文输入法特殊优待（默认中文状态使用英文字符）
;                   微软拼音让它进化了:在一个输入法中，中文和英文模式切换


; Input Method Editor
; 作者：知乎 @查理
; 时间：2022年3月
; 更新：https://www.zhihu.com/question/470805790/answer/2022570065
class IME {

    static wParam := kImeType.wParam
    static lParam := kImeType.lParam

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

    ; 是否存在中文输入法模式
    ; imeの状態の取
    ;   対象： ahk_h v2.0.0以升
    ;   wintitle : 対象window (省略時:アクティブウィンドウ)
    ;   戻り値  1:on 0:off
    ;   参考1：AHK中文手册:窗口消息列表
    ;   参考2: https://www.cnblogs.com/yf-zhao/p/16018481.html
    ;   参考3：https://blog.51cto.com/u_15408625/6220547
    ;   api（获取中英文模式 imc_getconversionmode）: https://learn.microsoft.com/en-us/previous-versions/windows/embedded/ms905959(v=msdn.10)
    ;   api（切换中英文模式 imc_setconversionmode）: https://learn.microsoft.com/en-us/previous-versions/windows/embedded/ms905968(v=msdn.10)
    ;   api: https://docs.microsoft.com/en-us/windows/win32/intl/wm-ime-control
    ;   api: https://docs.microsoft.com/en-us/previous-versions/windows/embedded/ms920833(v=msdn.10)
    ;   api: https://docs.microsoft.com/zh-cn/windows/win32/intl/input-method-manager-functions
    static exists(wintitle := "a")
    {
        try {
            hwnd := wingetid(wintitle)
        } catch error {
            ; ^esc 开始菜单弹窗，卡死在找不到当前窗口
            return
        }
        detecthiddenwindows true

        defaultimewnd := "ahk_id " dllcall("imm32\ImmGetDefaultIMEWnd", "uint", hwnd, "uint")
        ; wparam     imc_getconversionmode  imc_setconversionmode
        ; 微软拼音    0x001                  0x002
        ; 其他输入法  0x005                  0x006
        ;
        ; lparam           en-中文 （返回值含义）
        ; 微软拼音（新）    0-1
        ; 搜狗五笔         0-1025
        ; 微信输入法       0-1025
        ; 微软拼音（旧）   1024-1025
        ; 手心            1024-1025
        ; 搜狗拼音        1025-1025（无效）,类型要选微软拼音或其他
        ; 其他            0-1
        result := sendmessage(
            0x283,            ; message : wm_ime_control | 手册：窗口消息列表
            this.wparam.get,  ; wparam  : imc_getconversionmode
            0,                ; lparam  ： (noargs)
            ,                 ; control ： (window)
            defaultimewnd     ; target  : 当前包含输入法的窗口
        )
        detecthiddenwindows false
        ; 是否中文模式
        return (result == 1 or result == 1025)
    }

    ; 切换输入法
    ; @param language en / 中
    static set(language) {
        ToolTip language
        lParam := language == 'EN' ? this.lParam.EN : this.lParam.CN
        try {
            hWnd := WinGetID("A")
        } catch Error {
            return
        }
        DetectHiddenWindows True
        defaultIMEWnd := "ahk_id " DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")
        result := SendMessage(
            0x283,            ; Message : WM_IME_CONTROL | 手册：窗口消息列表
            this.wParam.SET,  ; wParam  : IMC_GETCONVERSIONMODE
            lParam,           ; lParam  ：数字
            ,                 ; Control ： (Window)
            defaultIMEWnd     ; target  : 输入法所在的窗口
        )
        DetectHiddenWindows False
        setcapslockstate "alwaysoff"    ; 热键切换一定概率出现大写 a
        settimer () => tooltip(), -300

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

    ; =========== 拓展接口 ===========================
    ; 通过窗口判断是否正在打拼音
    ; 策略模式：保持原接口不变，实现方式根据场景可选,系统有时会自动降级兼容，太诡异了
    static isNotTypingPinYin() {
        return !(this.isTypingPinYinImg() or this.isTypingPinYinWin() or this.isTypingPinYinImgOld())
    }

    ; 适用蓝底白字老版本，Win11白皮肤接口失效，因为窗口常驻后台
    static isTypingPinYinWin() {
        return WinExist("ahk_class Microsoft.IME.UIManager.CandidateWindow.Host")
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
        IME.set("中")
    }

}

class ConversionMode {

    class WPraram {
        STATIC MICROSOFT := { GET: "0x001", SET: "0x002" }
        STATIC CUSTOMER := { GET: "0x005", SET: "0x006" }
    }

    class LParam {
        STATIC SIMPLE := { EN: 0, CN: 1 }
        STATIC NORMAL := { EN: 0, CN: 1025 }
        STATIC EARLY := { EN: 1024, CN: 1025 }
    }

}

; 用户正在使用的中文输入法类型
; ---
; - WETYPE          微信输入法(推荐)
; - MICROSOFT       微软拼音(Win11+)
; - MICROSOFT_EARLY 微软拼音
; - SOU_GOU_WU_BI   搜狗五笔
; - SOU_GOU_PIN_YIN 搜狗拼音
; - SHOU_XIN        手心输入法
; - QQ_PIN_YIN      QQ拼音
; - OTHER           其他（需要你调试）
class PinYinEnum {

    static MICROSOFT := {
        wParam: ConversionMode.WPraram.MICROSOFT,
        lParam: ConversionMode.LParam.SIMPLE,
    }

    static MICROSOFT_EARLY := {
        wParam: ConversionMode.WPraram.MICROSOFT,
        lParam: ConversionMode.LParam.EARLY,
    }

    static MICROSOFT_NORMAL := {
        wParam: ConversionMode.WPraram.MICROSOFT,
        lParam: ConversionMode.LParam.NORMAL,
    }

    static WETYPE := {
        wParam: ConversionMode.WPraram.CUSTOMER,
        lParam: ConversionMode.LParam.NORMAL,
    }

    ; 推理仅供参考,以实际效果为准
    static SOU_GOU_WU_BI := PinYinEnum.MICROSOFT_NORMAL
    static SOU_GOU_PIN_YIN := PinYinEnum.MICROSOFT_EARLY
    static SHOU_XIN := PinYinEnum.MICROSOFT_EARLY
    static OTHER := PinYinEnum.MICROSOFT_EARLY
    static QQ_PIN_YIN := PinYinEnum.WETYPE


}