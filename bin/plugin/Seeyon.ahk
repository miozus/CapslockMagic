SendMode "Input"
SetWorkingDir A_ScriptDir

; 适用版本： A8+ 协同云

; 获取鼠标所在颜色
; !9:: DevUtils.getPixelSearchCode()
; 获取鼠标所在坐标
; !0:: DevUtils.getMousePosCode()

#HotIf Seeyon.hasFormDesigner()
XButton2:: TamperButton.merge()
XButton1:: TamperButton.split()
^b:: ButtonArea.click(ButtonAreaEnum.FONT.border)
^g:: ButtonArea.click(ButtonAreaEnum.CELL.background)
^1:: ButtonArea.click(ButtonAreaEnum.ALIGN.vertical.center)
^x:: ButtonArea.click(ButtonAreaEnum.EDIT.cut)
^e:: RightBar.editColumnNameBack()
^a:: Canvas.selectLine()
^s:: Material.setProperty("→")
^t:: Material.setProperty("↓")
^+s:: Material.clickSaveBtn()
!e:: LeftBar.chooseUp()
!d:: LeftBar.chooseDown()
!r:: LeftBar.deleteField() ; recycle
!f:: Material.loadConfig()
^2:: Layout.setTable()
; alt + c a 似乎都失效了
CapsLock & b:: Material.setTagRow()
CapsLock & c:: Material.setControl()
CapsLock & x:: Send "{Blind}{Backspace}"
#HotIf

; 致远 OA
class Seeyon {

    static hasFormDesigner() {
        return WinActive("表单设计器 - Google Chrome")
    }

    static activeFormDesigner() {
        ActivateOrRun("表单设计器 - Google Chrome")
    }

    ; 登录门户网站
    static login() {
        Run "http://oa.elian.tech"
    }
    
    ; 本地开发环境
    static dev() {
        Run "http://localhost:8848"
    }
    
    ; 协同云
    static app() {
        Run "https://dcc.seeyon.com/#/workbench/main/app/myApp"
    }

    ; 整行选择 （底色）
    
    static chuXiongLogin() {
        Send "{Text} ssh -Y root@36.147.92.12"
        Send "{Blind}{Enter}"
        Sleep 1000
        Send "{Text}cxyd@2020,7"
        Send "{Blind}{Enter}"
        
    }
}


class DesignerAspect {
        
    static centerEmptyCell := "630 255"

    static awakeBtnArea(self, func, param*) {
        ; emptyCell := "287 237"
        ; Click emptyCell
        Click this.centerEmptyCell
        Sleep 50
        func(self, param*)
        Send "{Blind!+^}^z^z"
    }

}

; 团队约定风格
class CSS {
    ; 视图表格 [行 x 列]
    ; 1  : LOGO
    ; 2-3: 标题，左右各空4列
    ; 4  : 空行
    ; n  : 自定义添加，两端至少保留1列
    static tableDescription := [4, 28]
    ; 单元格
    static backgroundColor := Colors.pool.middle
    static fontSizeTitle := 32
    static fontSizeContent := 16
    static fontBorder := true
    static divingHeight := 10
    ; 分隔线
    static fontSizeDiving := 18
    ; 控件
    static controlTitle := ButtonAreaEnum.CONTROL.title.no
    static controlBorderRow := ButtonAreaEnum.CONTROL.border.bottom
    static controlBorderCol := ButtonAreaEnum.CONTROL.border.no
    ; 标签
    static tagAlignRow := ButtonAreaEnum.ALIGN.vertical.right
    static tagAlignCol := ButtonAreaEnum.ALIGN.vertical.center
    static tagColor := Colors.dark.default

}

; 简约设计风格
; @param Tag 画布自定义文本标签
; @param Control 控件
; 制作成配置类，每次约定后，共用标准
class Material {

    ; 初始化风格：字体颜色/背景色等
    static loadConfig() {
        ButtonArea.setTagColor(CSS.tagColor)
        ButtonArea.setBackgroundColor(CSS.backgroundColor)
    }

