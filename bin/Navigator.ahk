;=====================================================================o
;                    CapsLock Direction Navigator                    
;-----------------------------------o---------------------------------o
;      键\修饰    	✱	     !(+)	      ^         ^!
;        h         ←         选字        跳词      跳选词
;        j         ↓         选字        跳词      跳选词
;        k         ↑         选字        跳词      跳选词
;        l         →         选字        跳词      跳选词
;-----------------------------------o---------------------------------o
CapsLock & h:: 
{
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("Alt") = 0 
            ; 无 左移一字
            Send "{Left}" 
        else 
            ; ! 左选一字
            Send "+{Left}" 
        return 
    } 
    else { 
        ; ^ 左跳一词
        if GetKeyState("Alt") = 0 
            Send "^{Left}" 
        else 
        ; ^! 左跳选一词
            Send "+^{Left}" 
        return 
    } 
} 


CapsLock & j:: 
{
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("Alt") = 0 
            Send "{Down}" 
        else 
            Send "+{Down}" 
        return 
    } 
    else { 
        if GetKeyState("Alt") = 0 
            Send "^{Down}" 
        else 
            Send "+^{Down}" 
        return 
    } 
} 

CapsLock & k:: 
{
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("Alt") = 0 
            Send "{Up}" 
        else 
            Send "+{Up}" 
        return 
    } 
    else { 
        if GetKeyState("Alt") = 0 
            Send "^{Up}" 
        else 
            Send "+^{Up}" 
        return 
    } 
} 

CapsLock & l:: 
{
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("Alt") = 0 
            Send "{Right}" 
        else 
            Send "+{Right}" 
        return 
    } 
    else { 
        if GetKeyState("Alt") = 0 
            Send "^{Right}" 
        else 
            Send "+^{Right}" 
        return 
    } 
} 


;=====================================================================o
;                     CapsLock Home/End Navigator                    
;-----------------------------------o---------------------------------o
;                      CapsLock + i |  Home                          
;                      CapsLock + o |  End                           
;                      Ctrl, Alt Compatible                          
;-----------------------------------o---------------------------------o
CapsLock & i:: 
{
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("Alt") = 0 
            Send "{Home}" 
        else 
            Send "+{Home}" 
        return 
    } 
    else { 
        if GetKeyState("Alt") = 0 
            Send "^{Home}" 
        else 
            Send "+^{Home}" 
        return 
    } 
} 

CapsLock & o:: 
{
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("Alt") = 0 
            Send "{End}" 
        else 
            Send "+{End}" 
        return 
    } 
    else { 
        if GetKeyState("Alt") = 0 
            Send "^{End}" 
        else 
            Send "+^{End}" 
        return 
    } 
} 


;=====================================================================o
;                      CapsLock Page Navigator                       
;-----------------------------------o---------------------------------o
;                      CapsLock + u |  PageUp                        
;                      CapsLock + p |  PageDown                      
;                      Ctrl, Alt Compatible                          
;-----------------------------------o---------------------------------o
CapsLock & u:: 
{
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("Alt") = 0 
            Send "{PgUp}" 
        else 
            Send "+{PgUp}" 
        return 
    } 
    else { 
        if GetKeyState("Alt") = 0 
            Send "^{PgUp}" 
        else 
            Send "+^{PgUp}" 
        return 
    } 
} 

CapsLock & p:: 
{
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("Alt") = 0 
            Send "{PgDn}" 
        else 
            Send "+{PgDn}" 
        return 
    } 
    else { 
        if GetKeyState("Alt") = 0 
            Send "^{PgDn}" 
        else 
            Send "+^{PgDn}" 
        return 
    } 
} 
