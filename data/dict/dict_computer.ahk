; 计算机科学 / 编程开发
computerDict := Map(
    ; SQL
    "ss", "sqlserver ",
    ; Java
    "bsy", "bootstrap.yml",
    "pom", "pom.xml",
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
    ; RESTful
    "apm", '@PostMapping("/")',
    "agm", '@GetMapping("/")',
    "arm", '@RequestMapping("/")',
    ; controller
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
    ; swagger3
    "apt", '@Tag(name = "")',    ; 控制器标签注释
    "apo", '@Operation(summary = "")',  ; 接口函数作用注释
    "app", '@Parameter(name = "id", description = "编号", required = true)', ; 入参注释
    "api", '@GetMapping("/get")`n@Operation(summary = "测试接通情况")`n@Parameter(name = "id", description = "编号", required = true, example = "1024")`npublic CommonResult<Long> testApi(@RequestParam("id") Long id) {`nreturn success(1L);`n}',
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
    "pst", "private String ",
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
    "crond", "00 1 * * *", ; 每天 1:00 执行一次在脚本（Linux）
    "top5", "top -c -b -o +%MEM | head -n 20 | tail -15", ; 查找内存消耗最大的进程
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
    ; ES6
    "jcp", "var obj = JSON.parse(JSON.stringify())`;", ; json copy obj
    "kin", "Object.keys(obj).length === 0 && obj.constructor === Object", ; keys is null
    "knn", "!(Object.keys(obj).length === 0 && obj.constructor === Object)", ; keys not null
    ; service
    "lls", 'cd E:\MagicBook\company\mall\lilishop\lilishop-ui\seller `;`; npm run dev', ; 丽丽商城店铺端UI
    ; logger
    "lgf", 'log.info(Progress.format(locationName, String.format("")));',
)