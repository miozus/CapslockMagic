;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode "Input"	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir	; Ensures a consistent starting directory.

;=====================================================================o
;
;   UserDictionary
;   用户词典(小鹤双拼/应用首字母)
;   无视输入法状态，敲空格键(语句+空格）或回车键(=语句+空格+回车）显示结果
;   emoji 编写词典 https://cn.piliapp.com/emoji/list/
;

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


privateDict := Map(
    ; 中文词组
    "guli", "谷粒",
    "vswf", "中文",
    ; 英文标点括号三兄弟
    "xk", "()",
    "vk", "[]",
    "dk", "{}",
    ; 中文标点
    "uumk", "《》",
    "dumh", "〈〉",	; 单书名号
    "yk", "（）",	; 圆括号
    "ftkh", "【】",	; 方头括号
    "ljkh", "｛｝",	; 六角括号
    "uglt", "・・・・・・",
    "jmge", "·",
    "pove", "——",
    "ulyb", "“”",
    "djyb", "‘’",
    "yhtz", "￥",
    "gjtj", "！",
    "wfhc", "？",
    "dzhc", "，",
    "juhc", "。",
    "ffhc", "；",
    "dyhc", "、",
    "mchc", "：",
    "rmb", "¥",
    ; 数学
    "tviu", "⇒",
    "jnti", "➤",
    "alpha", "𝛂",
    "beta", "𝜷",
    "gama", "𝜸",
    "sigma", "σ",
    "uuyu", "∈",
    "vgfu", "±",
    "xhx", "_",
    "xnyu", "<",
    "xydy", "≤",
    "dayu", ">",
    "dydy", "≥",
    "numno", "№", ; 数字编号
    ; 系统按键符号
    "backdel", "⌦",
    "del", "⌫",
    "ctrl", "⌃",
    "cmd", "⌘",
    "opt", "⌥",
    "cpaslock", " ⇪",
    "hyper", "✻",
    "enter", "⏎",
    "shift", "⇧",
    "tab", "⇥",
    "ltab", "⇤",
    "space", "␣",
    "yrdm", "•",

)

logoDict := Map(
    ; Mac用户短语不支持特殊符号开头，所以用 img 兼容
    "imginfopath", "data:image/png;base64,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",
    "imgseeyon", "https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_170,w_170,f_auto,b_white,q_auto:eco,dpr_1/384d106fe9e05cb51600",
    "imgsentinel", "https://landscape.cncf.io/logos/sentinel.svg",
    "imggolang", "https://www.clipartmax.com/png/full/288-2881446_image-result-for-golang-go-programming-language-logo.png",
    "imgspring", "https://spring.io/images/favicon-9d25009f65637a49ac8d91eb1cf7b75e.ico",
    "imgboot", "https://spring.io/images/projects/spring-boot-7f2e24fb962501672cc91ccd285ed2ba.svg",
    "imgframework", "https://spring.io/images/projects/spring-framework-640ad1b04f7efa89e0f0f7353e6b5e02.svg?v=2",
    "imgdata", "https://spring.io/images/projects/spring-data-79cc203ed8c54191215a60f9e5dc638f.svg",
    "imgjdbc", "https://favicon.yandex.net/favicon/v2/baeldung.com",
    "imgcloud", "https://spring.io/images/projects/spring-cloud-81fe04ab129ab99da0e7c7115bb09920.svg",
    "imgmvc", "https://spring.io/images/projects/logo-web-services-97f11feddb1fe1c07ae6583e5846627d.svg",
    "imgsecurity", "https://spring.io/images/projects/spring-security-b712a4cdb778e72eb28b8c55ec39dbd1.svg",
    "imgprojects", "https://spring.io/projects",
    "imgmaven", "https://www.apache.org/foundation/press/kit/feather_small.png",
    "imgtomcat", "https://upload.wikimedia.org/wikipedia/commons/f/fe/Apache_Tomcat_logo.svg",
    "imgidea", "https://upload.wikimedia.org/wikipedia/commons/9/9c/IntelliJ_IDEA_Icon.svg",
    "imgjrebel", "https://favicon.yandex.net/favicon/v2/jrebel.com",
    "imgubuntu", "https://assets.ubuntu.com/v1/29985a98-ubuntu-logo32.png",
    "imgvim", "https://upload.wikimedia.org/wikipedia/commons/9/9f/Vimlogo.svg",
    "imggit", "https://seeklogo.com/images/G/git-logo-A1D01DDA30-seeklogo.com.png",
    "imgbash", "https://d33wubrfki0l68.cloudfront.net/a1da522d0a3057a1bc3fb411fcbbf57a447c1146/65e71/img/symbol/svg/full_colored_dark.svg",
    "imgmysql", "https://favicon.yandex.net/favicon/v2/mysql.com",
    "imghibernate", "https://hibernate.org/images/hibernate_icon_whitebkg.svg",
    "imgmybatis", "https://baomidou.com/img/logo.svg",
    "imgredis", "https://cdn.icon-icons.com/icons2/2415/PNG/512/redis_original_logo_icon_146368.png",
    "imgjava", "https://image.flaticon.com/icons/png/128/226/226777.png",
    "imgnginx", "https://img.icons8.com/color/50/000000/nginx.png",
    "imgnode", "https://www.pikpng.com/pngl/b/430-4309640_js-logo-nodejs-logo-clipart.png",
    "imgpython", "https://logos-download.com/wp-content/uploads/2016/10/Python_logo_icon-700x697.png",
    "imges", "https://www.elastic.co/cn/favicon.ico",
    "imgalgorithm", "https://refactoring.guru/images/content-public/announcement-en-1.svg?id=2b6bba0470947f2a60cd",
    "imgpattern", "https://refactoring.guru/images/content-public/logos/logo-covid-2x.png?id=f1ba956cd590502c3329",
    "imghttp", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/HTTP_logo.svg/1024px-HTTP_logo.svg.png",
    "imglinux", "https://1000logos.net/wp-content/uploads/2017/03/LINUX-LOGO-453x500.png",
    "imgglassfish", "https://mvnrepository.com/img/6c90008db7297c7ae4f5668ba347f639",
    "imgorcale", "https://mvnrepository.com/img/8c33913d2ef3c87c497dbbe559f3b77b",
    "imgwin", "https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Windows_logo_-_2021.svg/25px-Windows_logo_-_2021.svg.png",
    "imgC#", "https://seeklogo.com/images/C/c-sharp-c-logo-02F17714BA-seeklogo.com.png",
    "imgunity", "https://brandslogos.com/wp-content/uploads/images/unity-logo.png",
    "imgvscode", "https://user-images.githubusercontent.com/674621/71187801-14e60a80-2280-11ea-94c9-e56576f76baf.png",
    "imgidm", "https://topbestalternative.com/wp-content/uploads/2019/10/internet-download-manager-logo.png",
    "imgregex", "https://w7.pngwing.com/pngs/742/330/png-transparent-regular-expression-computer-icons-regular-language-regex-angle-text-logo.png",
    "imgguli", "https://yt3.ggpht.com/ytc/AKedOLQ8RF3MpJ0B79MI6Ozd4CwtH7n-Of54I9FjL4rv=s48-c-k-c0x00ffffff-no-rj",
    "imghtml", "https://www.w3.org/html/logo/img/mark-only-icon.png",
    "imgcss", "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/CSS3_logo_and_wordmark.svg/120px-CSS3_logo_and_wordmark.svg.png",
    "imgjavascript", "https://cdn.icon-icons.com/icons2/2108/PNG/512/javascript_icon_130900.png",
    "imgvite", "https://vitejs.dev/logo.svg",
    "imgtailwindcss", "https://www.vectorlogo.zone/logos/tailwindcss/tailwindcss-icon.svg",
    "imgreact", "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/1024px-React-icon.svg.png",
    "imgflutter", "https://seeklogo.com/images/F/flutter-logo-5086DD11C5-seeklogo.com.png",
    "imgthymeleaf", "https://www.thymeleaf.org/images/thymeleaf.png",
    "imgjsp", "https://image.flaticon.com/icons/png/512/28/28968.png",
    "imghexo", "http://assets.stickpng.com/images/5848087ecef1014c0b5e48eb.png",
    "imgvue", "https://v3.cn.vuejs.org/logo.png",
    "imgtypescript", "https://upload.wikimedia.org/wikipedia/commons/4/4c/Typescript_logo_2020.svg",
    "imgpostman", "https://www.postman.com/favicon.ico",
    "imgmiozus", "https://miozus.github.io/img/MiozusIcon.png",
    "imgmq", "https://cdn.worldvectorlogo.com/logos/rabbitmq.svg",
    "imgdocker", "https://www.docker.com/sites/default/files/d8/styles/role_icon/public/2019-07/Moby-logo.png?itok=sYH_JEaJ",
    "imgmongodb", "https://www.mongodb.com/favicon.ico",
    "imgvagrant", "https://www.vagrantup.com/favicon.ico",
    "imgnacos", "https://img.alicdn.com/tfs/TB18TUvdlGw3KVjSZFDXXXWEpXa-400-400.jpg",
    "imgvirtualbox", "https://www.virtualbox.org/graphics/vbox_logo2_gradient.png",
    "imgmonkey", "https://pic2.zhimg.com/v2-0c2c65f8b2a77064c41c52af1081c83a_720w.jpg?source=172ae18b",
)

csDict := Map(
    ; SQL
    "ss", "sqlserver ",
    ; Java
    "apy", "application.yml",
    "app", "application.properties",
    "bsy", "bootstrap.yml",
    "px", "pom.xml",
    "spc", "Spring Could",
    "spb", "Spring Boot",
    "C", "Controller",
    "SI", "ServiceImpl: ",
    ; RESTful
    "get", "GET ",	; 诡异的get，由于前面没有逗号，所以刚才失效了
    "dlt", "DELETE ",
    "put", "PUT ",
    "post", "POST ",
    "esh", "elasticsearch",
    ; 服务器
    "lh3", "localhost:3036",
    "lh4", "localhost:4000",
    "lh7", "localhost:7000",
    "lh8", "localhost:8000",
    "lh9", "localhost:9000",
    "lhu", "localhost:10000",
    "lhuy", "localhost:11000",
    ; 时空复杂度（最好是常数s）
    "o1", "O()",
    ; Variaable
    "sfs", "static final String ",
    "fs", "FeignService",
    ; 语法嗅探
    "lgi", 'log.info("");',
    "bc", "BeanUtils.copyProperties()",
    "if", "if ()",
    "brn", "if (root == null) return null;",
    "oin", "Objects.isNull()",
    "onn", "Objects.nonNull()",
    "aie", "ArrayUtils.isEmpty()",
    "ane", "ArrayUtils.isNotEmpty()",
    "sie", "CharSequenceUtil.isEmpty()",
    "sne", "CharSequenceUtil.isNotEmpty()",
    "cie", "CollUtil.isEmpty()",
    "cne", "CollUtil.isNotEmpty()",
    "cfr", "CompletableFuture.runAsync(()->{},executor);",
    "cfa", "CompletableFuture.allOf().get();",
    "uuid", "String uuid = UUID.randomUUID().toString();",
    "clg", 'console.log("")',
    "hsr", "HttpServletRequest request",
    "att", "@Test`npublic void test",
    "aaw", "@Autowired`npublic void setBeanProperties(){",
    "ars", "@Resource",
    "abb", "@Bean",
    "adp", "@Deprecated",
    "asv", "@Service",
    "adp", "@Deprecated",
    "asv", "@Service",
    "alg", "@Slf4j",
    "acf", "@Configuration",
    "act", "@Controller",
    "apm", '@PostMapping("")',
    "agm", '@GetMapping("")',
    "arm", '@RequestMapping("")',
    "ats", '@Transactional',
    "arc", '@RestController',
    "arb", '@ResponseBody',
    "ats", '@Transactional',
    "arp", '@RequestParam("")',
    "apv", '@PathVariable("")',
    "arl", '@RabbitListener(queues = {"")',
    "arh", '@RabbitHandler',
    "atp", "@Autowired`nThreadPoolExecutor executor;",
    "art", "@Autowired`nRabbitTemplate rabbitTemplate;",
    "sba", "@SpringBootApplication",
    "erb", "@EnableRabbit",
    "ess", "@EnableRedisHttpSession",
    "esg", "@EnableScheduling",  ; 定时任务
    "asg", '@Scheduled(cron="")',
    "eas", "@EnableAsync",
    "asy", "@Async",
    ; SpringCloud
    "afc", '@FeignClient("")',
    "efc", "@EnableFeignClients",
    "edc", "@EnableDiscoveryClient",
    ; AOP
    "asp", "@Aspect",
    "aide", '@Idempotent("")',
    "acp", "@Component",
    ; swagger2
    "apt", '@Api(tags = "")',    ; 控制器标签
    "apo", '@ApiOperation("")',  ; 接口函数
    "api", '@ApiImplicitParam(name = "id", value = "编号", required = true, dataTypeClass = Long.class)',
    "aps", "@ApiImplicitParams({})",  ; 多个入参
    "apd", '@ApiModel("")', ; POJO
    "amp", '@ApiModelProperty(value = "用户编号", required = true, example = "1024")',
    ; lobmok
    "add", "@Data",
    "agt", "@Getter",
    "ast", "@Setter",
    "ape", '@Getter`n@AllArgsConstructor`npublic enum CustomEnum {`nCUSTOM(1,"注释"),`n;`nprivate final int code;`nprivate final String msg;',
    "asn", "@Setter(AccessLevel.NONE)",
    "agn", "@Getter(AccessLevel.NONE)",
    "aex", "@ToString(callSuper = true)`n@EqualsAndHashCode(callSuper = true)",
    "acc", "@Accessors(chain = true)",
    "aex", "@ToString(callSuper = true)`n@EqualsAndHashCode(callSuper = true)",
    ; Json
    "ajt", "@TableField(typeHandler = JacksonTypeHandler.class)",
    "jth", 'typeHandler="com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler"',
    "jpo", "JSON.parseObject()",
    "jts", "JSON.toJSONString()",
    "cel", "Collections.emptyList();",
    "msg", 'message=""',
    "ps", "private String ",
    ; thymeleaf
    "tnf", '#numbers.formatDecimal(variable, 1, 2)',
    "tdf", '#dates.format(new java.util.Date(varaibale),"yyyy-MM-dd HH:mm:ss")',
    "tdn", '#dates.createNow().getTime()', ; now
    "jqi", '$("#")', ;jQuery
    "tip", "SetTimer () => ToolTip(), -1000",
    "kbd", "<kbd></kbd>",
    "mdmath", "https://latex.codecogs.com/svg.latex?",	; github 接数学公式，渲染图片的 API
    "gll", "https://github.com/NiceSeason/gulimall-learning",	; 谷粒商城源码参考
    "gls", "http://search.gulimall.com/search.html",	; 谷粒商城搜索页面
    "gla", "http://auth.gulimall.com/login.html",
    "glc", "http://cart.gulimall.com",
    "glo", "http://order.gulimall.com/toTrade",
    "gli", "http://item.gulimall.com/15.html",
    "glp", "http://gulimall.com",
    "gle", "http://seckill.gulimall.com", ; 秒杀
    "glm", "http://member.gulimall.com/memberOrder.html",
    "glk", "npx kill-port 88 7000 8000 8080 9020 10001 11000 12000 20000 25000 30000 40000",
    "glf", "http://tjijdi.natappfree.cc",
    "glt", "http://localhost:8858",
    "ascii", "https://asciiflow.com/#/",
    ; cron
    "crons", "* * * * *", ; 每分钟执行一次在脚本（Linux）
    ; 支付宝沙箱
    "zfb", "vsdgso6117@sandbox.com",
    ; mysql
    "mc", "set global max_connections=1000`;", ; too many connections
    ; unittest
    "sk", '@unittest.skip("")',
    ; Golang
    "utf8", "\xEF\xBB\xBF",
    "enn", "if err != nil {`rpanic(err)`r", ; throw Exception
    "regcn", "^[\u4e00-\u9fa5]$", ; 匹配中文
    ; Vue3
    "vss", '<script setup lang="ts">`r</script>',
    "vir", "import { ref } from 'vue'",
    "via", "import axios from 'axios'",
)

winDict := Map(
    ; 终端命令快捷键
    ; docker
    "dpa", "docker ps -a",
    "nginxconf", "nvim E:\Java\nginx-1.21.3\conf\nginx.conf",
    ; powershell
    "tkp", "taskkill /F /PID 8",	; 按进程号结束
    "tki", "taskkill /F /IM .exe",	; 按名称结束
    "tfd", "tasklist | findstr 8",	; 根据端口号/名称，查看所有进程
    "nkp", "npx kill-port 8",	; cnpm i -g kill-port 杀端口号
    "nfd", "netstat -ano | findstr :8",	; 根据端口号，查看进程号
    "md5", "certutil -hashfile some_file MD5",	; 终端自带工具计算值
    ; 使用插件删除Git历史文件,清空缓存
    "bfg", 'java -jar "E:\projects\IdeaProjects\plugins\bfg-1.14.0.jar" --delete-files file_name_in_project.java .git',
    "ggc", "git reflog expire --expire=now --all `; git gc --prune=now --aggressive",
    "rmreg", 'Get-ChildItem $Path | Where{$_.Name -Match "<RegEx Pattern>"} | Remove-Item',	; 正则匹配文件名并删除
    "cdn", "cdn `; start nginx `; E:\frp\natapp\natapp.exe",  ; Nginx + RPC 内网穿透
    "sds", 'java -jar "E:\Java\sentinel\sentinel-dashboard-1.8.0.jar" --server.port=8858', ; 不支持 JDK1.17
    "catlog", "cat ./log.log -Wait -Tail 10",
    ; github
    "gcnn", "gaa `; gcn! `; gpf",	; rebase 一条龙，提交修改并强制推送到 github
    "gm", "gaa `;`; gcam '",
    ; "sdd", 'java -Dserver.port=8333 -Dcsp.sentinel.dashboard.server=localhost:8080 -Dproject.name=sentinel-dashboard -jar sentinel-dashboard.jar',

)

global secretDictionary := Map(
    ; 注册中心: 翻译命令的含义(不注册，不生效)
    "ee", "置顶与否",
    "quit", "关闭程序",
    "dx", "下载",
    "oo", "输入法",
    "no", "记事本",
    "ow", "文档",
    "opc", "图片",
    "or", "回收站",
    "os", "脚本目录",
    "ob", "备份库",
    "opr", "项目库",
    "tm", "任务管理器",
    "spy", "查看控件",
    "dotb", "备份配置",
    "doto", "打开配置",
    "rex", "重启资源管理器",
    "sleep", "睡眠",
    "shutdown", "关机",
    "reboot", "重启",
    "dt", "时间戳",
    "login", "登陆",
    "gcam", "提交代码",
    "hey", "Jude~",
    "dh", "上个桌面",
    "dl", "下个桌面",
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
    "H", "",
    "L", "",
    "docs", "腾讯文档",
    "gpt", "ChatGpt",
    "gen", "工具箱",
    "json", "excel2json",
    "deveco", "开发工具包",
)

global userDictionary := UserDict.concat([emojiDict, csDict, privateDict, logoDict, winDict])

; 选择性注释，开放转换接口
; global macDictionary := UserDict.concat([emojiDict, csDict, privateDict, logoDict])

; CapsLock & 9:: 
; {
    ; 猴子词典 -> 苹果词典
    ; Converter.convert(macDictionary, DictTypeEnum.MAC)

    ; 猴子词典 <- 苹果词典（弹窗选择文件）
    ; Converter.parse()

    ; 猴子词典 <- 苹果词典（文件目录，可选） 
    ; fileDir := "./dist/userdict4macos.plist"
    ; Converter.parse(fileDir)

; }


