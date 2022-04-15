SendMode "Input"	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir	; Ensures a consistent starting directory.

;=====================================================================o
;                    Common Utilities
;---------------------------------------------------------------------o

;=====================================================================o
;                    Activate Or Run
;---------------------------------------------------------------------o
; 缓存
global last_winFilter := ""
global shell := ""
;---------------------------------------------------------------------o
ActivateOrRun(to_activate := "", target := "", args := "", workingdir := "", RunAsAdmin := false)
{
    to_activate := Trim(to_activate)
    ; WinShow, %to_activate%
    if (to_activate && winexist(to_activate)) {
        MyGroupActivate(to_activate)
    } else if (target != "")
    {
        ;showtip("not exist, try to start !")
        if (RunAsAdmin)
        {
            if (substr(target, 1, 1) == "\")
                target := substr(target, 2, strlen(target) - 1)
            Run target args, WorkingDir
        } else
        {
            oldTarget := target
            target := WhereIs(target)
            if (target)
            {
                if (SubStr(target, -3) != ".lnk") {
                    ShellRun(target, args, workingdir)
                } else {
                    ; 检查 lnk 是否损坏
                    FileGetShortcut target, &OutTarget
                    ; if FileExist(OutTarget)
                    ShellRun(target, args, workingdir)
                }
            } else {
                try
                {
                    if (workingdir && args) {
                        Run oldTarget args, workingdir
                    } else if (workingdir) {
                        Run oldTarget, workingdir
                    } else if (args) {
                        Run oldTarget args
                    } else {
                        Run oldTarget
                    }
                } catch Error
                {
                    tip(Error.Message)
                }
            }
            ; 有的应用启动，竟然不会置顶，所以需要激活一下
            ; if (to_activate) {
                ; Sleep 1000
                ; WinActivate to_activate
            ; }
        }
    }
}
;---------------------------------------------------------------------o
/*
    通过 shell 降权，以普通用户权限启动应用
    ShellRun by swagfag 2021/04/24
    Requires AutoHotkey v2.0-a136-feda41f4
    https://www.autohotkey.com/boards/viewtopic.php?t=78190
 */
ShellRunApp(prms*)
{
    shellWindows := ComObject("Shell.Application").Windows
    desktop := shellWindows.FindWindowSW(0, 0, 8, 0, 1)	; SWC_DESKTOP, SWFO_NEEDDISPATCH

    ; Retrieve top-level browser object.
    if tlb := ComObjQuery(desktop,
        "{4C96BE40-915C-11CF-99D3-00AA004AE837}",	; SID_STopLevelBrowser
        "{000214E2-0000-0000-C000-000000000046}")	; IID_IShellBrowser
    {
        ; IShellBrowser.QueryActiveShellView -> IShellView
        if ComCall(15, tlb, "ptr*", &psv := 0) = 0
        {
            ; Define IID_IDispatch.
            IID_IDispatch := Buffer(16)
            NumPut("int64", 0x20400, "int64", 0x46000000000000C0, IID_IDispatch)

            ; IShellView.GetItemObject -> IDispatch (object which implements IShellFolderViewDual)
            ComCall(15, psv, "uint", 0, "ptr", IID_IDispatch, "ptr*", &pdisp := 0)

            ; Get Shell object.
            shell := ComObjFromPtr(pdisp).Application

            ; IShellDispatch2.ShellExecute
            shell.ShellExecute(prms*)

            ObjRelease(psv)
        }
    }
}

;---------------------------------------------------------------------o
; 📦 缓存机制
ShellRun(prms*)
{
    global shell
    try {
        try {
            if (shell) {
                shell.ShellExecute(prms*)
                return
            }
        } catch {
            tip("refresh shell cache")
        }
        ShellRunApp(prms*)
    } catch Error as e {
        MsgBox e.Message
        tip("shell failed")
    }
}
;---------------------------------------------------------------------o
GetProcessName(id := "") {
    if (id == "")
        id := "A"
    else
        id := "ahk_id " . id

    name := WinGetProcessName(id)
    if (name == "ApplicationFrameHost.exe") {
        ;ControlGet hwnd, Hwnd,, Windows.UI.Core.CoreWindow, %id%
        hwnd := ControlGetHwnd("Windows.UI.Core.CoreWindow1", id)
        if hwnd {
            name := WinGetProcessName("ahk_id " hwnd)
        }
    }
    return name
}

HasVal(haystack, needle)
{
    if !(IsObject(haystack)) || (haystack.Length = 0)
        return 0
    for index, value in haystack
        if (value = needle)
            return index
    return 0
}

WinVisible(id)
{
    ;WingetPos x, y, width, height, ahk_id %id%
    title := WinGetTitle("ahk_id " id)
    ;WinGet, state, MinMax, ahk_id %id%
    ;tooltip %x% %y% %width% %height%

    ;sizeTooSmall := width < 300 && height <dict 300 && state != -1 ; -1 is minimized
    empty := !Trim(title)
    ;if (!sizeTooSmall && !empty)
    ;    tooltip %x% %y% %width% %height% "%title%"

    return empty ? 0 : 1
    ;return  sizeTooSmall || empty  ? 0 : 1
}

GetVisibleWindows(winFilter)
{
    ids := []

    id := WinGetList(winFilter, , "Program Manager")
    for this_id in id{
        if (WinVisible(this_id))
        {
            ids.push(this_id)
        }
    }
    if (ids.length == 0)
    {
        pos := Instr(winFilter, "ahk_exe") - StrLen(winFilter) + StrLen("ahk_exe")
        pname := Trim(Substr(winFilter, pos))
        id := WinGetList("ahk_class ApplicationFrameWindow")
        for this_id in id {
            get_name := GetProcessName(this_id)
            if (get_name == pname) {
                ids.push(this_id)
            }
        }
    }
    return ids
}

WhereIs(FileName)
{
    ; 校验路径线索，深入系统多个目录，直到找到可执行的文件名称
    ; https://autohotkey.com/board/topic/20807-fileexist-in-path-environment/

    ; Working Folder
    PathName := A_WorkingDir "\"
    if (FileExist(PathName FileName)) {
        Return PathName FileName
    }

    ; absolute path
    if (FileExist(FileName)) {
        Return FileName
    }

    ; Parsing DOS Path variable
    DosPath := EnvGet("Path")
    Loop Parse DosPath, "`;"
    {
        if (A_LoopField == "") {
            Continue
        }
        if (FileExist(A_LoopField "\" FileName)) {
            Return A_LoopField "\" FileName
        }
    }

    ; Looking up Registry
    PathName := RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\", FileName)
    if (FileExist(PathName)) {
        Return PathName
    }

}

GroupAddId(&GroupName, p1 := "", p2 := "", p3 := "", p4 := "", p5 := "")
{
    static g := 1
    If (GroupName == "") {
        GroupName := "AutoName" g++
    }
    GroupAdd GroupName, p1, p2 p3 p4 p5
}

MyGroupActivate(winFilter)
{

    winFilter := Trim(winFilter)
    if (!winactive(winFilter))
    {
        activateFirstVisible(winFilter)
        return
    }

    ; group 是窗口组对象, 这个对象无法获取内部状态, 所以用 win_group_array_form 来储存他的状态
    global win_group
    global win_group_array_form
    global last_winFilter

    ; 判断是否进入了新的窗口组
    ; 缓存机制，初始值为空
    if (winFilter != last_winFilter)
    {
        last_winFilter := winFilter
        win_group_array_form := []
        win_group := ""	; 建立新的分组
    }

    ; 对比上一次的状态, 获取新的窗口, 然后把新窗口添加到 win_group_array_form 状态和 win_group
    curr_group := GetVisibleWindows(winFilter)
    for val in curr_group
    {
        ; val := curr_group[A_Index]
        if (!HasVal(win_group_array_form, val))
        {
            win_group_array_form.push(val)
            GroupAddId(&win_group, "ahk_id " val)
        }
    }

    GroupActivate win_group, "R"
}

SwitchWindows()
{
    winClass := WinGetClass("A")
    if (winClass == "ApplicationFrameWindow") {
        title := WinGetTitle("A")
        to_check := title " ahk_class ApplicationFrameWindow"
    } else
        to_check := "ahk_exe " GetProcessName()

    MyGroupActivate(to_check)
    return
}

IsBrowser(pname)
{
    Haystack := "chrome.exe,MicrosoftEdge.exe,firefox.exe,360se.exe,opera.exe,iexplore.exe,qqbrowser.exe,sogouexplorer.exe"
    return InStr(Haystack, pname, false)
}

SmartCloseWindow()
{
    if (winactive("ahk_class WorkerW ahk_exe explorer.exe"))
        return

    thisClass := WinGetclass("A")
    name := GetProcessName()
    if IsBrowser(name)
        Send "^w"
    else if WinActive("- Microsoft Visual Studio ahk_exe devenv.exe")
        Send "^{f4}"
    else
    {
        if (thisClass == "ApplicationFrameWindow" || name == "explorer.exe")
            Send "!{f4}"
        else
        ; WM_SYSCOMMAND
            PostMessage 0x112, 0xF060, , , "A"
    }
}

activateFirstVisible(windowSelector)
{
    id := firstVisibleWindow(windowSelector)
    ; WinGet, State, MinMax, ahk_id %id%
    ; if (State = -1)
    ;     WinRestore, ahk_id %id%
    WinActivate "ahk_id " id
}

firstVisibleWindow(windowSelector)
{
    winList := WinGetList(windowSelector)
    for this_id in winList
    {
        ; item := winList A_Index
        title := WinGetTitle(this_id)
        if (Trim(title) != "") {
            return this_id
        }
    }
}

disableOtherHotkey(thisHotkey)
{
    global allHotkeys, EnableChinesePunctuation := false
    for index, value in allHotkeys
    {
        if (value != thisHotkey) {
            hotkey value, "off"
        }
    }
}

enableOtherHotkey(thisHotkey)
{
    global allHotkeys, EnableChinesePunctuation := true
    for index, value in allHotkeys
    {
        if (value != thisHotkey) {
            hotkey value, "on"
        }
    }
}

;=====================================================================o
;                    Utils Macro
;---------------------------------------------------------------------o
; 激活或运行, 默认初始英文输入法（省略不填参数；如需中文，再加逗号和“中文”，要包含双引号）
; @Deprecated
activateOrRunOld(title, exe_path, language := "EN") {
    if WinExist(title) {
        WinActivate
    } else {
        Run exe_path
    }
    IME.set(language)	; 默认以小写开始; posh 失去控制权，要下两下才能保持英文
}
;---------------------------------------------------------------------o
; 使用ahk工具查看控件，以便获得控制权限
openWinSpy() {
    activateOrRunOld("ahk_exe WindowSpy.exe", "bin\plugin\WindowSpy.ahk")
}

; 单击鼠标右键，以第 N 个方式打开该文件
openByAppKey(sort := 0) {
    tip(sort--, -1000)
    Send "{AppsKey}"
    Send "{down " sort "}"
    Send "{Enter}"
}
;---------------------------------------------------------------------o
; 简单的后台登陆操作，输入验证码时，输入法设为英文
loginAdmin() {
    Send "{text}admin"
    Send "{Tab}"
    Send "{text}admin"
    Send "{Tab}"
    IME.set("EN")
}
;---------------------------------------------------------------------o
; 复制文字用记事本查看
pasteInNotepad()
{
    Send "^c"
    if WinExist("ahk_class Notepad")
    {
        WinActivate
    } else
    {
        Run "Notepad"
        WinWait "ahk_class Notepad"
        WinActivate
    }
    Send "^a^v"
}
;---------------------------------------------------------------------o
copySelectWord() {
    sendEvent "^{Left}^+{Right}"
    Send "^c"
}
;---------------------------------------------------------------------o
getSelectString() {
    Send "^c"
    return A_Clipboard
}

;=====================================================================o
;                     Tooltip Packing
;---------------------------------------------------------------------o
; 悬浮提示状态信息的封装
tip(message, duration := -1000)
{
    ToolTip message
    SetTimer closeToolTip, duration
}

closeToolTip()
{
    ToolTip
}

debugModifierKey() {
    ToolTip (
        "> LAlt" GetKeyState("LAlt")
        " LWin" GetKeyState("LWin")
        " LCtrl" GetKeyState("LCtrl")
    )
    SetTimer () => ToolTip(), -1000
}
;---------------------------------------------------------------------o


; 🧪 开发工具
; ---
; 辅助写代码的集合：取色，取坐标，序列化二维数组（储存数据库）
class DevUtils {

   static serilize(nestedObj) {
        inner := "", outer := ""
        for k1, nested in nestedObj.OwnProps() {
            for k2, v2 in nested.OwnProps() {
                inner .= k2 ':"' v2 '", '
            }
            outer .= k1 ': {' Rtrim(inner, ", ") '},`n'
            inner := ""
        }
        outer := "{`n" Rtrim(outer, ",`n") "`n}"
        A_Clipboard := outer
        msgbox outer, "已拷贝"
        return outer
    }

    static getPixelSearchCode(d := 5) {
        MouseGetPos & x, &y
        msg := x - d ", " y - d ", " x + d ", " y + d ", " PixelGetColor(x, y)
        A_clipboard := "PixelSearch(&FoundX, &FoundY, " msg ", 3)"
        Tooltip msg " 已拷贝"
        SetTimer () => ToolTip(), -2000
    }

    static getMousePosCode() {
        MouseGetPos & x, &y
        msg := x " " y
        A_clipboard := 'Click "' msg '"'
        Tooltip msg " 已拷贝"
        SetTimer () => ToolTip(), -2000
    }
    
}

class Dotfiles {
    
    static HOME_DIR := "C:\Users\" A_UserName
    static DOTS_DIR := "E:\projects\dotfiles"
    static NVIM_DIR := this.HOME_DIR "\AppData\Local\nvim\init.vim"
    static IDEA_DIR := A_AppData "\JetBrains\IntelliJIdea2022.1"
    static POSH_DIR := A_MyDocuments "\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

    static open() {
        path := A_Programs "\Visual Studio Code\Visual Studio Code.lnk"
        activateOrRun("dotfiles ahk_exe Code.exe", path, this.DOTS_DIR)
    }

    static backup() {

    
        FileCopy this.NVIM_DIR, this.DOTS_DIR "\apps\nvim\.config\nvim\init.vim", true
    
        FileCopy this.IDEA_DIR "\keymaps\macOS For All copy.xml", this.DOTS_DIR "\apps\Idea\keymaps\macOS For All copy.xml", true
    
        ; 有的版本可能是这样
        ; FileCopy this.IDEA_DIR "\options\postfixTemplates.xml", this.DOTS_DIR "\apps\Idea\snippets", true
        ; DirCopy this.IDEA_DIR "\jba_config\win.keymaps", this.DOTS_DIR "\apps\Idea\keymaps", true
    
        DirCopy A_AppData "\Code\User\sync", this.DOTS_DIR "\apps\Code\User\sync", true 
        FileCopy this.HOME_DIR "\.ideavimrc", this.DOTS_DIR "\apps\idea\.ideavimrc", true 
        FileCopy this.HOME_DIR "\.ipython\profile_default\ipython_config.py", this.DOTS_DIR "\apps\python\.ipython\profile_default\ipython_config.py", true 
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
; 文件管理工具：读写，文件名添加日期
class FileUtils {


    static outputAs(textStr, fileName)
    {
        if (FileName == "" || textStr == "") {
            msgbox "传输数据/文件名称为空，无法导出"
            return
        }
        try {
            DirCreate ".\dist"
            FileName := ".\dist\" this.fileNameAddToday(fileName)
        }
        catch Error as err {
            ToolTip err.Message
            return
        }
        ; FileName := FileSelect("S16",, "Create a new file:")
        ; connect other script
        absoluteDir := A_WorkingDir LTrim(FileName, ".") 
        A_Clipboard := absoluteDir

        try
            ; 要打开文件的路径, 如果未指定绝对路径则假定在 A_WorkingDir 中.
            FileObj := FileOpen(FileName, "w")
        catch Error
        {
            MsgBox "无法打开文件 " FileName 
                . "`n`n" Type(err) ": " err.Message
                . "`n`n 请检查文件路径或名称是否正确" 
            return
        }
        try {
            ; 通过这种方式写入内容到文件时, 要使用 `r`n 而不是 `n 来开始新行.
            FileObj.Write(textStr)
            FileObj.Close()
        msg := 
        (
            '1.当前系统编码为 ' FileObj.Encoding 
            '`n`n注意：只有 UTF-8 支持保留 emoji（修改方法：系统设置 > 搜索管理语言设置 > 更改系统区域设置 > 勾选 Beta版：UTF-8。不用重启，多转换几次，成功后再改回去）`n'
            '`n2.保存完成，地址已拷贝（可按 Ctrl+V 粘贴）:`n`n' absoluteDir
        )
            MsgBox msg, "CapslockMagic 🎊"
        } catch Error as err {
            ToolTip err
            return
        }
        SetTimer () => ToolTip(), -2000
    }

    static inputFrom(FileName) {
        ; 默认目录 A_WorkingDir
        ; 现在已经把内容写入文件了, 把它们读取回内存中.
        try
            FileObj := FileOpen(FileName, "r-d")	; 读取文件 ("r"), 共享除了删除 ("-d") 外的所有访问权限
        catch Error as err
        {
            MsgBox "无法打开文件 " FileName 
                . "`n`n" Type(err) ": " err.Message
                . "`n`n 请检查文件路径或名称是否正确" 
            return
        }
        ; 限制读取首行的字节长度，默认为全文长度
        ; CharsToRead := StrLen(textString)
        ; textString := FileObj.Read(CharsToRead)
        textString := FileObj.Read()
        FileObj.Close()
        return textString
        ; MsgBox "The following string was read from the file: " textString
    }

    static fileNameAddToday(fileName) {
        name := StrSplit(fileName, ".")
        return name[1] FormatTime(, "yyyyMMdd") "." name[2]
    }

}

; 动画合集
class Animation {

    static switchTrayIcon() {
        ;  停用脚本，为了打字
        if A_IsSuspended {
            Traytip "⏸️ 已暂停"
            TraySetIcon("bin\img\capslock_pause.ico", 1, 1)
            SetTimer () => Traytip(), -1000
        } else {
            Traytip "🖤 继续运行"
            TraySetIcon("bin\img\capslock_run.ico", 1, 1)
            SetTimer () => Traytip(), -1000
        }
    }

    static initTrayIcon() {
        TraySetIcon("bin\img\capslock_run.ico", 1, 1)
        ToolTip "🖤"
        SetTimer () => ToolTip(), -500
    }

    ; 爆炸动画，持续1.2s
    static bombExploseGif() {
        ToolTip "-----"
        Sleep 100
        ToolTip "*----"
        Sleep 50
        ToolTip "**---"
        Sleep 50
        ToolTip "***--"
        Sleep 50
        ToolTip "****-"
        Sleep 100
        ToolTip " 💣 "
        Sleep 150
        ToolTip "      "
        Sleep 25
        ToolTip " 💣 "
        Sleep 150
        ToolTip "      "
        Sleep 25
        ToolTip " 💥 "
        Sleep 500
        ToolTip
    }
}

; 动画计时器
class Timer {
    
    ; 周期
    static moonRetation(count) {
        i := 1
        Loop count {
            switch Mod(i, 8) {
               case 1 : tooltip "🌑"
               case 2 : tooltip "🌒"
               case 3 : tooltip "🌓"
               case 4 : tooltip "🌔"
               case 5 : tooltip "🌕"
               case 6 : tooltip "🌖"
               case 7 : tooltip "🌗"
               case 0 : tooltip "🌘"
            }
            Sleep 1000
            i++
        }
        tooltip
    }

    ; 二进制沙漏
    static hourGlass(count) {
        i := 1
        Loop count {
            if Mod(i, 2) {
                tooltip "⏳ " i
            } else {
                tooltip "⌛ " i
            }
            Sleep 1000
            i++
        }
        tooltip
    }

}

class GC {
    ; 收尾阶段，按下外部逻辑锁死的键，解除锁定(不要按 CapsLock 停止)
    static ModifyKey() {
        Send "{Alt}{Ctrl}"
        if GetKeyState("LWin")
        {
            Send "{LWin}"
            Sleep 100
            Send "{Esc}"
        }
        Sleep 100
        ToolTip
        ; ToolTip "  LAlt" GetKeyState("LAlt") " LWin" GetKeyState("LWin") " LCtrl" GetKeyState("LCtrl") 
    }
    
}

;---------------------------------------------------------------------o
;                       常用网站
;---------------------------------------------------------------------o
editArticles() {
    Run "https://www.zhihu.com/creator/manage/creation/all"
    Run "https://mp.csdn.net/mp_blog/manage/article"
    Run "https://www.jianshu.com/writer#/notebooks/51241025/notes/92966389"
    Run "https://www.cnblogs.com/miozus/"
}

alg4() {
    Run "https://visualgo.net/zh/sorting"
}

class Tencent {

    static docs() {
        Run "https://docs.qq.com/desktop/"
    }
}