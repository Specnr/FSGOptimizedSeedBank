# FSGMultiSeedBank

An efficient multiseed implementation of the FSG seed bank

## Instructions

Setup:

- Download the latest release zip from [the releases page](https://github.com/Specnr/FSGMultiSeedBank/releases)
- Download WSL (Assuming you're on windows) if you haven't already
- Run `sudo apt install python3-pip`
- Run `pip3 install requests`
- Play around on [Andy's website](https://seedbankcustom.andynovo.repl.co/) to find a filter that works for you, and copy the filter code (should look something like this `000A000A00000000000A000A00000000000A000A00000000000A000A000000000`)
- Open filter.json and replace the current code with your own

Running:

- Run `python3 cfms.py NUM_THREADS` where `NUM_THREADS` is the desired number of threads

Note: After playing a few seeds press `Enter` a few times to restart finished processes.

## Disclaimer

For verification purposes you are REQUIRED to play these seeds immediately after one another. If you have to take a break, kill the process with `Ctrl+C` and restart it
when you come back

## Credit

- @AndyNovo the code behind the actual logic https://github.com/AndyNovo/fsgsrc
- @Specnr the code behind efficiently gluing the code together (cfms.py)
