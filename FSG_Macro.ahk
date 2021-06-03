;;script created by PodX12 py by Specnr

#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%
SetKeyDelay, 50

IfNotExist, fsg_tokens
    FileCreateDir, fsg_tokens

;UPDATE THIS TO YOUR MINECRAFT SAVES FOLDER
global SavesDirectory = "C:\Users\PodX1\AppData\Roaming\.minecraft\saves\" ; Replace this with your minecraft saves
IfNotExist, %SavesDirectory%_oldWorlds
    FileCreateDir, %SavesDirectory%_oldWorlds

;Adjust the threads based on your PC and how quick you want to find a GetSeed()

;https://seedbankcustom.andynovo.repl.co/ to adjust your filter update inside filters.json
;TO EDIT YOUR FILTER
;GOTO https://seedbankcustom.andynovo.repl.co/
;SELECT YOUR FILTER AND GET A FILTER CODE e.g. 000A000A00000000000A000A00000000000A000A00000000000A000A000000000
;OPEN settings.json and update your filter and desired number of threads
;

;HOW TO GET YOUR TOKEN
;When you press your macro to GetSeed it will create a file called fsg_seed_token.txt
;This has the seed and the token.
;
;Any past run seeds will be stored into the folder fsg_tokens with the name 
;fsg_seed_token followed by a date and time e.g. 123456789_2021261233.txt

FindSeed(){
    if WinExist("Minecraft"){
        if FileExist("fsg_seed_token.txt"){
            FileMoveDir, fsg_seed_token.txt, fsg_tokens\fsg_seed_token_%A_NowUTC%.txt, R
        }

        ComObjCreate("SAPI.SpVoice").Speak("SebyTheGod")


        RunWait, wsl.exe python3 ./findSeed.py > fsg_seed_token.txt,, hide
        FileRead, fsg_seed_token, fsg_seed_token.txt

        fsg_seed_token_array := StrSplit(fsg_seed_token, ["Seed Found", "Temp Token"]) 
        fsg_seed_array := StrSplit(fsg_seed_token_array[2], A_Space)
        fsg_seed := Trim(fsg_seed_array[2])

        clipboard = %fsg_seed%

        WinActivate, Minecraft
        Sleep, 100
        ;ComObjCreate("SAPI.SpVoice").Speak("Seed Found")
        FSGCreateWorld()
    } else {
        MsgBox % "Minecraft is not open, open Minecraft and run agian."
    }
}

GetSeed(){
    WinGetPos, X, Y, W, H, Minecraft
    WinGetActiveTitle, Title
    IfNotInString Title, player
        FindSeed()()
    else {
        ExitWorld()
        Loop {
            IfWinActive, Minecraft 
            {
                PixelSearch, Px, Py, 0, 0, W, H, 0x00FCFC, 1, Fast
                if (!ErrorLevel) {
                    Sleep, 100
                    IfWinActive, Minecraft 
                    {
                        FindSeed()()
                        break
                    }
                }
            }
        } 
    } 
}

FSGCreateWorld(){
    Send, {Esc}{Esc}{Esc}
    Send, `t
    Send, {enter}
    Send, `t
    Send, `t
    Send, `t
    Send, {enter}
    Send, ^a
    Send, ^v
    Send, `t
    Send, `t
    Send, {enter}
    Send, {enter}
    Send, {enter}
    Send, `t
    Send, `t
    Send, `t
    Send, `t
    Send, {enter}
    Send, `t
    Send, `t
    Send, `t
    Send, ^v
    Send, `t
    Send, `t
    Send, `t
    Send, `t
    Send, `t
    Send, {enter}
    Send, `t
    Send, {enter}
}

ExitWorld()
{
    send {Esc}+{Tab}{Enter}
    sleep, 100
    Loop, Files, %SavesDirectory%*, D
    {
        _Check := SubStr(A_LoopFileName,1,1)
        If (_Check != "_")
        {
            FileMoveDir, %SavesDirectory%%A_LoopFileName%, %SavesDirectory%_oldWorlds\%A_LoopFileName%_%A_NowUTC%, R
        }
    }
}

F10::
    GetSeed()
return

