;=====================================================================o                       Common Settings                         
;                                                              
; 
;  ▄████▄   ▄▄▄       ██▓███    ██████  ██▓     ▒█████   ▄████▄   ██ ▄█▀
; ▒██▀ ▀█  ▒████▄    ▓██░  ██▒▒██    ▒ ▓██▒    ▒██▒  ██▒▒██▀ ▀█   ██▄█▒ 
; ▒▓█    ▄ ▒██  ▀█▄  ▓██░ ██▓▒░ ▓██▄   ▒██░    ▒██░  ██▒▒▓█    ▄ ▓███▄░ 
; ▒▓▓▄ ▄██▒░██▄▄▄▄██ ▒██▄█▓▒ ▒  ▒   ██▒▒██░    ▒██   ██░▒▓▓▄ ▄██▒▓██ █▄ 
; ▒ ▓███▀ ░ ▓█   ▓██▒▒██▒ ░  ░▒██████▒▒░██████▒░ ████▓▒░▒ ▓███▀ ░▒██▒ █▄
; ░ ░▒ ▒  ░ ▒▒   ▓▒█░▒▓▒░ ░  ░▒ ▒▓▒ ▒ ░░ ▒░▓  ░░ ▒░▒░▒░ ░ ░▒ ▒  ░▒ ▒▒ ▓▒
;   ░  ▒     ▒   ▒▒ ░░▒ ░     ░ ░▒  ░ ░░ ░ ▒  ░  ░ ▒ ▒░   ░  ▒   ░ ░▒ ▒░
; ░          ░   ▒   ░░       ░  ░  ░    ░ ░   ░ ░ ░ ▒  ░        ░ ░░ ░ 
; ░ ░            ░  ░               ░      ░  ░    ░ ░  ░ ░      ░  ░   
; ░                                                     ░               
; 
;                                                AutoHotkey V1.1.33.10
;---------------------------------------------------------------------o 
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.  
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance, force 

;=====================================================================o
;                       CapsLock Icon
;---------------------------------------------------------------------o
Menu, Tray, Tip, CapsLock+
Menu, Tray, Icon,,,1
Menu, Tray, Icon, %A_WorkingDir%\plugins\capslock_run.ico,1,0
; Menu, Tray, Icon, %A_WorkingDir%\plugins\capslock_pause.ico,,1 
;---------------------------------------------------------------------o

;=====================================================================o
;                       CapsLock Initializer                         
;---------------------------------------------------------------------o
SetCapsLockState, AlwaysOff 
;---------------------------------------------------------------------o

;=====================================================================o
;                       CapsLock Switcher:                           
;---------------------------------o-----------------------------------o
;                    CapsLock + ` | {CapsLock}                       
;---------------------------------o-----------------------------------o
CapsLock & `:: 
    GetKeyState, CapsLockState, CapsLock, T 
    if CapsLockState = D 
    {
        SetCapsLockState, AlwaysOff
        ToolTip, a
    }
    else
    {
        SetCapsLockState, AlwaysOn 
        ToolTip, A
    }
    KeyWait, ``,,t0.2 
    sleep, 250
    ToolTip
return 
;---------------------------------------------------------------------o
; fix bug: CapsLock + Shift -> SetCapsLockState, alwaysOn
+CapsLock::
CapsLock & Shift::
return
;---------------------------------------------------------------------o

;=====================================================================o
;                         CapsLock Escaper:                          
;----------------------------------o----------------------------------o
;                        CapsLock  |  {ESC}                          
;----------------------------------o----------------------------------o
CapsLock:: Send, {ESC} 
;---------------------------------------------------------------------o

;=====================================================================o
;                       CapsLock  Shift Switch                                     
;-----------------------------------o---------------------------------o
;      键\修饰      	✱	         ⌘(Alt)	          ⌥(Ctrl)
;        -             _            页面缩小	
;        =             +            页面放大	
;        [             (            	{	             <
;        ]             )            	}	             >
;        ;             !            	:	
;        '             =            	=	
;        /             ⌘ /		
;        \             ⌘/		
;
;     编程模式：统一编程体验，中文字符推荐用 shift + 带出 
;             _:!{}()    英文      
;             +=         中/英文
;             ?          未收录
;-----------------------------------o---------------------------------o
CapsLock & -:: 
    ; if GetKeyState("alt") = 0 
        send, {text}_ 
    ; else 
        ; send, {Esc} 
