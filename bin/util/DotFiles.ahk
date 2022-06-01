SendMode "Input"
SetWorkingDir A_ScriptDir
FileEncoding "UTF-8"


; 备份和应用配置文件
class Dotfiles {
    
    static HOME_DIR := "C:\Users\" A_UserName
    static DOTS_DIR := "E:\dotfiles"
    static NVIM_DIR := this.HOME_DIR "\AppData\Local\nvim\init.vim"
    static IDEA_DIR := A_AppData "\JetBrains\IntelliJIdea2022.1"
    static POSH_DIR := A_MyDocuments "\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

    static open() {
        path := A_Programs "\Visual Studio Code\Visual Studio Code.lnk"
        activateOrRun("dotfiles ahk_exe Code.exe", path, this.DOTS_DIR)
    }

    static backup() {

    
        FileCopy this.NVIM_DIR, this.DOTS_DIR "\apps\nvim\.config\nvim\init.vim", true
    
        ; C:\Users\miozus\AppData\Roaming\JetBrains\IntelliJIdea2022.1\jba_config\win.keymaps\macOS For All Magic.xml
        FileCopy this.IDEA_DIR "\jba_config\win.keymaps\macOS For All Magic.xml", this.DOTS_DIR "\apps\Idea\keymaps\macOS For All Magic.xml", true
    
        ; 有的版本可能是这样
        ; FileCopy this.IDEA_DIR "\options\postfixTemplates.xml", this.DOTS_DIR "\apps\Idea\snippets", true
        ; DirCopy this.IDEA_DIR "\jba_config\win.keymaps", this.DOTS_DIR "\apps\Idea\keymaps", true
    
        DirCopy A_AppData "\Code\User\sync", this.DOTS_DIR "\apps\Code\User\sync", true 
        FileCopy this.HOME_DIR "\.ideavimrc", this.DOTS_DIR "\apps\idea\.ideavimrc", true 
        ; FileCopy this.HOME_DIR "\.ipython\profile_default\ipython_config.py", this.DOTS_DIR "\apps\python\.ipython\profile_default\ipython_config.py", true
        FileCopy A_AppData "\Code\User\keybindings.json", this.DOTS_DIR "\apps\code\keybindings.json", true
    
        FileCopy this.POSH_DIR, this.DOTS_DIR "\Windows\Microsoft.PowerShell_profile.ps1", true
    
        MsgBox "本机配置已备份，详情可见 Git 版本变化`n`n" this.DOTS_DIR
    }
    
    static apply() {
    
        ; this.HOME_DIR := "C:\Users\" A_UserName
        ; this.DOTS_DIR := "E:\projects\dotfiles"
    
        ; this.NVIM_DIR := this.HOME_DIR "\AppData\Local\nvim\init.vim"
        FileCopy this.DOTS_DIR "\apps\nvim\.config\nvim\init.vim", this.NVIM_DIR,  true
    
        ;FileCopy this.DOTS_DIR "\apps\Idea\keymaps\macOS For All Magic.xml", this.IDEA_DIR "\keymaps\macOS For All Magic.xml",  true
    
        ; 有的版本可能是这样
        ; FileCopy this.IDEA_DIR "\options\postfixTemplates.xml", this.DOTS_DIR "\apps\Idea\snippets", true
        ; DirCopy this.IDEA_DIR "\jba_config\win.keymaps", this.DOTS_DIR "\apps\Idea\keymaps", true
    
        DirCopy this.DOTS_DIR "\apps\Code\User\sync", A_AppData "\Code\User\sync",  true 
        FileCopy this.DOTS_DIR "\apps\idea\.ideavimrc", this.HOME_DIR "\.ideavimrc",  true 
        ; FileCopy this.DOTS_DIR "\apps\python\.ipython\profile_default\ipython_config.py", this.HOME_DIR "\.ipython\profile_default\ipython_config.py",  true 
        FileCopy  this.DOTS_DIR "\apps\code\keybindings.json", A_AppData "\Code\User\keybindings.json", true
    
        FileCopy this.DOTS_DIR "\Windows\Microsoft.PowerShell_profile.ps1", this.POSH_DIR, true
    
        MsgBox "本机配置已备份，详情可见`n`n" this.DOTS_DIR
    }
    
    
}
