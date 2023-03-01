class Vscode extends App.Vscode {
    
    static run() {
        ; rust: cargo run main.rs
        IDE.run()
        Sleep 200
        Send "{Enter}"
        Sleep 200
        IDE.terminal()
    }

}