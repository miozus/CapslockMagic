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
;=====================================================================o
;                    Utils Macro
;---------------------------------------------------------------------o
; 使用ahk工具查看控件，以便获得控制权限
openWinSpy() {
    activateOrRun("ahk_exe WindowSpy.exe", "bin\plugin\WindowSpy.ahk")
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
class GC {

    ; 收尾阶段，按下外部逻辑锁死的键，解除锁定(不要按 CapsLock 停止)
    static ModifyKey() {
        ; Send "{Alt}{Ctrl}"
        if GetKeyState("LWin")
        {
            Send "{LWin Up}"
            Sleep 100
            Send "{Esc}"
        }
        if GetKeyState("Alt")
        {
            Send "{Alt Up}"
        }
        if GetKeyState("Ctrl")
        {
            Send "{Ctrl Up}"
        }
        Sleep 100
        ToolTip
        ; ToolTip "  LAlt" GetKeyState("LAlt") " LWin" GetKeyState("LWin") " LCtrl" GetKeyState("LCtrl") 
    }

    static ModifyKeyDocker() {
        ; Send "{Alt}{Ctrl}"
        if GetKeyState("Alt")
        {
            Tooltip "Alt"
            Send "{Alt Up}"
        }
        if GetKeyState("Ctrl")
        {
            Tooltip "Ctrl"
            Send "{Ctrl Up}"
        }
        ToolTip
        ; ToolTip "  LAlt" GetKeyState("LAlt") " LWin" GetKeyState("LWin") " LCtrl" GetKeyState("LCtrl") 
    }

    static ModifyKeyPhysical() {
        Send "{Alt}{Ctrl}"
        if GetKeyState("LWin")
        {
            Send "{LWin Up}"
            Sleep 100
            Send "{Esc}"
        }
        Sleep 100
        ToolTip
        ; ToolTip "  LAlt" GetKeyState("LAlt") " LWin" GetKeyState("LWin") " LCtrl" GetKeyState("LCtrl") 
    }
    


    static disableOtherHotkey(thisHotkey)
    {
        global allHotkeys, EnableChinesePunctuation := false
        for index, value in allHotkeys
        {
            if (value != thisHotkey) {
                hotkey value, "off"
            }
        }
    }

    static enableOtherHotkey(thisHotkey)
    {
        global allHotkeys, EnableChinesePunctuation := true
        for index, value in allHotkeys
        {
            if (value != thisHotkey) {
                hotkey value, "on"
            }
        }
    }

    static disableAllHotkey()
    {
        global allHotkeys 
        for index, value in allHotkeys
            hotkey value, "off"
    }

    
    
}