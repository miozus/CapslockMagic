class Notion {
    
    static editCaption() {
        Send "{Blind!}^!m"
    }

    static refBookmark()
    {
        Send "^v"
        ; 2023-02 快捷键改版
        Send "{Enter}"
        Sleep 100
        this.editCaption()
    }

    static pasteCode()
    {
        Send "{Blind!#+}^+8"
        Send "{Blind!#+}^v"
        Send "{Blind!#+}^a"
        Send "+{Tab " INDENT_LEVEL "}"
        Send "^!m"
    }

    static pasteCodeAs(language)
    {
        ToolTip "⇤ " INDENT_LEVEL
        Notion.pasteCode()
        Sleep 200
        Send "{blind!#}^/"
        Sleep 300
        Send language
        Sleep 700
        if (IME.exists() = 1) {
            ; 输入法中文状态时
            Send "{Enter}"
            Sleep 50
        }
        Send "{Enter}"
        SetTimer () => Tooltip(), -1000
    }

    static pasteRelativePathByLastIDE()
    {
        ; switch to copy relative path
        Send "!{Tab}"
        Sleep 500
        Send "^+a"
        Sleep 1000
        ; crpa = copy relative path activate at IDEA & vscode
        Send "{Text}crpa"
        Send "{Enter}"
        Sleep 25
        WinActivate "ahk_exe Notion.exe"
        Sleep 25
        Send "^v"
    }

    static pasteToggleStartWith(tag:="null")
    {
        ; 默认值留空，则跳过这步
        ; 否则按参数打标签;因为非空!=""判断写法总为真
        ; 诡异机制，变量抢先于字符串输出了，只有加 50 延迟区分出来
        Send "^+7"
        if tag != "null" {
            Send "{Text}" tag
            Sleep 50
        }
        Send "^v"
        Send "{Enter}"
    }

    static commentByDoubleSlash(){
        ; Auto line comment with java at Notion code
        Loop INDENT_LEVEL
        {
            Send "{down}{home}"
            Send "{text}// " 
        }
    }

    static cleanVariableFormat() {
        Send "{Blind}{LButton}"
        Send "{Blind}^a^e^e^b^b^i^i"
    }
    static switchCodeAsFormat(language) {
        Send "{Blind^}{LButton}"
        Send "{blind!#}^/"
        Sleep 50
        Send "{Text}" language
        Sleep 700
        Send "{Enter}"

    }

    static pasteCodeSingleLine(){
        Send "{Bind!}^v"
        Sleep 50
        Send "{Bind!}{BackSpace}"
        Send "{Bind!}{Home}" ; 删除头部空白
        Send "{Bind!}^{Right}"
        Send "{Bind!}^{Left}"
        Send "{Bind!}^{BackSpace}"
        Send "{Bind!}{End}{Enter}{Tab}" ; 另一一行
        ; Send "{Bind!}^{Tab}" ; 中文注释
    }
}