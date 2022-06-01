SendMode "Input"
SetWorkingDir A_ScriptDir
FileEncoding "UTF-8"

class Internet {

    static CheckConnection(Url:="",FIFC:=1) {
        Return DllCall("Wininet.dll\InternetCheckConnectionW", "Str",Url, "Int", FIFC, "Int",0)
    }
    
    static isOk() {
        return this.CheckConnection("http://www.baidu.com")
    }
    static disconnected() {
        return !this.isOk()
    }
    
}
