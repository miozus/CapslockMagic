;=====================================================================o
;
;
;  ▄████▄   ▄▄▄       ██▓███    ██████  ██▓     ▒█████   ▄████▄   ██ ▄█▀
; ▒██▀ ▀█  ▒████▄    ▓██░  ██▒▒██    ▒ ▓██▒    ▒██▒  ██▒▒██▀ ▀█   ██▄█▒
; ▒▓█    ▄ ▒██  ▀█▄  ▓██░ ██▓▒░ ▓██▄   ▒██░    ▒██░  ██▒▒▓█    ▄ ▓███▄░
; ▒▓▓▄ ▄██▒░██▄▄▄▄██ ▒██▄█▓▒ ▒  ▒   ██▒▒██░    ▒██   ██░▒▓▓▄ ▄██▒▓██ █▄
; ▒ ▓███▀ ░ ▓█   ▓██▒▒██▒ ░  ░▒██████▒▒░██████▒░ ████▓▒░▒ ▓███▀ ░▒██▒ █▄
; ░ ░▒ ▒  ░ ▒▒   ▓▒█░▒▓▒░ ░  ░▒ ▒▓▒ ▒ ░░ ▒░▓  ░░ ▒░▒░▒░ ░ ░▒ ▒  ░▒ ▒▒ ▓▒
;   ░  ▒     ▒   ▒▒ ░░▒ ░     ░ ░▒  ░ ░░ ░ ▒  ░  ░ ▒ ▒░   ░  ▒   ░ ░▒ ▒░
; ░          ░   ▒   ░░       ░  ░  ░    ░ ░   ░ ░ ░ ▒  ░        ░ ░░ ░
; ░ ░            ░  ░               ░      ░  ░    ░ ░  ░ ░      ░  ░
; ░                                                     ░
;
;                                                        Author: miozus
;                                       AHK version: thqby/AutoHotkey_H




;=====================================================================o
;                       CapsLock Global Setting
;
; 我的键盘布局 (HHKB ¯‗¯‗‗‗) ，其实任意键盘都兼容适配
;
; ,-----------------------------------------------------------.
; |Esc|  1|  2|  3|  4|  5|  6|  7|  8|  9|  0|  -|  =| \| `  |
; |-----------------------------------------------------------|
; |Tab  |  Q|  W|  E|  R|  T|  Y|  U|  I|  O|  P|  [|  ]|BackS|
; |-----------------------------------------------------------|
; |Caps  |  A|  S|  D|  F|  G|  H|  J|  K|  L|  ;|  '| Return |
; |-----------------------------------------------------------|
; |Shift   |  Z|  X|  C|  V|  B|  N|  M|  ,|  .|  /|Shift |Fn |
; |-----------------------------------------------------------|
; |    |Alt |Ctrl  |         Space         |Win  |Alt |       |
; `-----------------------------------------------------------'
;
;
SendMode "Input"             ; 速度快
SetWorkingDir A_ScriptDir    ; 当前脚本目录，就是脚本运行目录
InstallKeybdHook             ; 无条件安装键盘钩子,防止丢失
DetectHiddenWindows True     ; 虚拟桌面：打开检测隐藏窗口，自动跳转桌面
;
; 全局配置开始 =============
;
; 鼠标移速
global kMouseMoveSpeedFast := 97
global kMouseMoveSpeedSlow := 11
; 用户正在使用的中文输入法类型
; ---
; - WETYPE          微信输入法(推荐)
; - MICROSOFT       微软拼音(Win11+)
; - MICROSOFT_EARLY 微软拼音
; - SOU_GOU_WU_BI   搜狗五笔
; - SOU_GOU_PIN_YIN 搜狗拼音
; - SHOU_XIN        手心输入法
; - QQ_PIN_YIN      QQ拼音
; - OTHER           其他（需要你调试）
global kImeType := PinYinEnum.WETYPE

;=====================================================================o
;                       CapsLock init
; 托盘图标
TrayIcon.init()

; 热键钩子注册中心
allHotkeys := []
allHotkeys.Push("*;")
allHotkeys.Push("*3")
allHotkeys.Push("*4")

; 用户数据 ============================
#Include data\UserDictionary.ahk
#Include data\Application.ahk
#Include data\Website.ahk
; 公共组件 ============================
#Include bin\common\Common.ahk
#Include bin\util\TrayIcon.ahk
#Include bin\util\Timer.ahk
#Include bin\util\Dotfiles.ahk
#Include bin\util\Locator.ahk
#Include bin\util\Vim.ahk
#Include bin\util\UI.ahk
#Include bin\util\SoundVolume.ahk
; 增强插件 ============================
#Include bin\CapsLockEnhancement.ahk
#Include bin\Numpad.ahk
#Include bin\Mouse.ahk
#Include bin\Navigator.ahk
#Include bin\SemicolonHook.ahk
#Include bin\Window.ahk
#Include bin\Apps.ahk
; 拓展键盘 ============================
#Include bin\plugin\DebugKB.ahk
#Include bin\plugin\GarbageKB.ahk
#Include bin\plugin\NotionKB.ahk
#Include bin\plugin\IDEKB.ahk
#Include bin\plugin\FigmaKB.ahk

; 全局配置结束 ===========

; y = why | reload script 脚本暂停标记，至少留一组快捷键控制脚本重启，激活最新改动版本
#SuspendExempt

CapsLock & y:: Reload
