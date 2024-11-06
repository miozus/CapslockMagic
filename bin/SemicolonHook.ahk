#Include MonkeyIME.ahk
#Include SystemIME.ahk
#Include plugin\impl\GarbageCollector.ahk

#Hotif EnableSemicolonComfort && EnableEnPunctionByWeType
*A:: ensureEnPunctionByWeType "{blind}*"                ; 星号
*I:: ensureEnPunctionByWeType "{blind}:"                ; 插入（Vim）
*V:: ensureEnPunctionByWeType "{blind}|"                ; or
*Y:: ensureEnPunctionByWeType "{blind}@"                ; at
*D:: ensureEnPunctionByWeType "{blind}="                ; 逻辑判断
*S:: ensureEnPunctionByWeType "{blind}<"                ; left
*F:: ensureEnPunctionByWeType "{blind}>"                ; right
*R:: ensureEnPunctionByWeType "{blind}&"                ; and
*G:: ensureEnPunctionByWeType "{blind}{!}"              ; not
*X:: ensureEnPunctionByWeType "{blind}_"                ; 下划线
*H:: ensureEnPunctionByWeType "{blind}`%"               ; 匹配成对的括号
+Q:: ensureEnPunctionByWeType "{blind})"                ; 强迫症表示要放一起
*Q:: ensureEnPunctionByWeType "{blind}("                ; 括号 [k]uo hao
*U:: ensureEnPunctionByWeType "{blind}$"                ; 句子后
*E:: ensureEnPunctionByWeType "{blind}{^}"              ; 句子前，上中左右, up
*J:: ensureEnPunctionByWeType "{blind};"                ; 英文分号，被自动补全替代
*C:: ensureEnPunctionByWeType "{blind}."                ; 1键变2个键是否过度设计？.=, copy复用上次操作，保证输出英文（避免中文影响）
*B:: ensureEnPunctionByWeType "{blind}{{}"              ; 大括号放这里是迷惑的习惯，两个习惯会打架，集合在一个键不如[]左右直观
*K:: ensureEnPunctionByWeType "{blind}``"               ; 精准定位时
*L:: ensureEnPunctionByWeType "{blind}`""               ; 字符串, 寄存器
*W:: ensureEnPunctionByWeType "{blind}{#}"              ; 挖井 [w]a jing
*N:: ensureEnPunctionByWeType "{blind}-"                ; new/新增/增加
*M:: ensureEnPunctionByWeType "{blind}{+}"              ; minus/减少
+T:: ensureEnPunctionByWeType "{blind!+}{Space 4}"      ; 类似 tab
*T:: ensureEnPunctionByWeType "{blind}~"                ; 终端用户根目录
*,:: ensureEnPunctionByWeType "{blind},"                ; 因为空格键经常误触换行
; 特殊：输出w'v
#Hotif


#Hotif EnableSemicolonComfort
*A:: Send "{blind}*"                ; 星号
*I:: Send "{blind}:"                ; 插入（Vim）
*V:: Send "{blind}|"                ; or
*Y:: Send "{blind}@"                ; at
*D:: Send "{blind}="                ; 逻辑判断
*S:: Send "{blind}<"                ; left
*F:: Send "{blind}>"                ; right
*R:: Send "{blind}&"                ; and
*G:: Send "{blind}{!}"              ; not
*X:: Send "{blind}_"                ; 下划线
*H:: Send "{blind}`%"               ; 匹配成对的括号
+Q:: Send "{blind})"                ; 强迫症表示要放一起
*Q:: Send "{blind}("                ; 括号 [k]uo hao
*U:: Send "{blind}$"                ; 句子后
*E:: Send "{blind}{^}"              ; 句子前，上中左右, up
*J:: Send "{blind};"                ; 英文分号，被自动补全替代
*C:: Send "{blind}."                ; 1键变2个键是否过度设计？.=, copy复用上次操作，保证输出英文（避免中文影响）
*B:: Send "{blind}{{}"              ; 大括号放这里是迷惑的习惯，两个习惯会打架，集合在一个键不如[]左右直观
*K:: Send "{blind}``"               ; 精准定位时
*L:: Send "{blind}`""               ; 字符串, 寄存器
*W:: Send "{blind}{#}"              ; 挖井 [w]a jing
*N:: Send "{blind}-"                ; new/新增/增加
*M:: Send "{blind}{+}"              ; minus/减少
+T:: Send "{blind!+}{Space 4}"      ; 类似 tab
*T:: Send "{blind}~"                ; 终端用户根目录
*,:: Send "{blind},"                ; 因为空格键经常误触换行
; 以下中英文模式通用
*Z:: Vim.focusMethod()              ; 光标定位到函数名字（Vim）
!Space:: send "{blind}{Alt}{enter}" ; 表格换行
*Space:: send "{blind}{enter}"      ; 回车，免位移
*O:: IME.toggle()                   ; 终端可用 Esc 切换回英文，任意场合用 Rshift 切换，或再按一遍
*1:: IME.commentCN("//")            ; java 注释
*2:: IME.commentCN(";")             ; ahk 注释
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
    if (A_PriorKey == ";" && A_TimeSinceThisHotkey < 200)
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

; 微信输入法打字前后，临时切换中文标点格式 (因为恶心的微信输入法限制中文模式打不出英文标点)
; 约定大于配置：
; 1.所有窗口全部默认英文标点符号（但是中文审美洁癖）
; 2.输入法默认开启中文标点
; 3.启动快捷键：切换中文标点 Ctrl + .
ensureEnPunctionByWeType(str) {
    ; 因为检测中英文状态发送指令消耗性能，所以求快就不检测
    Send "^."
    Send str
    Send "^."
}