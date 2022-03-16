#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


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


