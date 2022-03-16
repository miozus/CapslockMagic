#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;=====================================================================o
;                    I dont need it any more
;---------------------------------------------------------------------o
; Windows 10
#h:: ; 听写，几乎没有麦克风
#c:: ; Cortana，人工智障
#p:: ; 投影屏幕，没有别的屏幕，单机版
#s:: ; 搜索，# 本身已经自带了
#f:: ; 反馈中心，几十年没反馈过问题
#u:: ; 轻松设置中心，一年不用一次
#Pause:: ; 关于本机，一年不用一次
#b:: ; 显示隐藏托盘，用手点击或者win召唤即可，为idea让步
^#f:: ; 搜索本地电脑，没有局域网
return

;=====================================================================o
;                    Recycle
;---------------------------------------------------------------------o
#IfWinActive, ahk_exe idea64.exe
; Leetcode in diea
#s:: send, ^#!s{Enter} ; submit
#t:: send, ^#!t{Enter} ; test
#p:: send, ^#!p        ; position
#0:: send, ^#!0        ; colapse
#b:: send, ^!b         ; jump to implement
;---------------------------------------------------------------------o
; 根据软件快捷键特性，重写方法: Insert 模式成功率高
CapsLock & .:: 
    if GetKeyState("alt") = 0
        Send, ^{Del} 
    else
    {

        SendInput, ^+{Right}
        sleep, 50
        sendinput, {Del}
    } 
return
;---------------------------------------------------------------------o
CapsLock & n:: 
    if GetKeyState("alt") = 0
        Send, ^{BS} 
    else 
    {
        
        SendInput, ^+{Left}
        sleep, 50
        sendinput, {BS}
    }
return
;---------------------------------------------------------------------o
#If