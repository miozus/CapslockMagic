
SendMode "Input"    ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.


; MICROSOFT_PINYIN 微软拼音/搜狗五笔/手心输入法
; QQ_PINYIN        QQ拼音
; OTHER_PINYIN     搜狗拼音/其他
class ImeTypeEnum {
    static MICROSOFT_PINYIN := {wParam:"0x001", name:"微软拼音/搜狗五笔/手心输入法", value:"Miocrosoft"}
    static QQ_PINYIN := {wParam:"0x005", name:"QQ拼音", value:"QQ"}
    static OTHER_PINYIN := {wParam:"0x005", name:"搜狗拼音/其他", value:"Other"}
}


; 支持导出的用户词典枚举类
class DictTypeEnum {
   static MAC    := {name:"userdict4mac", suffix:".plist"}
   static JSON   := {name: "userdict4mac", suffixt: ".json"}
   static PINYIN := {name: "userdict4pinyin", suffixt: ".ini"}
}
