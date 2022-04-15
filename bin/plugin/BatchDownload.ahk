SendMode "Input"
SetWorkingDir A_ScriptDir

; 打包下载：循环 100 次（页），每次间隔 30-38 秒（文件增多需要调大参数）
F1::Script.batchDownloadLoop(100, 40)
; 批量点击：翻页 100 页
F2:: Script.batchClick(697)
; 暂停/重启脚本
F3:: Reload
; 获取鼠标所在颜色
F4:: DevUtils.getPixelSearchCode()
; 获取鼠标所在坐标
F5:: DevUtils.getMousePosCode()


; 脚本
class Script {
    
    ; 打包下载脚本，但没完全下载，只为刷新服务器缓存，累加文件路径
    ; 视图缩放 67% 无视底部菜单
    static batchDownloadIncomplete(timeout:=38) {
        static count := 1
        ; 勾选全选
         Click "165 611"
        Sleep 100
        ; 点击打包下载
        Click "386 555"
        tooltip "第" count "个"
        ; 日志写入粘贴板：注意保留开始和结束，便于推算进度
		A_Clipboard := FormatTime(, "yyyy-MM-dd HH:mm:ss") "第" count "个任务开始执行，每次耗时约" timeout "秒" 
        ; 至少 26 秒
        Timer.moonRetation(timeout - 12)
        ; 成功连接服务器，弹出下载，点击选项并取消
        Click "430 1674"
		Sleep 100
        Send "{Blind!^+}{Up}"
        Sleep 100
        Send "{Blind!^+}{Enter}"
		; 点击下一页
        Click "2813 1192"
        Timer.moonRetation(2)
        ; 未刷新出列表时，加时等待
        if !PixelSearch(&FoundX, &FoundY, 2633, 655, 2643, 665, 0xED5565, 5) {
            Timer.moonRetation(8)
        }
        count++
    }

    ; 打包下载脚本
    static batchDownload() {
        static count := 1
        Send "{End}"
        ; 下一页坐标
        Click "1326 621" 
        Sleep 4000
        if !PixelSearch(&FoundX, &FoundY, 1238, 295, 1248, 305, 0xF5F5F5, 3) {
            Sleep 8000
        }
        ; 全选复选框坐标
        Click "106 262" 
        Sleep 100
        ; 打包下载坐标
        Click "246 228" 
        tooltip "第" count "个"
        count++
        Sleep 10000
    }
    
    ; 计划下载 n 页
    static batchDownloadLoop(count, timeout:=38) {
        Loop count {
            this.batchDownloadIncomplete(timeout)
        }
		ToolTip "已经完成" count "个任务 " FormatTime(, "yyyy-MM-dd HH:mm:ss")
    }
    
    ; 连续点击 n 下：如果网络异常，可以快速翻页
    static batchClick(count) {
        i := 1
        Loop count {
            Click
            Sleep 10
            tooltip i, 0, -20
            i++
        }
        SetTimer () => ToolTip
    }
    
}

;; 动画计时器
;class Timer {
   
;    ; 周期
;    static moonRetation(count) {
;        i := 1
;        Loop count {
;            switch Mod(i, 8) {
;               case 1 : tooltip "🌑"
;               case 2 : tooltip "🌒"
;               case 3 : tooltip "🌓"
;               case 4 : tooltip "🌔"
;               case 5 : tooltip "🌕"
;               case 6 : tooltip "🌖"
;               case 7 : tooltip "🌗"
;               case 0 : tooltip "🌘"
;            }
;            Sleep 1000
;            i++
;        }
;        tooltip
;    }

;    ; 二进制沙漏
;    static hourGlass(count) {
;        i := 1
;        Loop count {
;            if Mod(i, 2) {
;                tooltip "⏳ " i
;            } else {
;                tooltip "⌛ " i
;            }
;            Sleep 1000
;            i++
;        }
;        tooltip
;    }

;}

;; 🧪 开发工具
;; ---
;; 辅助写代码的集合：取色，取坐标，序列化二维数组（储存数据库）
;class DevUtils {

;   static serilize(nestedObj) {
;        inner := "", outer := ""
;        for k1, nested in nestedObj.OwnProps() {
;            for k2, v2 in nested.OwnProps() {
;                inner .= k2 ':"' v2 '", '
;            }
;            outer .= k1 ': {' Rtrim(inner, ", ") '},`n'
;            inner := ""
;        }
;        outer := "{`n" Rtrim(outer, ",`n") "`n}"
;        A_Clipboard := outer
;        msgbox outer, "已拷贝"
;        return outer
;    }

;    static getPixelSearchCode(d := 5) {
;        MouseGetPos & x, &y
;        msg := x - d ", " y - d ", " x + d ", " y + d ", " PixelGetColor(x, y)
;        A_clipboard := "PixelSearch(&FoundX, &FoundY, " msg ", 3)"
;        Tooltip msg " 已拷贝"
;        SetTimer () => ToolTip(), -2000
;    }

;    static getMousePosCode() {
;        MouseGetPos & x, &y
;        msg := x " " y
;        A_clipboard := 'Click "' msg '"'
;        Tooltip msg " 已拷贝"
;        SetTimer () => ToolTip(), -2000
;    }
   
;}
