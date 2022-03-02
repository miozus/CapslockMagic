SendMode "Input"    ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

;=====================================================================o
;                       CapsLock Initializer                         

; 不用使用“Off”因为语法自身瑕疵，会莫名其妙切换大小写，估计源码底层是！写法
SetCapsLockState "AlwaysOff" 
; A_StoreCapsLockMode := false


;=====================================================================o
;                       CapsLock Switcher:                           
;---------------------------------o-----------------------------------o
;                    CapsLock + ` | {CapsLock}                       
;---------------------------------o-----------------------------------o
CapsLock & Esc:: ; 兼顾 60 配列键盘左上角的键
CapsLock & `:: 
{
    if GetKeyState("CapsLock", "T") {
        SetCapsLockState "AlwaysOff"
        Tooltip "a"
        SetTimer () => ToolTip(), -1000
    } else {
        SetCapsLockState "AlwaysOn" 
        Tooltip "A"
        SetTimer () => ToolTip(), -1000
    }
    KeyWait "``","T1"
}

; fix bug: CapsLock + Shift -> SetCapsLockState "AlwaysOn"
; +CapsLock::
; CapsLock & Shift::
; fix bug: ^{Esc} -> Win ; !{Esc} -> WinMini
^CapsLock::
!CapsLock::
{}


;=====================================================================o
;                         CapsLock Escaper:                          

$CapsLock::Esc
CapsLock Up::
{
    keepCapsLockLower()
}


keepCapsLockLower() {
    if GetKeyState("CapsLock", "T") {
        SetCapsLockState "AlwaysOff"
    }
}

;=====================================================================o
;                       CapsLock  Shift Switch                                     

;键\修饰      	✱	         ⌘(Alt)	          ⌥(Ctrl)
;        -             _            页面缩小	
;        =             +            页面放大	
;        [             (            	{	             <
;        ]             )            	}	             >
;        ;             !            	:	
;        '             =            	=	
;        /             ⌘ /		
;        \             ⌘/		
;

CapsLock & -:: 
{
    Send "_" 
} 
CapsLock & =:: 
{
    Send "{+}" 
}

CapsLock & `;::
{
    if GetKeyState("Alt") = 0 
        Send ":" 
    else 
        Send "{!}"  
} 

CapsLock & ':: 
{
    if GetKeyState("Alt") = 0 
        Send "=" 
    else 
        Send "=" 
} 

CapsLock & [:: 
{
    if GetKeyState("control") = 1 
        Send "<" 
    else if GetKeyState("LAlt") = 1 
        Send "{{}" 
    else 
        Send "("
} 

CapsLock & ]:: 
{
    if GetKeyState("control") = 1 
        Send ">" 
    else if GetKeyState("LAlt") = 1 
        Send "{text}}" 
    else 
        Send ")"
} 


;=====================================================================o
;                       CapsLock Media Controller                    

CapsLock & F10:: Volume_Mute 
CapsLock & F11:: Volume_Down 
CapsLock & F12:: Volume_Up 
CapsLock & F8:: Media_Play_Pause 
CapsLock & F5:: Media_Next                                   
CapsLock & F6:: Media_Stop                                   



;=====================================================================o
;                           CapsLock Deletor                         

;   键\修饰	        ✱	         ⌘	           ⌥
;   N	        前删一词	   删至行首        	整行删除
;   M	        前删一字	 🚫前删一词        	将行下移
;   ,	        后删一字	 🚫后删一词        	将行上移
;   .	        后删一词	   删至行尾        	整行删除
;   ⌫	        删除文件	   永久删除         文件	
;

CapsLock & n:: 
{
    if GetKeyState("Alt") = 0
        Send "^{BS}" 
    else 
        Send "+{Home}{BS}"
}

CapsLock & m:: BackSpace

CapsLock & .:: 
{
    if GetKeyState("Alt") = 0
        Send "^{Del}" 
    else 
        Send "+{End}{Del}"
}

CapsLock & ,:: Delete 


;=====================================================================o
;                      CapsLock Window Controller                    
;-----------------------------------o---------------------------------o
;                     CapsLock + s  |  Ctrl + Tab (Swith Tag)        
;                     CapsLock + q  |  Ctrl + W   (Close Tag)        
;   (Disabled)  Alt + CapsLock + s  |  AltTab     (Switch Windows)   
;               Alt + CapsLock + q  |  Ctrl + Tab (Close Windows)    
;                     CapsLock + \  |  AppsKey    (Menu Key)         
;-----------------------------------o---------------------------------o
CapsLock & s:: 
{
    if GetKeyState("Alt") = 1 
        Send "^+{Tab}" 
    else if GetKeyState("Ctrl") = 1
        ; 同类窗口的切换
        SwitchWindows()
    else 
        Send "^{Tab}"
} 

CapsLock & q:: 
{
    if GetKeyState("Alt") = 0 
        Send "^{F4}" 
    else 
        Send "!{F4}" 
} 

; close Tab
CapsLock & w:: ^w

CapsLock & \:: AppsKey

