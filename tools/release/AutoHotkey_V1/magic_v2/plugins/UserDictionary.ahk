#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;=====================================================================o
;                    UserDictionary
; 用户词典(小鹤双拼/应用首字母)
; 无视输入法状态，敲空格键(语句+空格）或回车键(=语句+空格+回车）显示结果
;-------------------------------------------------------------------o
; Spring Cloud Projects
:*:lhq::{text}localhost:7000
:*:lhb::{text}localhost:8000
:*:lhj::{text}localhost:9000
:*:lhu::{text}localhost:10000
:*:lhuy::{text}localhost:11000
:*:appy::{text}application.yml
:*:appp::{text}application.properties
:*:px::{text}pom.xml
:*:scd::SpringCould
:*:sbt::SpringBoot
;-------------------------------------------------------------------o
; 中文词组
::guli::谷粒
;-------------------------------------------------------------------o
; 计算机术语
:*:\o::O(){Left}
;-------------------------------------------------------------------o
;-------------------------------------------------------------------o
; 自定义助记符号；不区分大小写；* 表示不需要终止符
:*:\SI::
    sendinput, {text}ServiceImpl:%A_Space%
return
:*:\DT::
    FormatTime, TimeString, , yyyy-MM-dd HH:mm:ss
    SendInput {Text}%TimeString%
Return
;-------------------------------------------------------------------o
; 彩文字和表情符号
:*:\!::{text}``?!``
:*:\co::{text}``Error``
;-------------------------------------------------------------------o
; 系统剪切板候选
:*:\1::
    getClipboard(1)
return
:*:\2::
    getClipboard(2)
return
:*:\3::
    getClipboard(3)
return
;-------------------------------------------------------------------o
getClipboard(index:=1)
{
    index--
    send, #v
    sleep, 100
    sendInput, {Down %index%}{Enter} ; last one clipboard
}
;-------------------------------------------------------------------o

;-------------------------------------------------------------------o
; 终端命令快捷键
; docker
::dpa::docker ps -a
;-------------------------------------------------------------------o
; linux
; powershell
::tkp::taskkill /PID 8 /F
::lsp::netstat -ano | findstr :8

;-------------------------------------------------------------------o

