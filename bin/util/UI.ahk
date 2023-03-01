#Include Vim.ahk

; User Interface Style
class UI {

    static convert(tagRemap, reverse := false) {
        if reverse {
            for k, v in tagRemap {
                Vim.replace(v, k)
            }
            return
        }
        for k, v in tagRemap {
            Vim.replace(k, v)
        }
    }

}


class TagRemap {

    static tag := Map(
        "el-input", "u-input",
        "label", "label",
        "el-form", "u-form",
        "el-form-item", "u-form-item",
        "el-dialog", "u-popup",
        "el-button", "u-button",
        "el-table", "u-row",
        "el-table-column", "u-col",
        "el-card", "uni-card",
        "el-row", "u-row",
        "el-col", "u-col",
        "el-date-picker", "u-date-picker",
        "dict-tag", "view",
        "el-tag", "u-tag",
        "el-select", "u-picker",
        "el-option", "view",
        "el-timeline", "u-steps",
        "el-timeline-item", "u-steps-item",
        "router-link", "u-link",
        "doc-alert", "u-alert",
        "pagination", "u-list",
    )

    ; 双引号内只有一个元素
    static quote := Map(
        "scope", "{ scope }",
        "el-icon-download", "download",
        "el-icon-plus", "plus",
        "el-icon-search", "search",
        "el-icon-refresh", "reload",
        "el-icon-edit", "edit-pen",
        "el-icon-delete", "cut",
        "el-icon-edit-outline", "edit-pen",
        "el-icon-circle-close", "close-circle",
        "el-icon-refresh-left","reload",
        "el-icon-picture-outline", "photo",
        "el-icon-document", "file-text",
        "danger", "error",
    )
    
    static normal := Map(
        'this.$router', 'this.$Router',
    )

    ; 函数: 仅权限控制
    static fn := Map(
        "v-hasPermi", "checkPermi",
        "v-hasRole", "checkRole",
    )

    ; JS: 左边只做记号，忽略内容，导入右边函数
    static js := Map(
        "permission", 'import { checkPermi, checkRole } from "@/utils/permission";',
        "parseTime", 'import { parseTime, parseTimeToday, parseWordAvatar } from "@/utils/ruoyi";',
    )

    static methods := Map(
        'permision', 'checkPermi, checkRole',
        'parseTime', 'parseTime, parseTimeToday, parseWordAvatar'
    )


    ; 标签元素
    ; static ElementToUview2 := this.testSyntax()
    static ElementToUview2 := this.generateRemap()

    static testSyntax() {
        ; msgbox this.tag.Base.Name
    }

    static generateRemap() {
        maps := Map(
            ; "quote", this.quote,
            ; "tag", this.tag,
            "normal", this.normal,
            "fn", this.fn,
            "js", this.js,
            "methods", this.methods,
        )
        temp := []
        for k, v in maps {
            temp.Push(RegEx.parseGroup(v, k))
        }
        return DictUtil.concat(temp)
    }
}


class RegEx {

    static parseGroup(remap, type := "normal") {
        temp := Map()
        switch type {
            case "tag":
                {
                    for k, v in remap {
                        from := '\([</]\)' k '\([ >]\)'
                        to := '\1' v '\2'
                        temp[from] := to
                    }
                    return temp
                }
            case "fn":
                {
                    for k, v in remap {
                        from := k '="\(.*\)">'
                        to := 'v-if="' v '(\1)">'
                        temp[from] := to
                    }
                    return temp
                }
            case "js":
                {
                    for k, v in remap {
                        from := 'import:' k
                        to := '\1\r' StrReplace(v, "/", "\/")
                        temp[from] := to
                    }
                    return temp
                }
            case "methods":
                {
                    for k, v in remap {
                        from := 'method:' k
                        to := '\1\r\t\t' v ","
                        temp[from] := to
                    }
                    return temp
                }
            case "quote":
                {
                    for k, v in remap {
                        from := '"' k '"'
                        to := '"' v '"'
                        temp[from] := to
                    }
                    return temp
                }
            default:
                return remap
        }
    }

}