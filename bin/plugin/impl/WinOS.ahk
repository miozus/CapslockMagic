; Windows 操作系统命令
class WinOS {

  ; 访达
  class Folder {

    static picture() {
      Run "shell:my pictures"
    }

    static personal() {
      Run "shell:Personal"
    }

    static recycle() {
      Run "shell:RecycleBinFolder"
    }

    static downloads() {
      Run "shell:downloads"
    }

  }

  ; 平行桌面
  class Desktop {

    static previous() {
      Send "{Blind}^#{Left}"
    }

    static next() {
      Send "{Blind}^#{Right}"
    }

  }

  ; 状态栏
  class Dock {

    static hidden() {
      Send "{RWin}"
      Sleep 50
      Send "{Esc}"
      Send "{Esc}"
    }

  }

  class Editor {

    ; 复制文字用记事本查看
    static pasteInNotepad()
    {
      Send "^c"
      if WinExist("ahk_class Notepad") {
        WinActivate
      } else {
        Run "Notepad"
        if (WinWait("ahk_class Notepad", , 2))
          WinActivate
      }
      Send "^a^v"
    }

    static notepad() {
      this.pasteInNotepad()
      path := "notepad"
      activateOrRun("记事本", path, "", "")
    }

  }

  ; 管理器
  class Manager {

    static task() {
      Run "taskmgr"
    }

    static explorer() {
      activateOrRun("ahk_class CabinetWClass", "")
    }

    static explorerReload() {
      path := "tools\重启资源管理器.exe"
      ActivateOrRun("", path, "", "")
    }

  }

  ; 电源
  class Power {

    static sleep() {
      DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
    }

    static slideToShutdown() {
      run "SlideToShutDown"
      sleep 1300
      Click 100, 100
    }

    static slideToReboot() {
      run "SlideToShutDown"
      sleep 1300
      Click 100, 100
      sleep 250
      ; 0 = 注销
      ; 1 = 关机
      ; 2 = 重启
      ; 4 = 强制
      ; 8 = 关闭电源
      shutdown 2
    }

  }

  ; 窗口
  class Window {

    static close() {
      if (winactive("ahk_class WorkerW ahk_exe explorer.exe"))
        return
      thisClass := WinGetclass("A")
      name := GetProcessName()
      if IsBrowser(name)
        Send "^w"
      else
      {
        if (thisClass == "ApplicationFrameWindow" || name == "explorer.exe")
          Send "!{f4}"
        else
        ; WM_SYSCOMMAND
          PostMessage 0x112, 0xF060, , , "A"
      }
    }

    static stickOnTop() {
      exStyle := WinGetExStyle("A")
      if (exStyle & 0x8)  ; 0x8 为 WS_EX_TOPMOST
      {
        exStyle := "  取消置顶  "
        WinSetAlwaysOnTop False, "A"
      } else {
        exStyle := "  窗口置顶  "
        WinSetAlwaysOnTop True, "A"
      }
      tip(exStyle, -500)
    }

    static shift() {
      winClass := WinGetClass("A")
      if (winClass == "ApplicationFrameWindow") {
        title := WinGetTitle("A")
        to_check := title " ahk_class ApplicationFrameWindow"
      } else
        to_check := "ahk_exe " GetProcessName()

      MyGroupActivate(to_check)
      return
    }
  }

}