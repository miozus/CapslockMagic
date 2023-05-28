#Include ../../util/Vim.ahk

class Vue2 {

    static goImport() {
        Vim.find("import")
    }

    static goMethods() {
        Vim.find("methods")
    }

    static goCss() {
        Vim.find("style ")
    }

    static goData() {
        Vim.find("data()")
    }

    static goTagView() {
        Vim.find("view")
    }

    static doImplementByClipboard() {
        Vim.implement()
    }
    

}