    static setProperty(direction) {
        MouseGetPos &x, &y
        ; switch direction {
            ; case "→":
                ; ButtonArea.setColor(CSS.tagColor)
                ; Sleep 50
                ; ButtonArea.click(CSS.tagAlignRow)
            ; case "↓":
                ; ButtonArea.click(ButtonAreaEnum.FONT.color)
                ; Sleep 50
                ; ButtonArea.click(CSS.tagAlignCol)
            ; default:
                ; return false
        ; }
        RightBar.copyProperty(x, y, direction)
        Sleep 250
        ; this.setControl()
        Click x " " y " 0"
    }
    
    static setControl() {
        ButtonArea.click(CSS.controlTitle)
        Sleep 50
        ; TODO::砍掉这个功能，因为左侧批量选择和对齐更快
        ButtonArea.click(CSS.controlBorderRow)
    }
    

    static clickSaveBtn() {
        saveBtn := "1290 81"
        Click saveBtn
        Alert.ensure()
    }
    
    ; 切面
    static __New() {

        t1 := this.loadConfig
        t2 := this.clickSaveBtn

        ; 内层切面
        this.DefineProp('loadConfig', {
            call: (self, args*) => 
                DesignerAspect.awakeBtnArea(self, t1, args*)
        })
        ; 外层切面: 对同一个函数嵌套切，不能合并写，定义属性是一次性的
        this.DefineProp('loadConfig', {
            call: (self, args*) =>
                MouseAspect.comeback(self, t1, args*)
        })

        this.DefineProp('clickSaveBtn', {
            call: (self, args*) =>
            MouseAspect.comeback(self, t2, args*)
        })

    }
}

; 六进制颜色，必须 # 开头，需要时再添加，不用的不要添加进来
class Colors {

    static dark := {
        default : "#000000"
    }

    static gray := {
        middle : "#999999",
    }
    
    static blue := {
        middle : "#86B8E1",
    }
    
    static pool := {
        middle : "#00D5FF",
    }
}

class Layout {
    
    static setTable() {
        ; this.drag2bottom()
        this.inputArgs(CSS.tableDescription)
    }
    
    static drag2bottom() {
        layoutBtn := "44 163"
        tableBtn := [ 106, 405 ]
        bottomArea := [ 583, 698 ] 
        Click layoutBtn
        Click tableBtn[1] " " tableBtn[2]
        Sleep 550
        MouseClickDrag "Left", tableBtn[1], tableBtn[2], bottomArea[1], bottomArea[2], 50
    }
    
    static inputArgs(tuple) {
        Send "{Blind^!+}^a" 
        Send "{Text}" tuple[1]
        tooltip tuple[1]
        Send "{Blind^!+}{Tab}" 
        ; Send "{Blind}^a" 
        tooltip tuple[2]
        Send "{Text}" tuple[2]
        Alert.ensure()

    }
}

; 右键菜单管理器
; 云设计中心
; 通过鼠标操作单元格
; TODO: 责任链模式，开启菜单才能找到，解耦坐标和点击，动态计算第几个标签
; 相对静止的坐标：查找图片后重新定位，因为菜单总在视图中央
class AppMenu {

    ; 右键菜单第一个坐标 [剪切]
    static x0 := 0
    ; static y0 := 240 ; 1366*766 全屏
    ; static offsetY := 29 
    static offsetY := 43 
    
    static click(index) {
        Click "Right"
        MouseGetPos &x, &y            
        menuX := x + 20
        ; menuY := this.y0 + (index - 1) * this.offsetY
        menuY := y + 18 + (index - 1) * this.offsetY
        ; tooltip menuX " " menuY " 0"
        Click menuX " " menuY
        Click x " " y " 0"
    }

}

; 按钮区域管理器
class ButtonArea {

