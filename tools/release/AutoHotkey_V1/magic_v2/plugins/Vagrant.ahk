#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


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
