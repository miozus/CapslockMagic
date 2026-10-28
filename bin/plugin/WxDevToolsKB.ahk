#Include impl\WxDevTools.ahk
#Include ..\..\data\Website.ahk

;=====================================================================o
;                    WxDevTools
;---------------------------------------------------------------------o
; 功能 1.粘贴代码，或并选择对应的高亮语言，或追加相对路径作补充说明；
;      2.粘贴折叠块，制作网址收藏，或粘贴报错信息
;=====================================================================o

;=====================================================================o
; 仅限微信开发工具
#Hotif App.WxDevTools.isActive()
CapsLock & 1:: WxDevTools.Base.clearCache()
CapsLock & 2:: WxDevTools.Goods.testEditBookinigSetting()
#Hotif