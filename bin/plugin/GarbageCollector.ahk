SendMode "Input"    ; Recommended for new scripts due to its superior  speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

;=====================================================================o
;                    Windows Garbage
;---------------------------------------------------------------------o
; WindowsOS
#h:: ; 听写，几乎没有麦克风
#c:: ; Cortana，人工智障
#p:: ; 投影屏幕，没有别的屏幕，单机版
#s:: ; 搜索，# 本身已经自带了
#f:: ; 反馈中心，几十年没反馈过问题
#u:: ; 轻松设置中心，一年不用一次
#n:: ; 日历
^#n:: ; 讲述人，不用了
#Pause:: ; 关于本机，一年不用一次
#b:: ; 显示隐藏托盘，用手点击或者win召唤即可，为idea让步
^#f:: ; 搜索本地电脑，没有局域网
#a:: ; 不需要拉出系统控制通知栏了，让位鼠标
^Esc:: ; 弹出开始菜单
!Esc:: ; 切换系统窗口签
!Space:: ; 窗口大小切换
~$<#!r::
{
}
;---------------------------------------------------------------------o
; 屏蔽开始菜单功能，仍保留组合键功能
~LAlt::
~LWin::
{
    SendEvent "{Blind}{vkE8}"
    ; SendEvent "{Blind}{vkE8} Up"
    ; GC.ModifyKeyDocker()
}

;---------------------------------------------------------------------o
; 强化复制、粘贴、保存（Mac ⌘）
<!c::Send "{blind!}^c"
<!v::Send "{blind!}^v"
<!s::Send "{blind!}^s"
<!x::Send "{blind!}^x"
<!z::Send "{blind!}^z"
<!a::Send "{blind!}^a"
;---------------------------------------------------------------------o
; 系统剪切板候选(冒号右边不加空格)
:?cX*:cb1::getClipboard(1)
:?cX*:cb2::getClipboard(2)
:?cX*:cb3::getClipboard(3)
:?cX*:cb4::getClipboard(4)
:?cX*:cb5::getClipboard(5)

getClipboard(index := 1)
{
    index--
    Send "#v"
    Sleep 200
    Send "{Down " index "}{Enter}"
}

;---------------------------------------------------------------------o