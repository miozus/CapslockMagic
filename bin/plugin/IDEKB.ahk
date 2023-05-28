#Include impl\IDE.ahk
#Include impl\Idea.ahk
#Include impl\IdeVim.ahk
#Include impl\WxDevTools.ahk
#Include impl\Vscode.ahk
#Include impl\Chrome.ahk

;=====================================================================o
; 仅限大脑喷射编辑器 IDEA
#Hotif App.Idea.isActive()
LCtrl & \:: Vim.javaDocViaMethodLine()
CapsLock & 1:: Idea.Jrebel.hotspot()
CapsLock & 2:: Idea.terminal()
CapsLock & 3:: Idea.Git.nextDiff()
CapsLock & 4:: IdeVim.rename()
CapsLock & b:: Idea.implement()
CapsLock & w:: Idea.closeTab()
CapsLock & x:: Idea.stop()
CapsLock & z:: Idea.runContextCode()
#HotIf

;=====================================================================o
; 仅限谷歌浏览器
#Hotif App.Chrome.isActive()
CapsLock & 1:: Chrome.address()
CapsLock & 2:: Chrome.debug()
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
CapsLock & 5:: IDE.debug()
CapsLock & 8:: IDE.service()
#HotIf