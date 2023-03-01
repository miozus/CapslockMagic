#Include impl\IDE.ahk
#Include impl\Idea.ahk
#Include impl\IdeVim.ahk
#Include impl\WxDevTools.ahk
#Include impl\Vscode.ahk

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

;=====================================================================o
; 仅限微信开发工具
#Hotif App.WxDevTools.isActive()
CapsLock & 1:: WxDevTools.batch()
CapsLock & 2:: WxDevTools.testRegisterCreate()
#Hotif

;=====================================================================o
; 仅VSCode
#Hotif App.Vscode.isActive()
CapsLock & 5:: Vscode.run()
#Hotif

;=====================================================================o
; 所有代码编辑器 （特殊放前面，普遍放最后）
#hotif Enviorment.hasIde()
CapsLock:: IDE.Esc()
CapsLock & 2:: IDE.terminal()
CapsLock & 4:: IDE.service()
CapsLock & 5:: IDE.run()
#HotIf