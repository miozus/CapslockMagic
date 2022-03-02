# coding = 'utf-8'
import requests
import json
import re
import sys
import urllib.parse
import xml.dom.minidom as dom
import pyperclip as pc
from pathlib import Path
from datetime import date


def json2plist(dictionary: str) -> str:
    """ 
        功能: 调用工具类网站接口，实现用户词典的转换格式
        url: "https://wtools.io/convert-json-to-plist"

        怎么开发的？
            ➤ 网页手动操作 ➤ F12 查看网页请求 ➤ 拷贝请求为 cURL(bash) 格式
            ➤ 导入 Postman, 语法嗅探获得 Python-Requests 模板
            ➤ csrf 模拟验证，urlEncode 封装数据，不断查文档修改，做成文件进出的接口
    """
    url = "https://wtools.io/convert-json-to-plist"
    client = requests.session()
    # 返回二进制页面，需要解码成字符才能正则匹配
    html = client.get(url).content.decode('utf-8')
    # csrf 验证: 前端页面随机生成验证字符串，用来与服务端的cookie（限时）比对校验
    reg = r'<meta name="csrf-token" content="(.+?)">'
    csrf_token = re.findall(reg, html)[0]
    # urlencode：必须保证表单提交的字段、编码格式一摸一样（json格式合法化）
    data = {
        "_csrf-frontend": csrf_token,
        "TextAreaForm[text]": json.dumps(dictionary),
    }
    payload = urllib.parse.urlencode(data)
    headers = {
        'authority': 'wtools.io',
        'sec-ch-ua': '"Google Chrome";v="95", "Chromium";v="95", ";Not A Brand";v="99"',
        'x-csrf-token': csrf_token,
        'sec-ch-ua-mobile': '?0',
        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
        'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'accept': 'application/json, text/javascript, */*; q=0.01',
        'x-requested-with': 'XMLHttpRequest',
        'sec-ch-ua-platform': '"Windows"',
        'origin': 'https://wtools.io',
        'sec-fetch-site': 'same-origin',
        'sec-fetch-mode': 'cors',
        'sec-fetch-dest': 'empty',
        'referer': 'https://wtools.io/convert-json-to-plist',
        'accept-language': 'zh-CN,zh;q=0.9,en;q=0.8',
        # 'cookie': csrf验证要求必须携带，好在对话自带了动态的cookie
    }
    try:
        response = client.post(url, headers=headers, data=payload).json()
    except Exception as e:
        pc.copy(e.strerror)
    if response['success']:
        print("OK")
        # 终端命令执行时，窗口关闭太快，将反馈内容保存到系统剪切板，方便其他脚本调用
        pc.copy("OK")
        return response['result']


def outputXML(xml: str, dest_path):
    # xml 美化排版
    result = dom.parseString(xml).toprettyxml()
    # 写入文件
    with open(dest_path, 'w') as f:
        f.write(result)
        f.close()


def convert_json2plist(src_path='default clipboard paste', dest_path='default current script'):
    """ 
        校验全路径的文件是否存在，否则默认来自剪贴版，去到当前脚本目录下 
        注: plist 只是 XML 的一个子类
    """
    if not Path(src_path).exists():
        src_path = Path(pc.paste())
    if not Path(dest_path).is_absolute():
        today = date.today().strftime("%Y%m%d")
        dest_path = Path(__file__).absolute().parent / f'userMacDict{today}.plist'
    _json = json.load(open(src_path, 'r'))
    _xml = json2plist(_json)
    outputXML(_xml, dest_path)


if __name__ == '__main__':
    # 命令行参数，方便 AHK 调用。例如
    # python -u "e:\dotfiles\Windows\Autohotkey\CapslockPlus_V2H\bin\plugin\json2plist.py" E:\backup\User\userDict1027.json
    src_path = sys.argv[1]
    try:
        dest_path = sys.argv[2]
    except IndexError:
        dest_path = 'default current script dir'
    convert_json2plist(src_path, dest_path)
