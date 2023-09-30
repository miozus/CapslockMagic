#Include Timer.ahk

; 浏览器引擎操作自动化
class Selenium {

    ; Expected Conditions
    class EC {

        ; 屏幕中按钮的中央坐标和颜色，等待出现就点击，最多等待n秒
        static buttonIs(x0, y0, color, timeout := 10)
        {
            ; 随机延迟：它可能加速快
            Loop timeout
            {
                if (PixelSearch(&FoundX, &FoundY, x0 - 100, y0 - 100, x0 + 100, y0 + 100, color, 3)) {
                    Click FoundX + 5, FoundY + 5
                    tooltip
                    return true
                }
                Timer.get8MoonRetation(A_Index)
            }
            tooltip "等待超时"
            SetTimer () => ToolTip(), -2000
            return false

        }

    }
}