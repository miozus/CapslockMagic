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
Menu, Tray, Tip, CapsLock+
Menu, Tray, Icon,,,1
Menu, Tray, Icon, %A_WorkingDir%\config\capslock_run.ico,1,0
; Menu, Tray, Icon, %A_WorkingDir%\config\capslock\capslock_pause.ico,,1 

; Pause::Pause  ; The Pause/Break key.
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
        SetCapsLockState, AlwaysOff 
    else 
        SetCapsLockState, AlwaysOn 
    KeyWait, `` 
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
        SendInput, {text}_ 
    ; else 
        ; SendInput, {Esc} 
return 
CapsLock & =:: 
    ; if GetKeyState("alt") = 0 
        SendInput, {+} 
    ; else 
        ; SendInput, {Esc} 
return 
;-----------------------------------o---------------------------------o
CapsLock & `;::                                                       
if GetKeyState("alt") = 0 
    SendInput, {text}: 
else 
    SendInput, {text}!  
return 
;---------------------------------------------------------------------o
CapsLock & ':: 
    if GetKeyState("alt") = 0 
        SendInput, {=} 
    else 
        SendInput, {=} 
return 
;---------------------------------------------------------------------o
CapsLock & [:: 
    if GetKeyState("control") = 1 
        Send, {<} 
    else if GetKeyState("alt") = 1 
        SendInput, {text}{ 
    else 
        ; Send, {(} 
        SendInput, {text}(
return 
;---------------------------------------------------------------------o
CapsLock & ]:: 
    if GetKeyState("control") = 1 
        Send, {>} 
    else if GetKeyState("alt") = 1 
        SendInput, {text}} 
    else 
        ; Send, {)} 
        SendInput, {text})
return 
;---------------------------------------------------------------------o

;=====================================================================o
;                       CapsLock Media Controller                    
;-----------------------------------o---------------------------------o
; '                  CapsLock + F1  |  Volume_Mute                   
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
;-----------------------------------o                                
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
;-----------------------------------o                                
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
;-----------------------------------o                                
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
;-----------------------------------o                                
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
;-----------------------------------o                                
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
;-----------------------------------o---------------------------------o
;   CapsLock + n        |  Ctrl + Delete (Delete a Word) 
;   CapsLock + n  + Alt |  Shift + Home + Delete (Delete till Home) 
;   CapsLock + m        |  Delete                        
;   CapsLock + ,        |  BackSpace                     
;   CapsLock + .        |  Ctrl + BackSpace              
;   CapsLock + .  + Alt |  Shift + End + Delete (Delete till end) 
;
;   键\修饰	        ✱	         ⌘	           ⌥
;   N	        前删一词	   删至行首        	整行删除
;   M	        前删一字	   前删一词        	将行下移
;   ,	        后删一字	   后删一词        	将行上移
;   .	        后删一词	   删至行尾        	整行删除
;   ⌫	        删除文件	   永久删除         文件	
;-----------------------------------o---------------------------------o
CapsLock & ,:: Send, {Del} 
CapsLock & m:: Send, {BS} 
CapsLock & .:: 
    if GetKeyState("alt") = 0
        Send, ^{Del} 
    else 
        send, +{End}{Del}
return
;-----------------------------------o                                
CapsLock & n:: 
    if GetKeyState("alt") = 0
        Send, ^{BS} 
    else 
        Send, +{Home}{BS}
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
;-----------------------------------o                                
CapsLock & q:: 
    if GetKeyState("alt") = 0 
        Send, ^{F4} 
    else 
        Send, !{F4} 
return 
;-----------------------------------o                                
CapsLock & \:: Send, {AppsKey}
;---------------------------------------------------------------------o

;=====================================================================o
;                     CapsLock Mouse Controller                      
;-----------------------------------o---------------------------------o
;                   CapsLock + Up   |  Mouse Up                      
;                   CapsLock + Down |  Mouse Down                    
;                   CapsLock + Left |  Mouse Left                    
;                  CapsLock + Right |  Mouse Right                   
;    CapsLock + Enter(Push Release) |  Mouse Left Push(Release)      
;-----------------------------------o---------------------------------o
;                  CapsLock & Up    | MouseMove, 0, -30, 0, R 
;                  CapsLock & Down  | MouseMove, 0, 30, 0, R 
;                  CapsLock & Left  | MouseMove, -30, 0, 0, R 
;                  CapsLock & Right | MouseMove, 30, 0, 0, R 
;-----------------------------------o---------------------------------o
CapsLock & Up:: 
    if GetKeyState("Shift") = 0 
        MouseMove, 0, -30, 0, R 
    else 
        MouseMove, 0, -10, 0, R 
return 
;-----------------------------------o                                
CapsLock & Down:: 
    if GetKeyState("Shift") = 0 
        MouseMove, 0, 30, 0, R 
    else 
        MouseMove, 0, 10, 0, R 
return 
;-----------------------------------o                                
CapsLock & Left:: 
    if GetKeyState("Shift") = 0 
        MouseMove, -30, 0, 0, R 
    else 
        MouseMove, -10, 0, 0, R 
return 
;-----------------------------------o                                
CapsLock & Right:: 
    if GetKeyState("Shift") = 0 
        MouseMove, 30, 0, 0, R 
    else 
        MouseMove, 10, 0, 0, R 
return 
;-----------------------------------o                                
CapsLock & Enter:: 
    SendEvent {Blind}{LButton down} 
    KeyWait Enter 
    SendEvent {Blind}{LButton up} 
return 
;-------------------------------------------------------------------o

;===================================================================o
;                    Start Computer                                                             
;-------------------------------------------------------------------o

; quick start learning cource
CapsLock & 0::
    ; auto resize windows flex
    if GetKeyState("ctrl") = 1 
    {
        Winmove, ahk_exe chrome.exe,,965,0,1660,1160 ; chrome, ↗ 2/3
        Winmove, ahk_exe idea64.exe,,-7,0,1734,1447  ; IDEA,   ← 2/3
        Winmove, ahk_exe Notion.exe,,1718,0,842,1440 ; Notion, → 1/3
        Winmove, ahk_exe Code.exe  ,,0,0,973,1440    ; vscode, ← 1/3
    }
return

#If, INACTIVE_PLUGIN_VM
; check out vagrant , show docker service
CapsLock & 5::
    if GetKeyState("alt") = 1
    {
        SendInput, cd E:\Oracle\HashiCorp\CentOS{Enter}
        SendInput, vagrant ssh{Enter}
        Sleep, 10 * 1000
        SendInput, su{Enter}
        Sleep, 100
        SendInput, vagrant{Enter}
        SendInput, sudo docker ps -a{Enter}
    }
    ; posh:  vagrant up 
    else if GetKeyState("ctrl") = 1 
    {
        Run, "C:\Users\miozus\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk"
        sleep 1600
        SendInput, cd E:\Oracle\HashiCorp\CentOS{Enter}
        SendInput, vagrant up{Enter}
    }   
return
#If


;=====================================================================o
;                    Typing                                                             
;-------------------------------------------------------------------o
; for QQ pinyin return EN origin mark symbol, suit for Notion
CapsLock & Space:: Send, ^`` 

; programer habit input symbol
`:: sendInput, {text}``
/:: sendInput, {text}/
>:: sendInput, {text}>
<:: sendInput, {text}<  ; 某天发现自己很少引用作品名
;-------------------------------------------------------------------o
; 用户词典(小鹤双拼/应用首字母)
; 无视输入法状态，敲空格键(语句+空格）或回车键(=语句+空格+回车），显示结果
::lhq::localhost:7000
::lhb::localhost:8000
::lhj::localhost:9000
::lhu::localhost:10000
::lhuy::localhost:11000
::guli::谷粒
::ay::application.yml
::ap::application.properties
::px::pom.xml
::sc::SpringCould
::sb::SpringBoot
; 终端命令快捷键
; docker
::dpa::docker ps -a
; linux
; powershell
::tkp::taskkill /PID 8 /F
::lsp::netstat -ano | findstr :8
;aliyun
;-------------------------------------------------------------------o

;=====================================================================o
;                    Mouse                                                             
;-------------------------------------------------------------------o
;  
; CapsLock & 1::
;     MouseClick, Left, 340, 680, 1
;     MouseClick, Left, 1080, 730, 1
; return
;-------------------------------------------------------------------o
; @Test
activatePlugin(boolean){
    INACTIVE_PLUGIN_NOTION := boolean
    ToolTip, % INACTIVE_PLUGIN_NOTION
}

CapsLock & 8::
    MsgBox, % INACTIVE_PLUGIN_NOTION
return













;===================================================================o
;                    
;   
;    ██████╗ ██████╗ ███╗   ██╗████████╗██████╗  ██████╗ ██╗     
;   ██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗██╔═══██╗██║     
;   ██║     ██║   ██║██╔██╗ ██║   ██║   ██████╔╝██║   ██║██║     
;   ██║     ██║   ██║██║╚██╗██║   ██║   ██╔══██╗██║   ██║██║     
;   ╚██████╗╚██████╔╝██║ ╚████║   ██║   ██║  ██║╚██████╔╝███████╗
;    ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝
;                                                                
;   
;-------------------------------------------------------------------o
; 脚本功能太多，丧失储存变量功能(#IF失效) ，只有调用修改时才生效，不调用，默认无效; 
; 需要手动#定位变量，利用注释进行开关:
; #If 1    表示开启插件功能
; #If xxx  表示关闭插件功能
global INDENT_LEVEL := 0
global INACTIVE_PLUGIN_NOTION := true
; global INACTIVE_PLUGIN_GAME_DEVELOP := true
; global INACTIVE_PLUGIN_VM := true
#Include, %A_WorkingDir%\config\setting.ahk

;=====================================================================o
;                         CapsLock  Application:                          
;----------------------------------o----------------------------------o
;                        CapsLock  space |  Ctrl + `                         
;----------------------------------o----------------------------------o
; close Tab
CapsLock & w:: send, ^w
; PowerToy - winodows gird
CapsLock & a:: send, ^#!h
; switchero - no sudo
CapsLock & f:: 
    if GetKeyState("alt") = 0
    {
        send, ^!+f
    } 
    else
    {
        activateOrRun("ahk_exe Everything.exe", "‪C:\Program Files\Everything\Everything.exe")
    }
return
;----------------------------------o----------------------------------o
CapsLock & g:: 
    if GetKeyState("alt") = 1
    {
        ; 谷歌搜索选中文字
        Send, ^c
        Sleep 50
        Run, https://www.google.com/search?q=%clipboard%
        Return
    }
    else if GetKeyState("ctrl") = 1
    {
        ; Maven Repository 搜索选中文字
        Send, ^c
        Sleep 50
        Run, https://mvnrepository.com/search?q=%clipboard%
        Sleep 100
        Send, {Esc}
        Return
    }
    else
    {
        activateOrRun("ahk_exe chrome.exe", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
    }
return
;----------------------------------o----------------------------------o
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
;----------------------------------o----------------------------------o
CapsLock & v:: 
    activateOrRun("ahk_exe Code.exe", "D:\TOOLS\Microsoft VS Code\Code.exe")
return
;----------------------------------o----------------------------------o
CapsLock & e:: 
    activateOrRun("ahk_exe Notion.exe", "C:\Users\miozus\AppData\Local\Programs\Notion\Notion.exe")
return
;----------------------------------o----------------------------------o
CapsLock & y:: 
    if GetKeyState("alt")  = 1
    {
        ; Edit
        Run,  "D:\TOOLS\Microsoft VS Code\Code.exe" "D:\TOOLS\AutoHotKey\Capslock-Win10.ahk"
    }
    else if GetKeyState("ctrl") = 1
    {
        ; look for help
        Run, "https://wyagd001.github.io/zh-cn/docs/AutoHotkey.html"
        send, !s
    }
    Else
    {
        if winExist("ahk_class AutoHotkey")
            WinActivate
        Else
            Reload
            ; TrayTip, CapsLock+, 脚本已重启
        return
    }
return

;---------------------------------------------------------------------o
CapsLock & r:: 
    if GetKeyState("alt") = 1 
    {
        if winExist("ahk_exe javaw.exe")
            WinActivate
        ; Else
        ;     ; visualvm_21
        ;     sendInput, {text}E:\Java\visualvm_21\bin\visualvm --jdkhome "C:\Users\miozus\.jdks\adopt-openjdk-14.0.2"
        ;     send, {Enter}
    }
    if GetKeyState("ctrl") = 1 
    {
        ; arthas
        sendInput, {text}C:\Users\miozus\.jdks\adopt-openjdk-14.0.2\bin\java -jar E:\Java\arthas-packaging-3.5.3-bin\arthas-boot.jar
        send, {Enter}
    } else {
        activateOrRun("ahk_exe idea64.exe", "E:\JetBrains\Toolbox\apps\IDEA-U\ch-0\212.4746.92\bin\idea64.exe")
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
; Utils
activateOrRun(title, exe_path){
    if WinExist(title)
        WinActivate
    Else
        Run, % exe_path 
    return
}
;---------------------------------------------------------------------o



; #If, 1                          ; 开启
#If, INACTIVE_PLUGIN_GAME_DEVELOP ; 关闭
;=====================================================================o
;                    Game Develop
;-----------------------------------o---------------------------------o
; 
; 功能： 游戏开发者模式, 热键
; 作者：查理
; 时间：2021年8月26日
;
CapsLock & r:: 
    if GetKeyState("alt") = 0 
    {
        activateOrRun("ahk_exe idea64.exe", "E:\JetBrains\Toolbox\apps\IDEA-U\ch-0\212.4746.92\bin\idea64.exe")
    } 
    else
    {
        activateOrRun("ahk_exe Unity.exe", "D:\TOOLS\Unity Hub\Unity Hub.exe")
    }
return
;----------------------------------o----------------------------------o
CapsLock & b:: 
    if WinExist("ahk_exe devenv.exe")
    {
        WinActivate
        ; swtich into edit  mode, instead of windows no nothing
        Send, !1
        Send, {ESC}
    }
    Else 
        Run, "E:\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe"
return
;---------------------------------------------------------------------o
#If


; #If, 1                          ; 开启
#If, INACTIVE_PLUGIN_NOTION       ; 关闭
;=====================================================================o
;                    Notion                                                             
;-------------------------------------------------------------------o
; 功能： 1.粘贴代码，或并选择对应的高亮语言，或追加相对路径作补充说明；
;       2.粘贴折叠块，制作网址收藏，或粘贴报错信息
; 作者：查理
; 时间：2021年8月26日
; 
;   键\修饰	       ✱	                    ⌘	                   ⌃
;     F1	     Java	                 JavaScript              JSON	
;     F2	     XML	                 YAML         
;     F3	     HTML	                 Bash         
;     1	     pasteCodeByIndentLevel  pasteRelativePathByLastIde
;     2	     refBookmark	   
;     3	     pasteRedError	   
;     4	     increLevel              decreLevel         
;     5	     runCurrentTest          autoCommentJavadoc  pasteToggleLineByVscode 
;-------------------------------------------------------------------o
; Paste with code languge style
CapsLock & F1::
    if GetKeyState("alt") == 1
    {
        pasteCodeAs("JavaScript")
    } 
    else if GetKeyState("ctrl") = 1
    {
        pasteCodeAs("JSON")
    } 
    else 
    {
        pasteCodeAs("Java")
    }
return
;-------------------------------------------------------------------o
CapsLock & F2::
    if GetKeyState("alt") == 0
    {
        pasteCodeAs("XML")
    } else {
        pasteCodeAs("YAML")
    }
return
;-------------------------------------------------------------------o
CapsLock & F3::
    if GetKeyState("alt") == 0
    {
        pasteCodeAs("HTML")
    } else {
        pasteCodeAs("Bash")
    }
return
;-------------------------------------------------------------------o
; Code Paste+tab*0
CapsLock & 1::
    if GetKeyState("alt") == 0
    {
        pasteCodeByIndentLevel()
    } else {
        pasteRelativePathByLastIde()
    }
return
;-------------------------------------------------------------------o
; Ref Bookmark
CapsLock & 2::
    send, ^+7
    sendInput, {Text}reference
    send, {Enter}
    send, ^v
    send, {Down}
    send, {Enter}
return
;-------------------------------------------------------------------o
; Paste with Red Error toggle
CapsLock & 3::
    send, ^+7
    sendInput, {Text}``Error``
    sendInput, ：
    send, ^v
    send, {Enter}
return
;-------------------------------------------------------------------o
; Remeber what INDENT_LEVEL you will use
CapsLock & 4::
    ; Reload this ahk will reset to 0
    if GetKeyState("alt") = 0
    {
        INDENT_LEVEL++
        ToolTip, % INDENT_LEVEL
    } else{
        INDENT_LEVEL--
        ToolTip, % INDENT_LEVEL
    }
return
;-------------------------------------------------------------------o
CapsLock & 5::
    if GetKeyState("alt") = 1
    {
        ; Auto line comment with java at notion code
        send, {down}{home}
        sendInput, {text}// 
        send, {space}
    } else if GetKeyState("ctrl") = 1 {
        loop, 30
        {
            pasteToggleLineByVscode()
        }
    } else {
        ; Test java code after jrebel update
        send, ^{F9}
        sleep, 3000
        send, ^!r
    }
;-------------------------------------------------------------------o
; use last text format [c]olor

CapsLock & c:: send, ^!h
;-------------------------------------------------------------------o
pasteToggleLineByVscode()
{
    ; Steps:
    ; /^\d[ ]/           -> "### "
    ; /^(\d[\.]|\d[ ])+/ -> ""
    ; 1) contenxt -> txt -> vscode(regex, replace format) 
    ; 2) Notion: > toggele mode with Empty title (Enter)
    ; 3) AHK: call this with loop, counts lines, cursor on zero line
    send, !{tab}
    sleep, 200
    send, {down}
    send, yy
    sleep, 200
    WinActivate, ahk_exe Notion.exe
    send, ^v
    sleep, 100
    send, {Enter}
}
;-------------------------------------------------------------------o
; 自动复制格式编辑区，快速删除用 di{
{
}
;-------------------------------------------------------------------o
pasteCodeByIndentLevel()
{
    ToolTip, % INDENT_LEVEL
    send, ^+8
    send, ^v
    send, ^a
    loop, % INDENT_LEVEL
    {
        send, +{Tab}
    }
    send, ^!m
}
;-------------------------------------------------------------------o
pasteCodeAs(language)
{
    pasteCodeByIndentLevel()
    sleep, 200
    send, ^/
    sleep, 300
    send, % language
    sleep, 700
    If (IME_GET()=0)
    {
        send, {Enter}
    } else {
        ; 输入法中文状态时
        send, {Enter}
        sleep, 50
        send, {Enter}

    }
}
;-------------------------------------------------------------------o
pasteRelativePathByLastIde()
{
    ; switch to copy relative path
    send, !{Tab}
    sleep, 500
    send, ^+a
    sleep, 1000
    ; crpa = copy relative path activate at IDEA & vscode
    sendInput, {Text}crpa
    send, {Enter}
    sleep, 25
    WinActivate, ahk_exe Notion.exe
    sleep, 25
    send, ^v
}
;-------------------------------------------------------------------o
#If



;-------------------------------------------------------------------o
; 功能：输入法状态提示
; 环境：win10+搜狗输入法，输入法状态切换用默认的shift键。
; 作者：sunwind
; 时间：2018年9月1日
; 更新链接：https://blog.csdn.net/liuyukuan/article/details/82291632

~RShift::
    ToolTip
    If (IME_GET()=1)
    {
        send, ^{space}
        ToolTip,EN ;shift得反着提示，提示切换后的状态。
    }
    else
    {
        send, ^{space}
        ToolTip,中
    }
return

~LButton::
    If (A_Cursor = "IBeam" ) {
        Edit_Mode := 1
    } else if (A_Cursor = "Arrow" ) {
        Edit_Mode := 0
    } 

    MouseGetPos, , , WhichWindow, WhichControl
    WinGetPos,winx,winy,,,%WhichWindow%
    ControlGetPos, x, y, w, h, %WhichControl%, ahk_id %WhichWindow%
    ~ ToolTip, %WhichControl%`nX%X%`tY%Y%`nW%W%`t%H%
    if ( 0 = not_Edit_InFocus())
    {
        If (IME_GET()=1)
            ToolTip,中
        else
            ToolTip,EN
    }
return

~RShift up::
~Lbutton up::
    Sleep,1000
    ToolTip
return

not_Edit_InFocus(){
    Global Edit_Mode
    ControlGetFocus theFocus, A ; 取得目前活動窗口 的焦點之控件标识符
return !(inStr(theFocus , "Edit") or (theFocus = "Scintilla1") ;把查到是文字編輯卻不含Edit名的theFucus加進來
or (theFocus ="DirectUIHWND1") or (Edit_Mode = 1))
}

IME_GET(WinTitle="")
;-----------------------------------------------------------
; IMEの状態の取得
;   対象： AHK v1.0.34以降
;   WinTitle : 対象Window (省略時:アクティブウィンドウ)
;   戻り値  1:ON 0:OFF
;-----------------------------------------------------------
{
    ifEqual WinTitle,, SetEnv,WinTitle,A
    WinGet,hWnd,ID,%WinTitle%
    DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)

    ;Message : WM_IME_CONTROL  wParam:IMC_GETOPENSTATUS
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON
    SendMessage 0x283, 0x005,0,,ahk_id %DefaultIMEWnd%
    DetectHiddenWindows,%DetectSave%
Return ErrorLevel
}
;-------------------------------------------------------------------o
