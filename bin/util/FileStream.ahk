#Include Logger.ahk

; 文件读写
class FileStream {

    static reason :=  ""
    static empty := EmptyFile.abspath
    ; 指定拷贝文件的来源和去 task := ""
    static root := "E:\path\to\download"
    static task := "childDir"
    static CopySource := this.root "\source\" this.task
    static CopyDest := this.root "\dest\" this.task
    
    ; 删除
    static delete(path) {
        FileDelete(path)
    }

    ; 续写: 先删后写，因为不支持覆写
    static appendIfAbsent(path, str) {
        FileAppend(str, path, 'UTF-8')
    }

    ; 空文件（覆写）: 先手动创建一个模板文件，添加原因注释
    static copyOverride(dest, src:=0, override:=true) {
        if IsNumber(src) {
            src := this.empty
        }
        FileCopy(src, dest, override)
    }
    
    ; 异常切面
    static __New() {
        t1 := this.appendIfAbsent
        t2 := this.copyOverride
        this.DefineProp('appendIfAbsent', {
            call: (self, args*) => this.around(self, t1, args*)
        })
        this.DefineProp('copyOverride', {
            call: (self, args*) => this.around(self, t2, args*)
        })
    }

    ; 异常处理
    static around(self, func, args*) {
        this.reason := ""
        path := args[1]
        try {
            if InStr(FileExist(Path), "A") {
                ; 已存在：直接覆写
                ; 如果支持反射就好了，能知道函数的名字，避免参数，或者静态变量做区分
                if args.Length == 1 or args.Length == 3 {
                    return func(self, path)
                }
                FileDelete(path)
            }
            ; 不存在：删了写入
            SplitPath(path, &name, &dir)
            DirCreate(dir)
            func(self, path, args[2])
        } catch Error as e {
            this.reason := "🐞" e.Message
        }
    }
    
    static catSourceFiles() {
        CopySource := this.CopySource
        Loop Files, CopySource "\*.*", "R" {
            fileStr := SubStr(A_LoopFileFullPath, StrLen(CopySource) + 1) "💠" A_LoopFileName
            log.info("🧪", fileStr, true)
            sleep 50
            if A_Index==10 {
                break
            }
        }
    }

    static copyFiles() {
        Loop Files, this.CopySource "\*.*", "R" {
            tip := ""
            reason := ""
            copy_it := false
            CopyDestFileFullPath := this.CopyDest SubStr(A_LoopFileFullPath, StrLen(this.CopySource) + 1)

            if !FileExist(CopyDestFileFullPath) {
                ; 如果目标文件还不存在, 那么总是复制.
                if EmptyFile.timeEquals(A_LoopFileTimeModified) || EmptyFile.sizeEquals(A_LoopFileSize){
                    tip .= "🈚"
                }
                tip .= "⭐"
                copy_it := true
            } else {
                time := FileGetTime(CopyDestFileFullPath)
                time := DateDiff(time, A_LoopFileTimeModified, "Seconds")  ; 从目的时间中减去源文件的时间.
                ; 源文件比目的文件新
                if time < 0 {
                    copy_it := true
                    tip .= "🔄"
                }
            }
            if copy_it {
                try {
                    ; 以覆盖形式复制 overwrite=yes
                    SplitPath(CopyDestFileFullPath, &name, &dir)
                    if !DirExist(dir) {
                        DirCreate(dir)
                    }
                    FileCopy A_LoopFilePath, CopyDestFileFullPath, true   
                    tip := "✅"
                } catch Error as e {
                    tip .= "🐞" 
                    resaon := " | " e.Message
                }
            } else {
                ; 什么也没做
                tip := "💤" 
            }
            msg := A_LoopFileShortPath " ⇒ " CopyDestFileFullPath reason
            log.info(tip, msg, true)
        }
    }

}


; 不公开内容的文件模型（首先创建一个空文件，再复制改名，比直接创建新文件速度快）
class EmptyFile {
    ; 上次修改时间
    static timeModified := 20220417223724
    ; 文件大小字节数
    static sizes := [ 0, 54, 68 ]
    ; 文件路径
    static abspath :=  "E:\path\to\empty.txt"
    
    static sizeEquals(size) {
        for s in this.sizes {
            if s == size {
                return true
            }
        }
        return false
    }

    static timeEquals(timeModified) {
        return this.timeModified == timeModified
    }
}
    
