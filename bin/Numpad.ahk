;=====================================================================o
;               Digit Mode Registry
;               
;        按住3不松手: 右手变成小键盘, 横板数字键变成 Fn 键, 特殊地 F3=fn2+3
;               

global EnableDigitKeyboard := false
#Hotif EnableDigitKeyboard
; 对应标准的小键盘指法
*H::Send "{blind}." ; 小数频率更高
*Y::Send "{blind},"
*N::Send "{blind}{Space}"
*G::Send "{blind}G" ; Vim Goto line
*Space::Send "{blind}0"
*M::Send "{blind}1"
*,::Send "{blind}2"
*.::Send "{blind}3"
*J::Send "{blind}4"
*K::Send "{blind}5"
*L::Send "{blind}6"
*U::Send "{blind}7"
*I::Send "{blind}8"
*O::Send "{blind}9"
*`;::Send "{blind}{Enter}"
*'::Send "{blind}{BackSpace}"
; Fn键 
*Esc::Send "{blind}``"
*1::Send "{blind}{F1}"
^2::Send "{blind!+^}{F12}" ; 浏览器控制台，常用又远
*2::Send "{blind}{F2}"
; *3::Send "{blind}{F3}" ; 牺牲小我，拯救大伙
*4::Send "{blind}{F4}"
*5::Send "{blind}{F5}"
*6::Send "{blind}{F6}"
*7::Send "{blind}{F7}"
*8::Send "{blind}{F8}"
*9::Send "{blind}{F9}"
*0::Send "{blind}{F10}"
*-::Send "{blind}{F11}"
*=::Send "{blind}{F12}"
#Hotif


; 数字小键盘
*3::
{
    global EnableDigitKeyboard
    thisHotkey := A_ThisHotkey
    GC.disableOtherHotkey(thisHotkey)
    EnableDigitKeyboard := true
    ToolTip "🔢"
    keywait "3" 
    EnableDigitKeyboard := false
    if (A_PriorKey == "3" && A_TimeSinceThisHotkey < 250)
    {
        Send "{blind}3"
    }
    GC.enableOtherHotkey(thisHotkey)
    ToolTip
}


class Numpad {
    
    static numpad1() {
        Send "{Numpad1}"
    }

    static numpad2() {
        Send "{Numpad2}"
    }

    static numpad3() {
        Send "{Numpad3}"
    }

    static numpad4() {
        Send "{Numpad4}"
    }

    static numpad5() {
        Send "{Numpad5}"
    }

    static numpad6() {
        Send "{Numpad6}"
    }

    static numpad7() {
        Send "{Numpad7}"
    }

    static numpad8() {
        Send "{Numpad8}"
    }

    static numpad9() {
        Send "{Numpad9}"
    }

    static numpad0() {
        Send "{Numpad0}"
    }

}
