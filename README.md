# FSGOptimizedSeedBank

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/specnr)

## Instructions

Setup:

Tutorial video: https://youtu.be/qwLJZ89vgq0

- Download the latest release zip from [the releases page](https://github.com/Specnr/FSGOptimizedSeedBank/releases)
- Download AutoHotkey from [their website](https://www.autohotkey.com/)
- Download WSL from [this link](https://ubuntu.com/wsl) & open it
- Run `sudo su` then `apt update`
- Run `apt install openjdk-11-jre-headless`
- Run `chmod +x bh`
- Play around on [Andy's website](https://seedbankcustom.andynovo.repl.co/) to find a filter that works for you, and copy the filter code (should look something like this `000A000A00000000000A000A00000000000A000A00000000000A000A000000000`)
- Open settings.json and replace the current code with your own, as well as the number of threads you want to allocate
- Open ahk and update the minecraft saves folder

Running:

- Run the FSG_Macro.ahk, load into Minecraft and press F10. Latest verification details will be found in fsg_seed_token.txt

NOTE: If lagging too much run Slower_FSG_Macro.ahk

## Credit

- @AndyNovo the code behind the actual logic https://github.com/AndyNovo/fsgsrc
- @Specnr the code behind efficiently executing the seedfinding code (findSeed.py && multiSeed.py)
- @PodX12 the single-click AHK script
