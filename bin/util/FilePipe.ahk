class FilePipe {


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
