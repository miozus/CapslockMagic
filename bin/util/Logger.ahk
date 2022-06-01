SendMode "Input"
SetWorkingDir A_ScriptDir
FileEncoding "UTF-8"


#Include FileStream.ahk

class Log {

    ; 样式效果
    ; [2022-04-18 19:26:08] 执行任务 294-2: 🐘: project/java/echarts.simple.min.js
    ; [2022-04-18 19:26:23] 执行任务 294-3: ✅(3) 系统找不到指定的路径。
    
    static logStr := ""
    static tipStr := ""
    static logPath := A_ScriptDir "\dist\log\info" FormatTime(, "yyyyMMdd") ".log"
    ; 重启脚本时重置
    static count := 1

    static open() {
        Run this.logPath
    }
    
    ; PowerShell
    static openByPosh() {
        cmd :=  "cat " this.logPath " -Wait -Tail 50"
        Run "wt.exe " cmd
    }
    
    ; progress 历史进度，手动填写 后续识别网页页码高亮区域 + 读取日志分析，自动续写日志
    ; page 页码（任务数组）
    ; row 行数（第N个）
    static init(page, row:="", progress:="") {
        if IsNumber(progress) {
            progress := progress + page - 1
        } 
        this.logStr .= (
            '[' FormatTime(, "yyyy-MM-dd HH:mm:ss") '] ' progress 
        ) 
        if IsNumber(row) {
            ; 管道操作
            this.tipStr := "P" page "-" row " "
            if row < 10 {
                this.logStr .= '-' row ' |'
            } else {
                this.logStr .= '-' row '|'
            }
        } else {
            this.tipStr := "P" page
            this.logStr .= page " |"
        }
    }
    
    static info(tip, msg:="", default:=false) {
        if msg == "" {
            this.logStr .= tip
        } else {
            this.logStr .= tip " " msg
        }
        tooltip this.tipStr tip
    }

    static save(path:="") {
        if path != "" {
            this.logPath := path
        }
        FileAppend this.logStr '`n', this.logPath, "UTF-8"
        this.logStr := ""
        this.tipStr := ""
    }

    
    static append(args*) {
        loop args.Length {
            this.logStr .= " " args[A_Index]
        }
    }
    
    ; AOP
    static __New() {
        t1 := this.open
        t2 := this.openByPosh
        t3 := this.save
        t4 := this.info
        this.DefineProp('open', {
            call: (self, args*) => this.before(self, t1, args*)
        })
        this.DefineProp('openByPosh', {
            call: (self, args*) => this.before(self, t2, args*)
        })
        this.DefineProp('save', {
            call: (self, args*) => this.before(self, t3, args*)
        })
        this.DefineProp('info', {
            call: (self, args*) => this.around(self, t4, args*)
        })
    }
    
    ; 自定义的预处理动作
    static before(self, func, args*) {
        if !FileExist(this.logPath) {
            FileStream.appendIfAbsent(this.logPath, "")
        }
        func(self, args*)
    }
    
    static around(self, func, args*) {
        try {
            default := args[3]
            if default {
                this.init(this.count)
            } 
            func(self, args*)
            this.save(this.logPath)
            this.count++
        } catch Error as e {
            func(self, args*)
        }
    }
}
