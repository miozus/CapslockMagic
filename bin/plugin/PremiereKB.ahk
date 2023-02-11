#Hotif WinActive("ahk_exe Adobe Premiere Pro.exe")    ; 窗口内生效，其它环境不生效

CapsLock & a:: prClickPositionAttrAndBack()
^1:: Premiere.prSort(1)
^2:: Premiere.prSort(2)
^3:: Premiere.prSort(3)
^4:: Premiere.prSort(4)
^5:: Premiere.prSort(5)
^6:: Premiere.prSort(6)
^7:: Premiere.prSort(7)
!1:: Premiere.prSort(1, 980, 885, 215)
!2:: Premiere.prSort(2, 980, 885, 215)
!3:: Premiere.prSort(3, 980, 885, 215)
!4:: Premiere.prSort(4, 980, 885, 215)
!5:: Premiere.prSort(5, 980, 885, 215)
!6:: Premiere.prSort(6, 980, 885, 215)
!7:: Premiere.prSort(7, 980, 885, 215)
^!1:: Premiere.prSort(1, , , 215)
^!2:: Premiere.prSort(2, , , 215)
^!3:: Premiere.prSort(3, , , 215)
^!4:: Premiere.prSort(4, , , 215)
^!5:: Premiere.prSort(5, , , 215)
^!6:: Premiere.prSort(6, , , 215)
^!7:: Premiere.prSort(7, , , 215)

#Hotif

class Premiere {

    static prClickPositionAttrAndBack() {
        MouseGetPos &x, &y
        ; 效果控制
        Click "49 105"
        ; 位置
        Click "155 207"
        Sleep 50
        ; 返回按热键时鼠标位置
        Click x y " 0"
    }

    ; prSort(index, x:=875, y:=885, dx:=75, dy:=0) {
    static prSort(index, x := 875, y := 785, dx := 75, dy := 0) {
        posx := "null"
        posy := "null"
        MouseGetPos &FoundX, &FoundY
        if posx == "null" and posy == "null" {
            posx := FoundX
            posy := FoundY
            ; tooltip posx, posy
            ; sleep 1000
        }
        ; 效果控制
        Click "49 105"
        ; 位置
        Click "155 207"
        Sleep 50
        prGetNewPos(index, x, y, dx, dy)
        Click posx posy " 0"
    }

    ; 坐标轴
    static prGetNewPos(index, x, y, dx, dy) {
        Click "527 209"
        x := x + (index - 1) * dx
        tooltip x
        Send x
        Click "577 210"
        y := y + (index - 1) * dy
        Send y
        Send "{Enter}"
        ; 返回按热键时鼠标位置
        Sleep 50
    }

}