    ; 左上角菜单栏第一个图标坐标 [全选]
    ; static x0 := 40
    ; static y0 := 130
    static x0 := 58
    static y0 := 194
    ; static offsetX := 40
    static offsetX := 50
    static offsetY := this.offsetX / 2
    static offsetArrowY := 50

    ; 点击第 [i, j] 个按钮
    static click(index) {
        MouseGetPos &x, &y            
        if IsNumber(index) {
            menuX := this.x0 + (index - 1) * this.offsetX
            menuY := this.y0
        } else {
            menuX := this.x0 + (index[1] - 1) * this.offsetX
            Click menuX " " this.y0
            Sleep 30
            menuY := this.y0 + (index[2] - 1) * this.offsetY + this.offsetArrowY
        }
        Click menuX " " menuY
        Click x " " y " 0"
        sleep 1000
    }
    
    static setAlign(enum) {
        ButtonArea.click(ButtonAreaEnum.ALIGN)
    }
    
    
    static setColorInput(hex, x0, y0:=130, inputOffset:=220) {
        Option := x0 " " y0
        Value := x0 " " y0 + inputOffset
        Ensure := x0 - 65 " " y0 + inputOffset 
        Click Option
        Click Value " 3"
        Sleep 50
        Send "{Text}" hex
        Click Ensure
        Sleep 50
    }
    
    static setTagColor(hex) {
        ButtonArea.click(ButtonAreaEnum.FONT.color)
        this.setColorInput(hex, 660)
    }

    static setBackgroundColor(hex) {
        ButtonArea.click(ButtonAreaEnum.CELL.color)
        this.setColorInput(hex, 1075)
    }
    
    static after(self, func, args*) {
        Sleep 50
        func(self, args*)
        ; ButtonArea.click(args*)
        this.setColorInput(args*)
    }
    

    static __New() {
        t1 := this.setTagColor
        this.DefineProp('setTagColor', {
            call: (self, args*) => this.after(self, t1, args*)
        })
        
    }
}


; 画布管理器
class Canvas {

    ; 画布大小
    static selectLine() {
        MouseGetPos &x, &y
        MouseClickDrag "L", Frame.Canvas.xLeft, y, Frame.Canvas.xRight, y
        Click x " " y " 0"
    }
    
}

class Frame {

    ; 页面缩放比例：为了动态计算坐标
    static shrink := 0.9

    ; 画布左右坐标极限（范围内）
    class Canvas {
        static xLeft := 240
        static xRight := 1100
    }
    
    
}

; 左侧菜单栏
class LeftBar {
    
    static offsetY := 35
    static field := "181 165"
    ; 控件
    static control :=  "110 160"

    static deleteField() {
        this.appContext(3)
        Alert.ensure()
    }

    static appContext(index) {
        ; MouseGetPos &x0, &y0
        MouseGetPos &x, &y
        ; PixelSearch(&x, &y, 10, 160, 50, 750, 0x1F85EC, 3)
        Click "Right"
        Sleep 50
        Click x " " y + this.offsetY * (index - 1)
        Click x " " y " 0"
        ; Click x0 " " y0 " 0"
    }

    static hasChoosen() {
        return PixelSearch(&FoundX, &FoundY, 10, 160, 50, 750, 0x1F85EC, 3)
    }
    
    static init() {
        Click this.field
    }
    
    static chooseUp() {
        this.choose(- this.offsetY / 2)
    }

    static chooseDown() {
        this.choose(this.offsetY)
    }

    static choose(offsetY) {
        this.init()
        PixelSearch(&FoundX, &FoundY, 10, 160, 50, 750, 0x1F85EC, 3)
        Click FoundX " " FoundY + offsetY
    }
}

; 右侧菜单栏
class RightBar {

    ; 画布估算两个单元格的间隔距离 px
    static offset := 35
    ; 表单属性
    ; static fieldAttr := "1181 163"
    static fieldAttr := "1882 245"
    ; 数据域名称
    ; static fieldName := "1204 260"
    static fieldName := "1946 370"
    
