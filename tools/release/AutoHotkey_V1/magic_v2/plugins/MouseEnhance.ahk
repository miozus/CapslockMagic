#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;=====================================================================o
;                     CapsLock Mouse Controller                      
;---------------------------------------------------------------------o
;   键\修饰	        ✱	         ⌘	           ⌥         +
;   Enter       左键单击       选中一词         选中整行
;   Up             ↑                                    减速  
;   Down           ↓                                    减速  
;   Left           ←                                    减速  
;   Right          →                                    减速  
;---------------------------------------------------------------------o
CapsLock & Up:: 
    if GetKeyState("Shift") = 0 
        MouseMove, 0, -30, 0, R 
    else 
        MouseMove, 0, -10, 0, R 
return 
;---------------------------------------------------------------------o
CapsLock & Down:: 
    if GetKeyState("Shift") = 0 
        MouseMove, 0, 30, 0, R 
    else 
        MouseMove, 0, 10, 0, R 
return 
;---------------------------------------------------------------------o
CapsLock & Left:: 
    if GetKeyState("Shift") = 0 
        MouseMove, -30, 0, 0, R 
    else 
        MouseMove, -10, 0, 0, R 
return 
;---------------------------------------------------------------------o
CapsLock & Right:: 
    if GetKeyState("Shift") = 0 
        MouseMove, 30, 0, 0, R 
    else 
        MouseMove, 10, 0, 0, R 
return 
;---------------------------------------------------------------------o
CapsLock & Enter:: 
    if GetKeyState("alt") = 1 
    {
        sendEvent, ^{left}^+{right} 
        send, ^c
    } 
    else if GetKeyState("ctrl") = 1
    {
        SendEvent, {End}+{Home}
    } else {
        SendEvent {Blind}{LButton down} 
        KeyWait Enter 
        SendEvent {Blind}{LButton up} 
    }
    
return 
;---------------------------------------------------------------------o

;=====================================================================o
;                    Mouse Macro                                                             
;---------------------------------------------------------------------o
~LButton::
    INTERVAL_TIME := 2500      
    ; 左键点击，传递全局变量，才能会悬浮提示当前输入法状态
    If (A_Cursor = "IBeam" ) {
        EDIT_MODE := 1
    } else if (A_Cursor = "Arrow" ) {
        EDIT_MODE := 0
    } 
    ; 首次点击开始计时，此后都会提示；间隔时间至少2.5s以上，间隔之内不提示
    if (A_TimeSincePriorHotkey > INTERVAL_TIME && A_PriorKey = "LButton")
    {
        showIMETooltip()
    }
return
;---------------------------------------------------------------------o
~LButton up::
    SetCapsLockState, off  ; 避免点击后，切换程序脚本发疯成大写，影响vim
    Sleep,1000
    ToolTip
return
;-------------------------------------------------------------------o
; 移动光标选中文字松开（涂色，而非拖拽到其他窗口）: 复制
; 失败品：并不能识别“选中并高亮”这个行为，随便点击也会触发
copyCursorSelect(){
    DRAG_MOVE_TRESHOLD := 20 ; pixels
    MouseGetPos, pos_x1, pos_y1
    win1 := WinActive("A")
    KeyWait, LButton, ,t1
    if ErrorLevel
    {
        MouseGetPos, pos_x2, pos_y2
        win2 := WinActive("A")
        WinGetClass _class, A
        if(((abs(pos_x2 - pos_x1) > DRAG_MOVE_TRESHOLD
            or abs(pos_y2 - pos_y1) > DRAG_MOVE_TRESHOLD)) 
            and win1 = win2 and _class != "ConsoleWindowClass")
        {
            SendInput ^c
        }
    }
}
;-------------------------------------------------------------------o
copySelectByXButon(){
    KeyWait, RButton, ,T3
    sendInput, ^c

}
;---------------------------------------------------------------------o
; CapsLock & 1::
;     MouseClick, Left, 340, 680, 1
;     MouseClick, Left, 1080, 730, 1
; return
;---------------------------------------------------------------------o