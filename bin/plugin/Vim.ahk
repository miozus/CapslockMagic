SendMode "Input"
SetWorkingDir A_ScriptDir

class Vim {

    ; 当前行直接注释方法名称
    ; - 免去每次手动跳转到方法
    ; - 冗余操作：接口也行
    static javaDocViaMethodLine()
    {
        Send "{Text}^2W"
        Send "{Blind}^\"
        Send "{Text}B"
        Send "{Blind}^\"
    }
    ; r寄存器：强化提取变量
    static abstractVariable(){
        send "{Blind}!{Enter}"
        sleep 500  
        send "va{Enter}" ; 提取变量
        send "{Enter}"
        sleep 50  
        send "{Enter}"
        send "{Esc}"
        send '{Text}^W"rywo' ; vim：复制变量，另起一行
    }
    
    static searchByPaste(){
        Send "{Blind}/"
        Send "{Blind}^r"
        Send "{Blind}{+}"
        Send "{Blind}{Enter}"
    }

    static inputChineseInDdoubleQuotes()  {
        Send "{Text}`"`""
        Send "{Left}"
        IME.set("中文")
    }

    static changeCnCommentInDoubleQuotes(){
        Send '{Blind}ci"'
        IME.set("中文")
    }

    ; vim micro
    static EditJavaCommentTitle() {
        Send "{Text}{2j2wC"
        Send "{Bind}^{Space}"
    }

    static surroundWithList() {
        Send "{Bind}{Esc}ciw"
        Send "{Text}List<"
        Send '{Bind}^r">'
    }

    static paste2LastLineUp() {
        Send "{Bind}^o"
        Sleep 100
        Send "{Text}P"
    }

    static paste2LastLineDown() {
        Send "{Bind}^o"
        Sleep 100
        Send "{Text}p"
    }

    static paste2LastLineReplace() {
        Send "{Bind}^o"
        Sleep 100
        Send "{Text}Vp"
    }
}
