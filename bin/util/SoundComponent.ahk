#NoTrayIcon
#SingleInstance Ignore
SetWorkingDir A_ScriptDir

global scGui

SoundSpyGui() 

SoundSpyGui() {
    scGui := Gui(, "Sound Components")
    scLV := scGui.Add('ListView', "w600 h400"
        , ["Component", "#", "Device", "Volume", "Mute"])

    devMap := Map()

    loop
    {
        ; 对于每一次循环迭代, 尝试获取相应的设备.
        try
            ; 音量控制  dev=[1扬声器 | 2耳机 | 3麦克风]
            devName := SoundGetName(, dev := A_Index)
        catch    ; 没有更多的设备.
            break

        ; 如果需要, 使用 ":index" 来限定名称.
        devName := Qualify(devName, devMap, dev)

        ; 如有可能, 获取主音量和静音设置.
        vol := mute := ""
        try vol := Round(SoundGetVolume(, dev), 2)
        try mute := SoundGetMute(, dev)

        ; 仅在至少检索到一项时显示主设置.
        if vol != "" || mute != ""
            scLV.Add("", "", dev, devName, vol, mute)

        ; 对于每个组件, 首先查询其名称.
        cmpMap := Map()

        loop
        {
            try
                cmpName := SoundGetName(cmp := A_Index, dev)
            catch
                break
            ; 如有可能, 检索该组件的音量和静音设置.
            vol := mute := ""
            try vol := Round(SoundGetVolume(cmp, dev), 2)
            try mute := SoundGetMute(cmp, dev)
            ; 显示此组件, 即使它不支持音量或静音,
            ; 因为它可能通过 SoundGetInterface() 支持其他控制.
            scLV.Add("", Qualify(cmpName, cmpMap, A_Index), dev, devName, vol, mute)
        }
    }

    loop 5
        scLV.ModifyCol(A_Index, 'AutoHdr Logical')
    scGui.Show()

    ; 如果需要, 使用 ":index" 来限定名称.
    Qualify(name, names, overallIndex)
    {
        if name = ''
            return overallIndex
        key := StrLower(name)
        index := names.Has(key) ? ++names[key] : (names[key] := 1)
        return (index > 1 || InStr(name, ':') || IsInteger(name)) ? name ':' index : name
    }

}