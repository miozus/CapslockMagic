; 常用网站
class Website {

  class Docs {

    static tencent() {
      Run "https://docs.qq.com/desktop/"
    }

    static king() {
      Run "https://www.kdocs.cn/"
    }

  }

  ; 致远 OA
  class Seeyon {

    ; 登录门户网站
    static login() {
      Run "http://oa.elian.tech"
      if (WinWait(App.Chrome.title, , 2)) {
        WinMaximize
      }
      Timer.get4ShrinkBlockDrop(2)
      Loop 8 {
        if (PixelSearch(&FoundX, &FoundY, 1400, 900, 1500, 1000, 0x1F85EC, 3)) {
          Click FoundX, FoundY
          tooltip
          return
        }
        Timer.get4ShrinkBlockDrop(A_Index)
      }
      tooltip "等待超时"
      SetTimer () => ToolTip(), -1000
    }

    static loginI() {
      Run "http://oa.elian.tech"
      if (WinWait(App.Chrome.title, , 2)) {
        WinMaximize
      }
      Timer.get4ShrinkBlock()
      if (PixelSearch(&FoundX, &FoundY, 1400, 900, 1500, 1000, 0x1F85EC, 3)) {
        Click FoundX, FoundY
        return
      }
    }

    ; 打开日志
    static developNote() {
      if (!WinExist('贵州数易联协同办公系统 V8.1SP1 ' App.Chrome.title)) {
        this.login()
      }
      if (WinWait(App.Chrome.title, , 2)) {
        WinActivate
        WinMaximize
      }
      Run "https://oa.elian.tech/seeyon/collaboration/collaboration.do?method=newColl&from=templateNewColl&templateId=5980649476072163182&CSRFTOKEN=BUSS-TM3G-KR9G-27VU-CIKQ-AH3I-EE8P-U9KZ"
      Sleep 1000
      ; 使用模板
      Click "2131 273"
    }

    ; 测试表单提交
    static testSubmitForm() {
      if (WinWait(App.Chrome.title, , 2)) {
        WinActivate
        WinMaximize
      }
      Run "https://oa.elian.tech/seeyon/cap4/businessTemplateController.do?method=formContent&srcFrom=bizconfig&type=create&moduleId=5611860261624562905&formTemplateId=5611860261624562905&moduleType=42&tag=1676280049283&portalId=1&_resourceCode=000_/cap4/busi_9211536966745539607&CSRFTOKEN=BUSS-TM3G-KR9G-27VU-CIKQ-AH3I-EE8P-U9KZ"
      Timer.get8MoonRetation(6)
      Click "348 532"
      SendText "张三"
      Click "851 521"
      SendText "某公司"
      Click "1376 527"
      SendText "13765271234"
      Click "457 613"
      SendText "没事"
      ; 保存和关闭
      ; Click "138 138"
      ;
      ; 断言实现方案
      ; A: 在表单中设计"预期字段"，当 a1 == a2 时，符合预期，✅ 填写到表单标题
      ; B: 双击网页，按键复制文字，使用剪切板缓存 A_clipboard 比较分析， 是否符合预期
    }

    ; 本地开发环境
    static dev() {
      Run "http://localhost:8848"
    }

    ; 协同云
    static app() {
      Run "https://dcc.seeyon.com/#/workbench/main/app/myApp"
    }

  }


  static codeGen() {
    Run "https://cloud.codegen.cc/"
  }

  static alg4() {
    Run "https://visualgo.net/zh/sorting"
  }

  static editArticles() {
    Run "https://www.zhihu.com/creator/manage/creation/all"
    Run "https://mp.csdn.net/mp_blog/manage/article"
    Run "https://www.jianshu.com/writer#/notebooks/51241025/notes/92966389"
    Run "https://www.cnblogs.com/miozus/"
  }

  static excel2json() {
    Run "https://tableconvert.com/excel-to-json"
  }

  static chatGpt() {
    Run "https://gpt.chatapi.art/"
  }

  static eco() {
    Run "http://localhost:80"
    Run "https://uniapp.dcloud.net.cn/component/scroll-view.html#scroll-view"
    Run "https://www.uviewui.com/components/search.html"
    Run "https://docs.qq.com/blankpage/DWkF3Ym1PV1ROREF4"
    Run "https://doc.ruoyi.vip/ruoyi-vue/"
  }

}