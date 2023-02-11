#Include impl\IDE.ahk
#Include impl\Idea.ahk
#Include impl\IdeVim.ahk

;=====================================================================o
; 所有代码编辑器
#hotif Enviorment.hasIde()
CapsLock:: IDE.Esc()
CapsLock & 2:: IDE.terminal()
CapsLock & 4:: IDE.service()
CapsLock & 5:: IDE.debug()
#HotIf

;=====================================================================o
; 仅限大脑喷射编辑器 IDEA
#Hotif App.Idea.isActive()
LCtrl & \:: Vim.javaDocViaMethodLine()
CapsLock & 5:: Idea.Jrebel.compile()
CapsLock & 7:: Idea.eidtVmOptions()
CapsLock & b:: Idea.implement()
CapsLock & .:: Idea.delete()
CapsLock & n:: Idea.backspace()
CapsLock & w:: Idea.closeTab()
CapsLock & x:: Idea.stop()
CapsLock & z:: Idea.runContextCode()
#HotIf

;=====================================================================o
; 仅限谷歌浏览器
#Hotif App.Chrome.isActive()
CapsLock & 2:: Idea.focusPasteElementByIdeavim()
#Hotif