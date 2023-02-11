; 拦截器
; 巨坑：windows 必须反斜杠标识路径, 因为/xx 被判定为一个文件名称
class Interceptor {
    
    
    ; 黑名单：忽略图片，或超大文件，避免浏览器卡死
    static shouldIgnore(name) {
        ; 自动生成网页脚本：压缩js文件不是给人看的
        distList := [
            'app.*s',  'index.*s',  'vendor.*s', '.*min.js'
        ]
        ; 无法复制/不支持在线预览/空白网页
        ignoreList := [
            '.png', '.jpg', '.jpeg', '.pdf', '.zip', '.svg', '.gif',
            '.scss', '.woff', '.eot','.map', '.ttf', 
            '.jsp'
        ]
        for dist in distList {
            if RegExMatch(name, dist)  {
                return true
            }
        }
        for ignore in ignoreList {
            if InStr(name, ignore, false, -1) {
                return true
            } 
        }
        return false
    }
    
    ; 白名单：直接放行，不用拦截
    static shouldPass(name) {
        whiteList := [
            '.txt', '.java', '.md', '.xml', '.yml' 
        ]
        for white in whiteList {
            if InStr(name, white, false, -1) {
                return true
            } 
        }
        return false
    
    }

}
