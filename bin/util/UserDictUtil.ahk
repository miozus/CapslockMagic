; 读写文件
#Include FilePipe.ahk

; 支持导出的用户词典枚举类
; ---
; - MAC
; - JSON
; - PINYIN
class DictTypeEnum {
    static MAC    := {name: "userdict4mac",    suffix: ".plist"}
    static JSON   := {name: "userdict4mac",    suffix: ".json"}
    static PINYIN := {name: "userdict4pinyin", suffix: ".ini"}
}

; 猴子输入法词典转换工具
class Converter {
    
    ; 导出猴子输入法词典到第三方输入法 \
    ; args: 
    ; - source：用户词典词库，如 macDcit 
    ; - target：导出的文件名称，只支持枚举类，如 DictTypeEnum.MAC/PINYIN/JSON
    ; 文件生成在 ./dist/ 目录下
    static convert(source, target) {
        try {
            switch target.suffix  {
                case ".plist": result := DictUtil.toMacUserDictAsPlist(source)
                case ".ini": result := DictUtil.toPinYinAsIni(source)
                case ".json": result := DictUtil.toJson(source)
                default:
                    return
            }
        } catch Error {
            msgbox "
                (
                    convert 函数第二个参数
                    请使用类似 DictTypeEnum.MAC 这样格式
                )"
            return
        }
        filename :=  target.name target.suffix 
        FilePipe.outputAs(result, filename)
    }

    ; 解析第三方词库，储存为猴子输入法词库 \
    ; 用法（二选一）:
    ; - 手动选择文件 
    ;   Converter.parse()
    ; - 文件名的全路径，或当前目录的相对路径 \
    ;   fileDir := "./dist/拼音自定义短语.ini" \
    ;   Converter.parse(fileDir)
    static parse(source:="") {
        suffix := ""
        if (source==""){
            source := FileSelect(3, , "打开文件", "支持类型 (*.ini; *.plist; *.json)")
            if source = ""
                MsgBox "请选择一个文件"
        } 
        suffix := "." StrSplit(source, ".")[-1]
        switch suffix {
            case ".plist": result := DictUtil.parsePlist(source)
            case ".ini": result := DictUtil.parseIni(source)
            case ".json": result := DictUtil.parseMacJson(source)
            default:
                msgbox suffix, "不支持的类型" 
                return
        }
        FilePipe.outputAs(result, "userdict4mapobj.ahk")
    }
}

; 词典转换工具：合并多个词典 、转换输入法词库。使用 mapObj 作为数据结构。
class DictUtil {

    ; 不允许实例化，因为工具类使用类名.方法调用更优雅
    __New(p*) {
        return false
    }
    
    ; 合并多个词典
    static concat(mapList)
    {
        resultMap := Map()
        for dict in mapList
        {
            for key, value in dict
            {
                resultMap[key] := value
            }
        }
        return resultMap
    }

