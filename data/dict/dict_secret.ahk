; 二级密令：可执行的代码片段，相当于注册中心，翻译命令的含义(不注册，不生效)
global secretDict := Map(
    "ee", "置顶与否",
    "quit", "关闭程序",
    "dx", "下载",
    "oo", "输入法",
    "no", "记事本",
    "ow", "文档",
    "opc", "图片",
    "or", "回收站",
    "os", "脚本目录",
    "tm", "任务管理器",
    "spy", "查看控件",
    "dotb", "备份配置",
    "doto", "打开配置",
    "rex", "重启资源管理器",
    "sleep", "睡眠",
    "shutdown", "关机",
    "reboot", "重启",
    "dt", "时间戳",
    "gcam", "提交代码",
    "hey", "Jude~",
    "dh", "上个桌面",
    "dl", "下个桌面",
    "mm", "鼠标禅模式",
    "1", "粘贴1",
    "2", "粘贴2",
    "3", "粘贴3",
    "4", "粘贴4",
    "5", "粘贴5",
    "cc", "标题注释",
    "il", "中文字符",
    "cil", "改中文字符",
    "list", "环绕列表",
    "tt", "",
    "bb", "",
    "vsa", "",
    "dota", "加载配置",
    ; Idea Action
    "ln", "",
    "lj", "",
    "lo", "",
    "lz", "",
    "lf", "",
    "le", "",
    "la", "",
    "ls", "",
    "lgh", "",
    "lb", "",
    "ldd", "",
    "lrr", "",
    ; website
    "syl", "登录门户",
    "syd", "本地开发",
    "sya", "协同云",
    "docs", "腾讯文档",
    "gpt", "ChatGpt",
    "gen", "工具箱",
    "json", "excel2json",
    "eco", "易协同",
    "devst", "开始编程",
    "devex", "结束编程",
    "gmst", "开始游戏",
    "gmex", "结束游戏",
    "dd", "隐藏状态栏",
    "ww", "微信",
    "ca", "清空日志",
    ; logger
    "lgi", "",
    "lgg", "",
    "roui", "换UI",
    "syk", "开发日志",
    "test", "提交表单",
    "ms", "光标坐标",
    "px", "取色坐标",
    ; sound
    "sound", "声音设备",
    "mute", "音量",
    "mic", "麦克风",
    ; vue2
    "vi", "import",
    "vm", "methods",
    "vs", "style",
    "vd", "data",
    "vv", "view",
    ; 快速命令
    "re", "快速命令",
)