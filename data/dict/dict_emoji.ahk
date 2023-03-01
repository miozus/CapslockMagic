;  辅助：emoji 表情大全 https://cn.piliapp.com/emoji/list/
emojiDict := Map(
    ; 推荐
    "tj", "👍", ; 推荐
    "btj", "👎", ; 不推荐
    "bg", "🐞", ; bug
    "mty", "🦉", ; 猫头鹰/debug
    "jsq", "🧮", ; 计算器/算盘
    "whlo", "🌐", ; 网络/地球
    ; RESTful
    "dv", "✅",
    "xyhr", "🔄",	; 循环/多次/重复/loop/multiple
    "zrui", "💠",	; 钻石
    "ks", "🈳",
    "wuzi", "🈚",
    ; 步骤/线程 u 数字 + 汉语拼音
    "ulk", "0️⃣",
    "uyi", "1️⃣",	; 线程/Tread1/T1
    "uer", "2️⃣",
    "usj", "3️⃣",
    "usi", "4️⃣",
    "uwu", "5️⃣",
    "ulq", "6️⃣",
    "uqi", "7️⃣",
    "uba", "8️⃣",
    "jnhr", "↔️",
    ; 压力测试
    "tigc", "🆙",	; up/提高
    "lipu", "😱",	; 离谱
    "kulz", "☠",	; 骷髅/压爆了/死锁/deadLock/失效
    ; 速度
    "wugv", "🐢",  ; 乌龟
    "pcbu", "🏃‍♂️",  ; 跑步
    "djie", "🚲",  ; 单车
    "moto", "🏍️",  ; 摩托
    "hoie", "🚚",  ; 货车
    "qiie", "🚗",  ; 汽车
    "gctp", "🚄",  ; 高铁
    "fwji", "✈️",  ; 飞机
    "hojm", "🚀",  ; 火箭
    ; 线程生命周期
    "xkxk", "⭐️",	; 星星/初始/new
    "yyxk", "🟢",	; 运行/runnabele（running+ready）
    "uijm", "⏳",	; 时间/超时等待/timed_waiting
    "zjtk", "⏸️",	; 暂停/等待/wait
    "zuse", "🚧",	; 阻塞/建筑/构造/blocked
    "tkvi", "🔴",	; 停止/终止/terminated
    ; 线程方法
    "kdui", "▶️",	; 开始/播放/继续/start
    "uvjn", "💤",	; 睡觉/sleep/什么也没发生
    "hrxk", "🔔",	; 唤醒/铃铛/notify/notifyAll
    "jxru", "🎉",	; 加入/派对/join
    "jiui", "⏱️",	; 计时/计时器/timer
    "gsyr", "⛲",	; 公园/喷泉/park
    ; 缓存
    "hrcy", "🥏",   ; 缓存/飞盘
    "xlzi", "📦",	; 缓存中心/cache
    "yzlk", "👻",	; 缓存穿透
    "xthx", "❄",	; 缓存雪崩
    "mubn", "🎯",	; 缓存击穿/目标
    "jnyb", "👣",	; 痕迹
    "uuid", "🧬",	; UUID/身份证/唯一/独占
    ; 锁
    "yrzi", "⚛️",	; 原子/原子操作/AtomicOperation
    "jxso", "🔒",	; 加锁/lock
    "jpso", "🔓",	; 解锁/unlock
    "ycui", "🗝️",	; 钥匙/当前掌握资源者/key
    "mifj", "🍚",	; 米饭/防饿死
    "kjmf", "🐕",	; 看门/看门狗/WatchDog
    "xnxi", "💬",	; 消息/读取/ReadWriteLock
    "xpzi", "✍🏻",	; 写字/写入/ReadWriteLock
    "isru", "💳",	; 重入/通行证/可重入/信用/ReEntrantLock
    "biso", "🚪",	; 闭门/闭锁/CountDownLatch
    "xbhc", "📶",	; 信号/信号量/semaphore
    "tsbu", "👥",	; 同步/影子/双人像/一致/双胞胎/synchronized
    "jmui", "🖥️",	; 监视/显示器/monitor
    "zixr", "🌀",	; 自旋/台风/spin
    "legr", "🤣",	; 乐观/笑得满地打滚/optimisticLock
    "bwgr", "😭",	; 悲观/大哭/depressiveLock
    "vsdr", "🔌",	; 中断/电源插头/lockInterruptibly
    "glbo", "📡",	; 广播/选择性通知/卫星天线
    "gspk", "⚖️",	; 公平/fair
    "jkvg", "⚔️",	; 竞争/互斥/conflict/mutex
    "pbtu", "🧩",	; 拼图
    "memo", "📝",	; memory/备忘录
    "iexn", "◀️",	; 撤销/返回
    "gria", "🔭",	; 观察/哨兵/望远镜
    "yiiu", "🌊",	; 溢出/OOM
    "kkvc", "📸",	; 快照/quickshot
    "qppm", "✂️",	; 切片/剪刀
    ; 缓存一致性
    "ulxp", "👥",	; 双写/双人影
    "yshu", "👤", ; 用户/匿名/人像
    ; 排序
    "pdxu", "📊",	; 排序
    "mcpc", "💭",	; 冒泡: 强调相邻关系，越小的元素会经由交换，慢慢 “浮” 到数列的顶端。
    "xrze", "🔘",	; 选择: 强调极限聚集，将极限值，经由交换，传送聚集到一端
    "iaru", "🔌",	; 插入：强调内部秩序，检验每个新成员，归入我方阵营
    "gvbk", "🙏",	; 归并: 强调左右自治，区分左右小组，各取其长，只要小组完成排序，大组也能完成排序
    "kksu", "🚀",	; 快速：强调轴心分区，return quicksort(less) + [pivot] + quicksort(greater)
    "jiuu1", "🧱",	; 基数
    "svji", "🃏",	; 随机
    "jiuu2", "🔢",	; 计数
    "ejv", "🔟",	; 二进制
    ; 数据结构
    "eiu", "🌲",	; 二叉树/BinaryTree
    "zyz", "🍂",	; 左子树/leftTree
    "yyz", "🍃",	; 右子树/rightTree
    "dzya", "🌱",	; 定义/函数定义/豆芽/查看详情/define/function
    "lmbn", "🔗",	; 链表
    "dsgv", "🌀", ; 动态规划/动规/斐波那契数列/状态转移方程
    "dpuz", "👾", ; dp 数组/养蛊/最值进化
    "pddv", "📶",  ; 排队/队列/信号/Queue
    "jihe", "📕", ; 集合/新华字典/字典/映射/Map
    ; 物理
    "qiti", "🌫",
    "yeti", "💧",
    "guti", "🧊",
    ; 其他
    "xibc", "🧫",   ; 细胞
    "ulyj", "👀",	; 双眼/observe
    "yjjk", "👓",   ; 眼镜/查看
    "fhda", "🔍",   ; 放大
    "redm", "🔥",	; 热点/火焰/Hotspot
    "bcjk", "🚨",	; 报警/警示灯/alert
    "jkxl", "🪞",	; 镜像/镜子/mirrow
    "vinj", "🧭",	; 指南/指南针
    "ykbi", "🪙",	; 硬币/coin
    "ncvs", "⏰",	; 闹钟
    "error", "❌",
    "wwvi", "❓",
    "wwxm", "🚧",
    "up", "👆",
    "down", "👇",
    "tiui", "💡",
    "iily", "⚙️",
    "ceui", "🧪",
    "zojm", "🖱️",
    "yzjm", "⚙️",
    "yzxi", "🎮",
    "jxyr", "🛖",
    "tpgc", "⛏️", ; 铁镐
    "qizi", "🪛", ; 起子
    "bwbc", "🎒", ; 背包
    "xluh", "↑",
    "xlxx", "↓",
    "xlzo", "←",
    "xlyz", "→",
    "jmpj", "⌨️",
    "uhgy", "⏫",
    "xxgy", "⏬",
    "gyly", "🖲️",
    "tizi", "🪜",
    "rukz", "🌱",
    "tuzi", "🐰",
    "fass", "📨",
    "ssda", "📥",
    "tijn", "📤",
    "bndj", "📃", ; 表单/页面对象/
    "erdo", "👂",
    "vifu", "💴",
    "xbys", "💳",
    "jbbi", "🪙",
    "qmdd", "💰",
    "hsbc", "🧧",
    "rivi", "📒",
    "tixk", "🔔", ; 提醒/remind
    "wjju", "🧸",
    "star", "⭐", ; 星星
    "anli", "🌰", ; 案例/例子/栗子/抽象通用案例
    "rsdr", "🌋", ; 熔断/火山/具体案例
    "xtbg", "🏔️", ; 雪崩/雪山
    "xmlq", "🚧", ; 限流/路障 
    "hwds", "🕳️", ; 黑洞/hole
    "jlji", "🍱", ; 降级/盒饭安慰
    ; MySQL
    "uiwu", "💼", ; 事务/公文包
    "hvfu", "⚕️", ; 恢复/医疗/回档/回滚/治疗
    "anqr", "🛡️", ; 安全/盾牌
    "yivi", "👥", ; 一致
    "geli", "🧫", ; 隔离
    "iijq", "💾", ; 持久
    "soyb", "🐬", ; MySQL/数据库/索引
    ; 设计模式
    "gsih", "🏭", ; 工厂
    "djli", "🧬", ; 单例
    "yrxk", "🤖", ; 原型/克隆
    "uipw", "🔌", ; 适配
    "vlui", "🎊", ; 装饰/包装
    "mobj", "🛹", ; 模板/滑板
    "ddli", "🧛", ; 代理/吸血鬼
    "ioc", "👆", ; 控制反转
    "di", "🤸", ; 依赖注入/倒置
    "qnjp", "🌉", ; 桥接/AOP
    "jiig", "👶", ; 继承/宝宝/孙子
    ; JVM
    "qiqq", "🎈", ; 堆球/栈线（两字神似）
    "fjue", "🪞", ; 反射
    "new", "🆕", ; 新
    ; 基础服务
    "wfjm", "📁", ; 文件/FTP
    "bjgs", "💼 ", ; 办公/公文包/OA 
    ; 时间
    "ualz", "⏳", ; 沙漏/倒计时/ttl
    "uuju", "🛢️", ; 数据/数据库/水桶/databasse
    "jmks", "📸", ; 单独矿区/监控/拍照
    "vxpd", "📷", ; 抓拍/
    ; 项目
    "pidd", "🧣", ; 皮带/围巾
    "muma", "🎠", ; 旋转木马/队列
    "yiho", "❓", ; 疑惑/红色问号/中立
    ; 微信生态
    "gzh", "⛩️", ; 公众号
    "xcx", "🐣", ; 小程序
)