    ; 苹果系统用户词典.plist
    ; 可用苹果终端自带工具校验语法错误 `pluitl -lint your_file.plist`
    static toMacUserDictAsPlist(mapObj)
    {
        statement_start := "
        (
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
                <array>`r
        )"
        dict := ""
        for key, value in mapObj
            dict .= 
            (
                '`t`t<dict>`n'
                    '`t`t`t<key>phrase</key>`n'
                    '`t`t`t<string>' StrUtil.formatAsPlist(value) '</string>`n'
                    '`t`t`t<key>shortcut</key>`n'
                    '`t`t`t<string>' key '</string>`n'
                '`t`t</dict>`n'
            )
        statement_end := "
        (
            `t</array>
            </plist>
        )"
        ; msgbox dict, "dict"
        return statement_start dict statement_end
    }


    ; 拼音用户词典.ini
    ; 搜狗拼音：https://pinyin.sogou.com/help.php?list=1&q=9
    ; 搜狗拼音换行：https://www.zhihu.com/question/68309307/answer/2042299832
    ; QQ拼音：https://jingyan.baidu.com/article/ca41422ff8a01d5fae99ed94.html
    static toPinYinAsIni(mapObj)
    {
        ini := ""
        for key, value in mapObj
            ; 默认候选第 2 位        
            ini .= key "=2," StrUtil.formatAsIni(value) "`n" 
        ini := Rtrim(ini, ",`n")
        ; MsgBox ini
        return ini
    }

    ; 可将其他文件通过 map 作为中间件，持久化储存到 .ahk 文件中
    static toString(mapObj) {
        str := ""
        for key, value in mapObj
            str .= '`t"' key '", "' value '",`n'
        ; A_Clipboard := str
        ; ToolTip "已拷贝至剪切板，可粘贴到词典中保存"
        return str
    }
    
    static toMapString(mapObj) {
        if (mapObj.Count == 0) {
            return
        }
        newUserDict := (
            'newUserDict := Map(`r'
            this.toString(mapObj)
            ')'
        )
        return newUserDict
    }

    ; 适用于苹果用户词典的中间格式，网站在线转化
    static toJson(mapObj)
    {
        ; https://wtools.io/convert-json-to-plist
        ; 或者调用 json2plist.py 接口自动转化（需联外网）
        str := ""
        for key, value in mapObj
            str .= 
            (
                '`t{`n'
                    '`t`t"phrase": "' StrUtil.formatAsJson(value) '",`n'
                    '`t`t"shortcut": "' key '"`n'
                '`t},`n'
            )
        json := "[ `n" Rtrim(str, ",`n") "`n]"
        ; MsgBox json
        return json
    }

    ; ini -> mapObj
    ; args: 第三方输入法转换为 ahk 识别的词典
    ;
    ; key=rank,value
    ;
    ; 文件中需删除单独一行的诸如 [section]
    static parseIni(FileName) {
        str := FilePipe.inputFrom(FileName)
        ini := StrSplit(str, "`n")
        mapObj := Map()
        tempKey := ""
        for chunk in ini
        {
            isOneLine := RegExMatch(chunk, '(.*)=\d+,(.*)', &match)
            if (isOneLine) {
                tempKey := match[1]
                mapObj[tempKey] := StrUtil.formatAsMap(match[2])
            } else {
                multiLineStr := mapObj[tempKey] '``r' chunk
                mapObj[tempKey] := multiLineStr
            }
        }
        return this.toMapString(mapObj)
    }

    ; ini -> mapObj
    ; args: 适用于苹果用户中间 json 结构如下
    ; 
    ; [{
    ;   "pharase": "key",
    ;   "shorcut": "value"    
    ; }]
    ;
    static parseMacJson(FileName) {
        str := FilePipe.inputFrom(FileName)
        json := StrSplit(str, "},", "[]")
        mapObj := Map()
        for chunk in json
        {
            execute := RegExMatch(chunk, '"phrase": "(.*)".\s+"shortcut": "(.*)"', &match)
            if(execute){
                mapObj[match[2]] := StrUtil.formatAsMap(match[1])
            }
        }
        return this.toMapString(mapObj)
    }

    ; plist -> mapObj
    ; <dict>
    ;     <key>phrase</key>
    ;     <string>value</string>
    ;     <key>shortcut</key>
    ;     <string>key</string>
    ; </dict>
    static parsePlist(FileName) {
        str := FilePipe.inputFrom(FileName)
        plist := StrSplit(str, "</dict>")
        mapObj := Map()
        for chunk in plist {
            execute := RegExMatch(chunk, 's)<string>(.*)</string>.*<string>(.*)</string>', &match)
            if (execute){
                mapObj[match[2]] := StrUtil.formatAsMap(match[1])
            } 
        }
        return this.toMapString(mapObj)
    }

}

; 字符串工具：不同文件转义字符的替换
class StrUtil {

    static formatAsPlist(value){
        value := StrReplace(value, "<", "&lt;")
        value := StrReplace(value, ">", "&gt;")
        value := RegExReplace(value, "[`r`n]", "&#13;") 
        return value
    }

    static formatAsJson(value){
        value := StrReplace(value, "`"", '\"')
        value := RegExReplace(value, "[`r`n]", "\n") 
        return value
    }

    static formatAsIni(value){
        value := StrReplace(value, ";", "\;")
        return value
    }

    static formatAsMap(value) {
        value := StrReplace(value, "&lt;", "<")
        value := StrReplace(value, "&gt;", ">")
        value := StrReplace(value, "&#13;", "``r") 
        value := StrReplace(value, "\;", "``;")
        value := StrReplace(value, "\`"", '"')
        value := RegExReplace(value, "[``]?;", "``;")
        return value
    }

}
