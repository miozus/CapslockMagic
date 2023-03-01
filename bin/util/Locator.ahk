; 🧪 开发工具
; ---
; 辅助写代码的集合：取色，取坐标，序列化二维数组（储存数据库）
class Locator {

   static serilize(nestedObj) {
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
        MouseGetPos & x, &y
        msg := x - d ", " y - d ", " x + d ", " y + d ", " PixelGetColor(x, y)
        A_clipboard := "PixelSearch(&FoundX, &FoundY, " msg ", 3)"
        Tooltip msg " 已拷贝"
        SetTimer () => ToolTip(), -2000
    }

    static getMousePosCode() {
        MouseGetPos & x, &y
        msg := x " " y
        ; A_clipboard := 'Click "' msg '"'
        A_clipboard := 'Click "' msg '"'
        Tooltip msg " 已拷贝"
        SetTimer () => ToolTip(), -2000
    }
    
}
