# 快速上手 Windows 版

![windows-install](../img/windows-install.gif)

#### 下载

```bash
git clone https://github.com/miozus/CapslockMagic.git
```

#### 运行

> **温馨提示**：运行所需程序已内置，也可从 [thqby/AutoHotkey_H](https://github.com/thqby/AutoHotkey_H/releases) 版本中心下载最新发行版。

1. 添加管理员权限：打开目录`CapslockMagic/tools/AutoHotkey_H/`，右键单击 `AutoHotKey.exe` （x64 / x32），依次选择 属性 > 安全 > 兼容性 > 勾选管理员权限 > 确定。

2. 设置默认打开方式：右键单击 `CapslockMagic.ahk` ，选择打开方式，选择到步骤1的的 `AutoHotKey.exe` 打开。

> 成功标志：鼠标光标出现黑色桃心`🖤` ，或者桌面右下角托盘，出现绿色图标 `⇧`


---

#### 【推荐】开机自启

创建基本任务：按 <kbd>Win</kbd> 键搜索 `task` > 任务计划程序 > 右键单击任务计划程序库，新建文件夹 > 新建基本任务 > (按引导设置) > 完成

- 常规：必选使用最高权限运行
- 触发器：登录时（因为有的笔记本电脑电源，触发条件效果一般）
- 条件：取消勾选所有
- 操作：启动程序 `AutoHotKey.exe`, 参数 `CapslockMagic.ahk` 文件地址

![auto-startup-plan](../img/auto-startup-plan.png)


#### 【可选】快速启动小技巧

1. 新建文件夹 `myenv` 
2. 右键点击`CapslockMagic.ahk` 创建快捷方式，剪切放入 `myenv` 文件夹中（重命名为`m`）
3. 将 `myenv` 文件夹完整路径，添加到系统环境变量 PATH。
4. 即实现 <kbd> Win</kbd> + <kbd>R</kbd> 输入 `m` 回车，瞬间启动。

![myenv-tip](../img/myenv-tip.png)