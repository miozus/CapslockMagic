; 音量控制  dev=[1扬声器 | 2耳机 | 3麦克风]
class SoundVolume {

    static switchVar := true

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

    ; 组合
    static switchVolumeAndMicrophone() {

        if (this.switchVar) {
            this.turnOnVolume()
        } else {
            this.turnOffVolume()
        }
        this.switchVar := !this.switchVar
        this.tip(1)
    }

    static turnOnVolume() {
        this.active(1)
        this.active(3)

    }

    static turnOffVolume() {
        this.mute(1)
        this.mute(3)
    }


}