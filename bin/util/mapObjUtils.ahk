SendMode "Input"   ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir ; Ensures a consistent starting directory.

;=====================================================================o
;                    MapObj Converter


map2str(mapObj) {
    str := ""
    for key, value in mapObj
        str .= '"' key '", "' value '",`n'
    A_Clipboard := str
    ToolTip "已拷贝至剪切板"
}

map2json(mapObj)
{
    ; https://wtools.io/convert-json-to-plist
    ; 适用于苹果用户词典的中间格式，网站在线转化
    ; 或者调用 json2plist.py 接口自动转化
    ; 也可以直接 map2json，json2xml（python）
    ; 也可以 map2xml（ahk）
    str := ""
    for key, value in mapObj
        str .= 
        (
            '`t{`n'
                '`t`t"phrase": "' value '",`n'
                '`t`t"shortcut": "' key '"`n'
            '`t},`n'
        )
    json := "[ `n" Rtrim(str, ",`n") "`n]"
    ; MsgBox json
    outputAs(json, "userDict.json")
}

map2ini(mapObj)
{
    ; https://wtools.io/convert-json-to-plist
    ; 适用于 QQ 拼音用户词典格式，
    ini := ""
    for key, value in mapObj
        ; 默认候选第 2 位        
        ini .= key "=2," value "`n" 
    ini := Rtrim(ini, ",`n")
    ; MsgBox ini
    outputAs(ini, "自定义短语.ini")
}

json2map(FileName) {
    ; 适用于苹果中间 json 格式转换为AHK字典
    mapObj := Map()
    str := inputFrom(FileName)
    json := StrSplit(str, "},", "[]")
    for chunk in json
    {
        ; 也可自定义修改关键词
        RegExMatch(chunk, '"phrase": "(.*)".\s+"shortcut": "(.*)"', match)
        mapObj[match[2]] := match[1]
    }
    return mapObj
}

ahkMacDict2ShareDir()
{
    ; 调用不要太频繁，每次间隔5秒，因为程序开关或网站会卡会话
    global macDict
    map2json(macDict)
    script := A_ScriptDir "\bin\util\json2plist.py" 
    src_path := A_Clipboard
    dest_path := "F:\Ipad_share\" fileNameAddToday("userMacDict.plist")
    RunWait "python " script " " src_path " " dest_path,,"Min"
    ; 脚本中已将结果保存到系统剪切版本了
    if A_clipboard == "OK"
        MsgBox "已保存在 " dest_path
    else
        ; 报错信息
        MsgBox A_Clipboard
}

