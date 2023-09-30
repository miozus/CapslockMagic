class Chrome extends App.Chrome {

    static debug() {
        Send "{F12}"
    }

    static address() {
        Send "!d"
    }
    
    static oneTab() {
        Send "!+1"
    }
}