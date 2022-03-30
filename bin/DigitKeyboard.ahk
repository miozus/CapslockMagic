SendMode "Input"    ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

;=====================================================================o
;               Digit Mode Registry
;               
;        按住3不松手: 右手变成小键盘, 横板数字键变成 Fn 键, 特殊地 F3=fn2+3
;               

global EnableDigitKeyboard := false

*3::
{
    global EnableDigitKeyboard
    thisHotkey := A_ThisHotkey
    disableOtherHotkey(thisHotkey)
    EnableDigitKeyboard := true
    ToolTip "🔢"
    keywait "3" 
    EnableDigitKeyboard := false
    if (A_PriorKey == "3" && A_TimeSinceThisHotkey < 350)
    {
        Send "{blind}3"
    }
    enableOtherHotkey(thisHotkey)
    ToolTip
}

#Hotif EnableDigitKeyboard
; 对应标准的小键盘指法
*h::Send "{blind}," ; 方便输坐标
*Y::Send "{blind}."
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
