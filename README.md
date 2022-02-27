# nvimLua

<h2>Compatibility</h2>
nvim > 0.6
https://github.com/neovim/neovim/releases
or
    sudo snap install nvim

<h2>Startup</h2>

    git clone git@github.com:Fildo7525/nvimLua.git
    mv nvimLua nvim
    mv nvim/ ~/.config/

Opent the config for the first time and install all the plugins

<h3>NerdFonts</h3>

Download Nerdfont from
https://www.nerdfonts.com/font-downloads
unzip it delete all unneccessery files (If you are on linux delete everything ending with ``` Mono.ttf ``` or containing ```Windows```).
Move the remaining files to ```/usr/share/fonts``` so everyone can use them or to ```~/.fonts``` for your own usage.

<h3>Dependencies</h3>

Install ```python3```, ```python2```, ```nodejs``` > 14 (https://computingforgeeks.com/install-node-js-14-on-ubuntu-debian-linux/),
```build-essential```, ```python3.8-venv```, ```pip```

<h3>Lsp</h3>

Supported languages in this config are located in ```lua/usr/lsp/lsp-installer.lua```

<h3>DAP</h3>

For cpp debugger download vscode and inside download debugger for cpp.
Find 

    find / -xdev -type f -name "OpenDebugAD7" 2> /dev/null

copy the address to debug adapter for cpp in

    lua/usr/dap/nvimdap.lua
