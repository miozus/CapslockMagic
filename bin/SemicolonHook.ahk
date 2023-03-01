#Include MonkeyIME.ahk
#Include SystemIME.ahk
#Include plugin\impl\GarbageCollector.ahk

#Hotif EnableSemicolonComfort
+A:: Send "{Blind}{text}●"    ; 分点论述的符号
*A:: Send "{blind}*"
*I:: Send "{blind}:"
*,:: Send "{blind}{space}"    ; 因为空格键经常误触换行
+V:: Send "{blind}{text}、"    ; 中文顿号
*V:: Send "{blind}|"    ; or
*Y:: Send "{blind}@"
*D:: Send "{blind}="    ; 逻辑判断
+S:: Send "{Blind}{text}○"    ; 分点论述二级符号
*S:: Send "{blind}<"
*F:: Send "{blind}>"
*R:: Send "{blind}&"    ; and
+G:: Send GC.ModifyKey()    ; 解除占用修饰键
*G:: Send "{blind}{!}"    ; not
*X:: Send "{blind}_"    ; 下划线
*H:: Send "{blind}`%"    ; 匹配成对的括号
+Q:: Send "{blind})"    ; 强迫症表示要放一起
*Q:: Send "{blind}("
*U:: Send "{blind}$"    ; 句子后
*E:: Send "{blind}{^}"    ; 句子前，上中左右
+J:: Send "{blind}{text}；"    ; 中文分号，大人什么都要
*J:: Send "{blind}{text};"    ; 英文分号，被自动补全替代
*C:: Send "{blind}."    ; 存疑，一个身位可以到达，设置2个键，过度设计？.=, copy复用上次操作
+B:: Send "{blind}{}}"    ; 成对在一起
*B:: Send "{blind}{{}"    ; viB,viq配合很好
*K:: Send "{blind}``"    ; 精准定位时
*L:: Send "{blind}`""    ; 字符串, 寄存器
*W:: Send "{blind}{#}"
*N:: Send "{blind}-"    ; new/新增/增加
*M:: Send "{blind}{+}"    ; minus/减少
+T:: Send "{blind!+}{Space 4}"    ; 类似 tab
*T:: Send "{blind}~"    ; 终端用户根目录
*Z:: Send "{blind}^z"    ; 撤回，相当于删字
*Space:: send "{blind}{enter}"
*O:: IME.toggle()    ; 终端可用 Esc 切换回英文，任意场合用 Rshift 切换，或再按一遍
*1:: IME.commentCN("//")
*2:: IME.commentCN(";")
*3:: IME.commentCN("###")
#Hotif


;=====================================================================o
;                      Semicolon Hook Registry
global EnableSemicolonComfort := false
; 词典数据 /data/dict
semicolonHookStr := getKeyStr(secretDict) "," getKeyStr(userDict)
semicolonHook := InputHook("C", "{Space}{Esc}", semicolonHookStr)
semicolonHook.OnChar := onTypoChar
semicolonHook.OnEnd := onTypoEnd

+`;:: Send "{blind}:"
*`;::
{
    global semicolonHook, EnableSemicolonComfort
    thisHotkey := A_ThisHotkey
    GC.disableOtherHotkey(thisHotkey)
    EnableSemicolonComfort := true
    KeyWait ";"
    EnableSemicolonComfort := false
    if (A_PriorKey == ";" && A_TimeSinceThisHotkey < 250)
    {
        MonkeyIME.enterSemicolonAbbr(semicolonHook)
    }
    GC.enableOtherHotkey(thisHotkey)
}

; 删除缓存拼写时，也不会更新
onTypoChar(ih, char) {
    Tooltip ih.Input
}

; 清空缓存，可能遮蔽表现：有时新命令遗留错误上次错误信息
onTypoEnd(ih) {
    Tooltip
    ; typoTip.show(ih.Input)
}

getKeyStr(dict) {
    string := ""
    for key, value in dict
    {
        string .= key ","
    }
    return RTrim(string, ",")
}