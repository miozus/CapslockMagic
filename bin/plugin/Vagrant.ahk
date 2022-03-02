;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode "Input"    ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.


;---------------------------------------------------------------------o
; check out vagrant , show docker service
vagrantStart()
{
    Send "cmd.exe /c cd E:\Oracle\HashiCorp\CentOS && vagrant ssh"
    Sleep 10 * 1000
    Send "su{Enter}"
    Sleep 100
    Send "vagrant{Enter}"
    Send "sudo docker ps -a{Enter}"
}
;---------------------------------------------------------------------o
; posh:  vagrant up 
vagrantUp()
{
    Run "PowerShell.exe"
    Sleep 1600
    Send "cd E:\Oracle\HashiCorp\CentOS{Enter}"
    Send "vagrant up{Enter}"
}   
;---------------------------------------------------------------------o
PowerShell(Script, Options := "", Params := "-ExecutionPolicy Bypass")
{
    SplitPath Script, psfile, WorkingDir
    ;MsgBox % psfile "|" WorkingDir
    Run % "PowerShell.exe " . Params . " -Command &{./'" . psfile . "'}", % WorkingDir == "" ? A_ScriptDir : WorkingDir, % Options, PID
    Return PID
}
;---------------------------------------------------------------------o