return 
CapsLock & =:: 
    ; if GetKeyState("alt") = 0 
        send, {+} 
    ; else 
        ; send, {Esc} 
return 
;-----------------------------------o---------------------------------o
CapsLock & `;::                                                       
if GetKeyState("alt") = 0 
    send, {text}: 
else 
    send, {text}!  
return 
;---------------------------------------------------------------------o
CapsLock & ':: 
    if GetKeyState("alt") = 0 
        send, {=} 
    else 
        send, {=} 
return 
;---------------------------------------------------------------------o
CapsLock & [:: 
    if GetKeyState("control") = 1 
        Send, {<} 
    else if GetKeyState("alt") = 1 
        send, {text}{ 
    else 
        send, {text}(
return 
;---------------------------------------------------------------------o
CapsLock & ]:: 
    if GetKeyState("control") = 1 
        Send, {>} 
    else if GetKeyState("alt") = 1 
        send, {text}} 
    else 
        send, {text})
return 
;---------------------------------------------------------------------o

;=====================================================================o
;                       CapsLock Media Controller                    
;-----------------------------------o---------------------------------o
;                    CapsLock + F1  |  Volume_Mute                   
;                    CapsLock + F2  |  Volume_Down                   
;                    CapsLock + F3  |  Volume_Up                     
;                    CapsLock + F3  |  Media_Play_Pause              
;                    CapsLock + F5  |  Media_Next                    
;                    CapsLock + F6  |  Media_Stop                    
;-----------------------------------o---------------------------------o
CapsLock & F10:: Send, {Volume_Mute} 
CapsLock & F11:: Send, {Volume_Down} 
CapsLock & F12:: Send, {Volume_Up} 
CapsLock & F8:: Send, {Media_Play_Pause} 
;CapsLock & F5:: Send, {Media_Next}                                   
;CapsLock & F6:: Send, {Media_Stop}                                   
;---------------------------------------------------------------------o

;=====================================================================o
;                    CapsLock Direction Navigator                    
;-----------------------------------o---------------------------------o
;                      CapsLock + h |  Left                          
;                      CapsLock + j |  Down                          
;                      CapsLock + k |  Up                            
;                      CapsLock + l |  Right                         
;                      CapsLock + l |  Right                         
;                      Ctrl, Alt Compatible                          
;-----------------------------------o---------------------------------o
CapsLock & h:: 
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("alt") = 0 
            Send, {Left} 
        else 
            Send, +{Left} 
        return 
    } 
    else { 
        if GetKeyState("alt") = 0 
            Send, ^{Left} 
        else 
            Send, +^{Left} 
        return 
    } 
return 
;---------------------------------------------------------------------o
CapsLock & j:: 
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("alt") = 0 
            Send, {Down} 
        else 
            Send, +{Down} 
        return 
    } 
    else { 
        if GetKeyState("alt") = 0 
            Send, ^{Down} 
        else 
            Send, +^{Down} 
        return 
    } 
return 
;---------------------------------------------------------------------o
CapsLock & k:: 
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("alt") = 0 
            Send, {Up} 
        else 
            Send, +{Up} 
        return 
    } 
    else { 
        if GetKeyState("alt") = 0 
            Send, ^{Up} 
        else 
            Send, +^{Up} 
        return 
    } 
return 
;---------------------------------------------------------------------o
CapsLock & l:: 
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("alt") = 0 
            Send, {Right} 
        else 
            Send, +{Right} 
        return 
    } 
    else { 
        if GetKeyState("alt") = 0 
            Send, ^{Right} 
        else 
            Send, +^{Right} 
        return 
    } 
return 
;---------------------------------------------------------------------o

;=====================================================================o
;                     CapsLock Home/End Navigator                    
;-----------------------------------o---------------------------------o
;                      CapsLock + i |  Home                          
;                      CapsLock + o |  End                           
;                      Ctrl, Alt Compatible                          
;-----------------------------------o---------------------------------o
CapsLock & i:: 
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("alt") = 0 
            Send, {Home} 
        else 
            Send, +{Home} 
        return 
    } 
    else { 
        if GetKeyState("alt") = 0 
            Send, ^{Home} 
        else 
            Send, +^{Home} 
        return 
    } 
return 
;---------------------------------------------------------------------o
CapsLock & o:: 
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("alt") = 0 
            Send, {End} 
        else 
            Send, +{End} 
        return 
    } 
    else { 
        if GetKeyState("alt") = 0 
            Send, ^{End} 
        else 
            Send, +^{End} 
        return 
    } 
return 
;---------------------------------------------------------------------o

;=====================================================================o
;                      CapsLock Page Navigator                       
;-----------------------------------o---------------------------------o
;                      CapsLock + u |  PageUp                        
;                      CapsLock + p |  PageDown                      
;                      Ctrl, Alt Compatible                          
;-----------------------------------o---------------------------------o
CapsLock & u:: 
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("alt") = 0 
            Send, {PgUp} 
        else 
            Send, +{PgUp} 
        return 
    } 
    else { 
        if GetKeyState("alt") = 0 
            Send, ^{PgUp} 
        else 
            Send, +^{PgUp} 
        return 
    } 
return 
;---------------------------------------------------------------------o
CapsLock & p:: 
    if GetKeyState("control") = 0 
    { 
        if GetKeyState("alt") = 0 
            Send, {PgDn} 
        else 
            Send, +{PgDn} 
        return 
    } 
    else { 
        if GetKeyState("alt") = 0 
            Send, ^{PgDn} 
        else 
            Send, +^{PgDn} 
        return 
    } 
return 
;---------------------------------------------------------------------o

;=====================================================================o
;                           CapsLock Deletor                         
;---------------------------------------------------------------------o
;   键\修饰	        ✱	         ⌘	           ⌥
;   N	        前删一词	   删至行首        	整行删除
;   M	        前删一字	   前删一词        	将行下移
;   ,	        后删一字	   后删一词        	将行上移
;   .	        后删一词	   删至行尾        	整行删除
;   ⌫	        删除文件	   永久删除         文件	
;
;---------------------------------------------------------------------o
CapsLock & ,:: Send, {Del} 
CapsLock & m:: Send, {BS} 
CapsLock & .:: 
    if GetKeyState("alt") = 0
        Send, ^{Del} 
    else 
        SendInput, +{End}{Del} 
return
;---------------------------------------------------------------------o
CapsLock & n:: 
    if GetKeyState("alt") = 0
        Send, ^{BS} 
    else 
        SendInput, +{Home}{BS} 
return
;---------------------------------------------------------------------o

;=====================================================================o
;                      CapsLock Window Controller                    
;-----------------------------------o---------------------------------o
;                     CapsLock + s  |  Ctrl + Tab (Swith Tag)        
;                     CapsLock + q  |  Ctrl + W   (Close Tag)        
;   (Disabled)  Alt + CapsLock + s  |  AltTab     (Switch Windows)   
;               Alt + CapsLock + q  |  Ctrl + Tab (Close Windows)    
;                     CapsLock + \  |  AppsKey    (Menu Key)         
;-----------------------------------o---------------------------------o
;CapsLock & s::Send, ^{Tab}                                           
CapsLock & s:: 
    if GetKeyState("alt") = 0 
        Send, ^{Tab}
    else
        Send, ^+{F4} 
return 
;---------------------------------------------------------------------o
CapsLock & q:: 
    if GetKeyState("alt") = 0 
        Send, ^{F4} 
    else 
        Send, !{F4} 
return 
;---------------------------------------------------------------------o
CapsLock & \:: Send, {AppsKey}
;---------------------------------------------------------------------o


;=====================================================================o
;                    Start Computer                                                             
;---------------------------------------------------------------------o
; quick start learning cource
CapsLock & 0::
    ; auto resize windows flex
    if GetKeyState("ctrl") = 1 
    {
        turn2ProjectWinMode()
    }
    else if GetKeyState("LWin") = 1 
    {
        turn2ReadWinMode()
        WinActivate, ahk_exe notion.exe
        send, ^+n
        sleep, 3000
        zoomWin("|")
    }
return
;---------------------------------------------------------------------o

;=====================================================================o
;                           Application                          
;---------------------------------------------------------------------o
; close Tab
CapsLock & w:: send, ^w
;---------------------------------------------------------------------o
CapsLock & a:: 
    if GetKeyState("alt") = 0
    {
        zoomWinManager()
    } else {
        moveWinManager()
    }
return
;---------------------------------------------------------------------o
CapsLock & d:: 
    if GetKeyState("alt") = 1 
    {
        activateOrRun("ahk_exe Postman.exe", "C:\Users\miozus\AppData\Local\Postman\Postman.exe")
    } 
    else if GetKeyState("ctrl") = 1
    {
        activateOrRun("ahk_exe DevDocs.exe", "C:\Users\miozus\AppData\Local\Programs\DevDocs\DevDocs.exe")
    }
    else
    {
        activateOrRun("ahk_exe navicat.exe", "E:\Navicat 15 for MySQL\navicat.exe")
    }
return
;---------------------------------------------------------------------o
CapsLock & f:: 
    if GetKeyState("alt") = 0
    {
        ; switchero - no sudo
        send, ^!+f
        setIME("EN")
    } 
    else
    {
        ; Everything
        send, ^#!f
        setIME("EN")
    }
return
;---------------------------------------------------------------------o
CapsLock & g:: 
    if GetKeyState("alt") = 1
    {
        ; 谷歌搜索选中文字
        Send, ^c
        ClipWait, 2
        Run, https://www.google.com/search?q=%clipboard%
        Return
    }
    else if GetKeyState("ctrl") = 1
    {
        ; 谷歌翻译查单词
        Send, ^c
        ClipWait, 2
        Run,https://translate.google.cn/?sl=auto&tl=zh-CN&text=%clipboard%&op=translate
        Return
    }
    else
    {
        activateOrRun("ahk_exe chrome.exe", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
    }
return
;----------------------------------o----------------------------------o
CapsLock & v:: 
    if GetKeyState("ctrl") == 0 
    {
        activateOrRun("ahk_exe Code.exe", "D:\TOOLS\Microsoft VS Code\Code.exe")
    } else {
        openByAppKey(7) ; vscode index 7 after rightClick, conflct with Alt
    }
return
;----------------------------------o----------------------------------o
CapsLock & e:: 
    if GetKeyState("ctrl") == 1
    {
        pasteInNotepad()
    } else {
        activateOrRun("ahk_exe Notion.exe", "C:\Users\miozus\AppData\Local\Programs\Notion\Notion.exe", "中文")
    }
return
;----------------------------------o----------------------------------o
CapsLock & r:: 
    if GetKeyState("alt") = 1 
    {
        if winExist("ahk_exe javaw.exe")
            WinActivate
        ; Else
        ;     ; visualvm_21
        ;     send, {text}E:\Java\visualvm_21\bin\visualvm --jdkhome "C:\Users\miozus\.jdks\adopt-openjdk-14.0.2"
        ;     send, {Enter}
    }
    if GetKeyState("ctrl") = 1 
    {
        ; arthas
        send, {text}C:\Users\miozus\.jdks\adopt-openjdk-14.0.2\bin\java -jar E:\Java\arthas-packaging-3.5.3-bin\arthas-boot.jar
        send, {Enter}
    } else {
        activateOrRun("ahk_exe idea64.exe", "E:\JetBrains\Toolbox\apps\IDEA-U\ch-0\212.5080.55\bin\idea64.exe")
    }
return
;---------------------------------------------------------------------o
CapsLock & t:: 
    if GetKeyState("alt") = 0 
    {
        activateOrRun("ahk_exe powershell.exe", "C:\Users\miozus\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk")
    } 
    else
    {
        activateOrRun("ahk_exe mintty.exe", "E:\Git\git-bash.exe --cd-to-home")
    }
return
;---------------------------------------------------------------------o
CapsLock & y:: 
    if GetKeyState("alt")  = 1
    {
        ; Edit this AHK
        Run,  "D:\TOOLS\Microsoft VS Code\Code.exe" "D:\TOOLS\AutoHotKey\CapslockPlus\CapslockPlus.ahk"
    }
    else if GetKeyState("ctrl") = 1
    {
        ; search for help
        Run, "https://wyagd001.github.io/zh-cn/docs/AutoHotkey.htm"
    }
    else if GetKeyState("LWin") = 1
    {
        activateOrRun("plugins ahk_exe Explorer.EXE", "D:\TOOLS\AutoHotKey\CapslockPlus\plugins")
    }
    Else
    {
        if winExist("ahk_class AutoHotkey")
            WinActivate
        Else
        {
            ; 设计悬浮动画，再重载本脚本，因为重载太快，后面很难放出来
            ToolTip,❤
            sleep, 500
            ToolTip
            Reload
        }
    }
return
;---------------------------------------------------------------------o
; 激活或运行, 默认初始英文输入法（省略不填参数；如需中文，再加逗号和“中文”，要包含双引号）
activateOrRun(title, exe_path, language:="EN"){
    if WinExist(title) {
        WinActivate
    }
    Else {
        Run, % exe_path 
    }
    setIME(language) ; 默认以小写开始，避免脚本突然的大写
}
;---------------------------------------------------------------------o

;=====================================================================o
;                       CapsLock Plugins
;---------------------------------------------------------------------o
#Include, %A_WorkingDir%\plugins\InputMethodEditor.ahk
#Include, %A_WorkingDir%\plugins\UserDictionary.ahk
#Include, %A_WorkingDir%\plugins\Notion.ahk
#Include, %A_WorkingDir%\plugins\MouseEnhance.ahk
#Include, %A_WorkingDir%\plugins\MoomWinManager.ahk
#Include, %A_WorkingDir%\plugins\GarbageCollector.ahk
;---------------------------------------------------------------------o

;=====================================================================o
;                    Vscode Macro
;---------------------------------------------------------------------o
trimTitleNumber() {
    ; vim focus last cursor, use regex to replace
    WinActivate, ahk_exe Code.exe
    sleep, 100
    send, {text}mr
    sleep, 100
    send, ^r
    send, !r  ; activate regex
    sleep, 100
    send, {text}^(\d.?[. ]?)+
    send, {Tab}
    send, {Lshift down}{Home}{Lshift up}{Del}
    sleep, 100
    send, ^!{Enter}
    send, {Esc}
    sleep, 200
    send, {text}'r
}
;---------------------------------------------------------------------o

;=====================================================================o
;                    idea Macro 
;---------------------------------------------------------------------o
eidtVmOptions(){
    send, !+e
    sleep, 200
    send, !v
    sleep, 50
    send, +{Enter}
}
;---------------------------------------------------------------------o
; Rebrel Update sources and return Service Blank
#IfWinActive ahk_exe idea64.exe
~^F9::
    send, ^{F9}
    sleep, 1000
    send, !8
return
#If
;---------------------------------------------------------------------o

;=====================================================================o
;                    Utils Macro
;---------------------------------------------------------------------o
; 单击鼠标右键，以第 N 个方式打开该文件
openByAppKey(sort:=0){
    send, {AppsKey}
    send, {down %sort%}
    ToolTip, % sort--
    send, {Enter}
}
;---------------------------------------------------------------------o
; 简单的后台登陆操作，输入验证码时，输入法设为英文
loginAdmin(){
    send, {text}admin
    send, {Tab}
    send, {text}admin
    send, {Tab}
    if hasIME() == 1
    {
        send, ^{Space}
    }
}
;---------------------------------------------------------------------o
; 复制文字用记事本查看
pasteInNotepad() {
    Send ^c
    IfWinExist ahk_class Notepad
    {
        WinActivate
    }
    else
    {
        Run Notepad
        WinWait ahk_class Notepad
        WinActivate
    }
    Send ^a^v   
    return
}
;---------------------------------------------------------------------o
copySelectWord() {
    sendEvent, ^{left}^+{right} 
    send, ^c
}
;---------------------------------------------------------------------o
getSelectString() {
    send, ^c
    return %clipboard%
}
;---------------------------------------------------------------------o

;=====================================================================o
;                    Comprehensive HotKey
;   键\修饰	       ✱	                    ⌘	                   ⌃
;     5	     runCurrentTest          autoCommentJavadoc  pasteToggleByVscode 
;---------------------------------------------------------------------o
CapsLock & 5::
    if GetKeyState("alt") = 1
    {
        autoCommentJavadoc()
    }
    ; Notion Editor Content API
    else if GetKeyState("ctrl") == 1
    {
        trimTitleNumber()
        pasteToggleByVscode(0)
    } else {
        ; Test java code after jrebel update
        send, ^{Tab}
        sleep, 3000
        send, ^!r
    }
return
;---------------------------------------------------------------------o
CapsLock & 6:: loginAdmin()
;---------------------------------------------------------------------o
CapsLock & 7:: 
    if GetKeyState("alt") = 1
    {
        eidtVmOptions()
        send, ^a^v
    }
    else
        eidtVmOptions()
return
;---------------------------------------------------------------------o