    static editColumnName() {
        Click this.fieldName
        needle := SubStr(A_Clipboard, -1, 1) 
        Send "{Blind^!}^a"
        Send "{Blind^!}^v"
        if InStr(":：", needle, false, -1) {
            Send "{Blind^!}{BackSpace}"
        }
    }

    static editColumnNameBack() {
        this.editColumnName()
        ; 鼠标回到控件
        Click LeftBar.control " 0"
    }
    

    static copyProperty(x, y, direction) {
        offset := 100
        Click x " " y " 3"
        Send "{Blind^!}^c{Esc}"
        switch direction {
            case "→":
                Click x + offset " " y
            case "↓":
                Click x " " y + offset / 2
            default:
        }
        this.editColumnName()
    }
    
}

class Alert {

    static ensure() {
        Sleep 500
        PixelSearch(&FoundX, &FoundY, 680, 450, 850, 550, 0x1F85EC, 3)
        tooltip FoundX " " FoundY
        if FoundX {
            Click FoundX + 10 " " FoundY + 10
        }
    }
}

; 标题菜单栏
class ButtonAreaEnum {

    ; 复制粘贴
    static EDIT:= {
        selectAll  : 1,
        cut        : 2,
        copy       : 3,
        paste      : 4,
        blank1     : 5 - 0.4,
        undo       : 6 - 0.4,
        redo       : 7 - 0.4,
    }

    ; 字体
    static FONT :=  {
        family     : 9,
        size       : 12,
        border     : 13,
        italy      : 14,
        underly    : 15,
        color      : 16,
    }

    ; 对齐
    static ALIGN := {
        vertical: {
            left  : [18, 1],
            center: [18, 2],
            right : [18, 3],
        },
        horizen : {
            top    : [19, 1],
            center : [19, 1],
            bottom : [19, 1],
        } 
    }
   
    ; 单元格
    static CELL := {
        merge     : 21 + 0.4,
        split     : 22 + 0.4,
        insert    : 23 + 0.4,
        delete    : 24 + 0.4,
        frame     : 25 + 0.4,
        background: 26 + 0.4,
    }

    ; 控件
    static CONTROL := {
        title: {
            abreast   : [29, 1],
            changeLine: [29, 2],
            no        : [29, 3],
        },        
        border: {
            all       : [30, 1],
            bottom    : [30, 2],
            no        : [30, 3],
        }
    }
}

; 一次性暴力解决，不做适配
class TamperButton {

    static mergePos :=  "1280 192"
    static splitPos :=  "1342 190"

    static click(position) {
        MouseGetPos &x, &y            
        ; Click x " " y
        Click position
        Click x " " y " 0"
    }
    
    static merge() {
        this.click(this.mergePos)
    }
    static split() {
        this.click(this.splitPos)
    }
}

; 右键菜单枚举类
; 坐标动态变更，上下浮动区间，尽量少用
class AppMenuEnum {

    ; 每条分割线 -1/2 * offset
    static FUNC := {
        cut         : 1,
        copy        : 2,
        paste       : 3,
        line1       : 4,
        insertUp    : 5,
        insertDown  : 6,
        insertLeft  : 7,
        insertRight : 8,
        insertHead  : 9,
        insertTail  : 10,
        line2       : 11 - 0.5,
        deleteRow   : 12 - 0.5,
        deleteColumn: 13 - 0.5,
        line3       : 14 - 0.5,
        cellMerge   : 15 - 1,
        cellSplit   : 16 - 1,
        line4       : 17 - 1,
        cellWidth   : 18 - 1.5,
        cellHeight  : 19 - 1.5,
        cellBorder  : 20 - 1.5,
    }
}

; Aspect Oritend Program
; 装饰器模式
class MouseAspect {

    ; 鼠标执行操作后返回原处
    static comeback(self, func, param*) {
        MouseGetPos &x, &y
        ; 附加动作，有时为了激活对象
        Click x " " y
        func(self, param*)
        Click x " " y " 0"
    }
}