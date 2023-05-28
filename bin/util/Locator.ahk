; 🧪 开发工具
; ---
; 辅助写代码的集合：取色，取坐标，序列化二维数组（储存数据库）
class Locator {

    static serialize(nestedObj) {
        inner := "", outer := ""
        for k1, nested in nestedObj.OwnProps() {
            for k2, v2 in nested.OwnProps() {
                inner .= k2 ':"' v2 '", '
            }
            outer .= k1 ': {' Rtrim(inner, ", ") '},`n'
            inner := ""
        }
        outer := "{`n" Rtrim(outer, ",`n") "`n}"
        A_Clipboard := outer
        msgbox outer, "已拷贝"
        return outer
    }

    static getPixelSearchCode(d := 5) {
        MouseGetPos &x, &y
        params := x - d ", " y - d ", " x + d ", " y + d ", " PixelGetColor(x, y)
        A_clipboard := "PixelSearch(&FoundX, &FoundY, " params ", 3)"
        Tooltip params " 已拷贝"
        SetTimer () => ToolTip(), -2000
    }

    static getMousePositionCode() {
        CoordMode "Mouse", "Window"
        MouseGetPos &x, &y
        params := x " " y
        A_clipboard := 'Click "' params '"'
        Tooltip params " 已拷贝"
        SetTimer () => ToolTip(), -2000
    }

    static getPixelElementCode() {
        MouseGetPos &x, &y
        color := PixelGetColor(x, y)
        params := x ", " y ", " color
        A_clipboard := "Selenium.EC.buttonIs(" params ")"
        Tooltip params " 已拷贝"
        SetTimer () => ToolTip(), -2000
    }

}