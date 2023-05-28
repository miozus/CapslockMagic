; 音量控制  dev1=[1扬声器 | 2耳机 | 3麦克风] dev2=[2扬声器 | 1耳机 | 3麦克风]
class SoundVolume {

    static switchVar := true

    ; 组合
    static switchVolumeAndMicrophone() {

        if (this.switchVar) {
            this.turnOnVolume()
        } else {
            this.turnOffVolume()
        }
        this.switchVar := !this.switchVar
        SoundController.tip(2)
    }

    static turnOnVolume() {
        loop 3 {
            SoundController.active(A_Index)
        }
    }

    static turnOffVolume() {
        loop 3 {
            SoundController.mute(A_Index)
        }
    }

}

; 音量控制器（封装细节）
class SoundController {

    static active(dev) {
        name := SoundGetName(, dev)
        isMute := SoundGetMute(, name)
        if (isMute) {
            SoundSetMute false, , name
        }
    }

    static mute(dev) {
        name := SoundGetName(, dev)
        isMute := SoundGetMute(, name)
        if (!isMute) {
            SoundSetMute true, , name
        }
    }

    static tip(dev) {
        name := SoundGetName(, dev)
        isMute := SoundGetMute(, name)
        volume := SoundGetVolume(, name)
        volumeIcon := volume >= 60 ? '🔊'
            : volume >= 30 ? '🔉'
                : '🔈'
        tooltip isMute ? '🔇 OFF'
            : volumeIcon ' ' Round(volume) "% "
    }

}