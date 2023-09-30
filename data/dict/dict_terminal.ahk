; 终端命令
terminalDict := Map(
    ; 终端命令快捷键
    ; docker
    "dpa", "docker ps -a",
    "nginxconf", "nvim E:\Java\nginx-1.21.3\conf\nginx.conf",
    ; powershell
    "tkp", "taskkill /F /PID 8",	    ; 按进程号结束
    "tki", "taskkill /F /IM .exe",	    ; 按名称结束
    "tkf", "tasklist | findstr 8",	    ; 根据端口号/名称，查看所有进程
    "nkp", "npx kill-port 8",	        ; cnpm i -g kill-port 杀端口号
    "nsf", "netstat -ano | findstr :8",	; 根据端口号，查看进程号
    "md5", "certutil -hashfile some_file MD5",	; 终端自带工具计算值
    ; 或者根据任务管理器搜索"mysql"杀死任务进程
    "bfg", 'java -jar "E:\projects\IdeaProjects\plugins\bfg-1.14.0.jar" --delete-files file_name_in_project.java .git',
    "rmreg", 'Get-ChildItem $Path | Where{$_.Name -Match "<RegEx Pattern>"} | Remove-Item',	; 正则匹配文件名并删除
    "cdn", "cdn `; start nginx `; E:\frp\natapp\natapp.exe",  ; Nginx + RPC 内网穿透
    "sds", 'java -jar "E:\Java\sentinel\sentinel-dashboard-1.8.0.jar" --server.port=8858', ; 不支持 JDK1.17
    "catlog", "cat ./log.log -Wait -Tail 10",
    ; git
    ; 使用插件删除Git历史文件,清空缓存
    "ggc", "git reflog expire --expire=now --all `; git gc --prune=now --aggressive",
    "gcf", "gaa `; gcn! `; gpf",	    ; rebase 一条龙，提交修改并强制推送到 github
    "gcn", "gaa `; gc!",	    ; rebase 一条龙，提交修改并强制推送到 github
    "gam", "gaa `;`; gcam '",
    "gtg", "git tag -a v0.2.3_email_warning 6b781af -m '邮件预警：第一时间告知管理员服务故障，请立即重启'",
    "grb", "grbi head~", ; 合并近N次提交
    ; "sdd", 'java -Dserver.port=8333 -Dcsp.sentinel.dashboard.server=localhost:8080 -Dproject.name=sentinel-dashboard -jar sentinel-dashboard.jar',
)
