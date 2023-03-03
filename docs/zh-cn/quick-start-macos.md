# 快速上手 MacOS 版

#### 【推荐】免下载一键导入


> **温馨提示**： 脚本支撑软件是免费开源的 [Karabiner-Element](https://karabiner-elements.pqrs.org/) ，如未下载，请先自行下载。 CapsLockMagic 已支持拓展包：
> 
> - 分号特殊符 `Semicolon Pull Down Symbol`
> - 数字小键盘 `3 Awake Digital Keyboard`
> - 其他基础功能，请参考开源项目 [Vonng/Capslock](https://github.com/Vonng/Capslock) ，按需导入。

使用 `Safari` 浏览器打开链接，它将自动加载配置到 `Karabiner-Element`：打开软件，选择 `complex-mapping` 标签 >
左下角 `add-rule` > 选择配置 > `Enable` 。

```bash
karabiner://karabiner/assets/complex_modifications/import?url=https://raw.githubusercontent.com/miozus/CapslockMagic/master/tools/karabiner/caps_lock_magic.json
```

---

#### 【可选】官方仓库导入

```bash
https://ke-complex-modifications.pqrs.org/#caps_lock_magic
```


#### 【可选】手动导入 

**下载**

  ```bash
  git clone https://github.com/miozus/CapslockMagic.git
  ```

**修改**

修改文件 `tools/karabiner/caps_lock_magic.yml`


运行终端命令 yq （如果没安装过，则先运行 `brew install yq`），转换格式 yaml ⇒ json 放到默认配置目录中

```bash
yq eval -j -I=2 your_path_to_CapslockMagic/tools/karabiner/caps_lock_magic.yml > ~/.config/karabiner/assets/complex_modifications/caps_lock_magic.json
```

**启用**

打开应用，添加规则和启用配置

```bash
open -a Karabiner-Elements
```
