# nvimLua

<h2>Compatibility</h2>
nvim version >= 0.7 <br />
https://github.com/neovim/neovim/releases <br />

<h2>Startup</h2>

    git clone git@github.com:Fildo7525/nvimLua.git
    mv nvimLua nvim
    mv nvim/ ~/.config/

Open the config for the first time and install all the plugins

<h3>NerdFonts</h3>

Download Nerdfont from
https://www.nerdfonts.com/font-downloads
unzip it delete all unneccessery files (If you are on linux delete everything containing ```Windows```).
Move the remaining files to ```/usr/share/fonts``` so everyone can use them or to ```~/.fonts``` for your own usage.

<h3>Dependencies</h3>

Install ```python3```, ```python2.7```, ```nodejs``` > 14 (https://computingforgeeks.com/install-node-js-14-on-ubuntu-debian-linux/),
```build-essential```, ```python3.10-venv```, ```pip```

<h3>Lsp</h3>

Supported languages in this config are located in ```lua/usr/lsp/lsp-installer.lua```

To use the LSP's type :LspInstall and install given servers

<h4>C++</h4>
To use lsp for c/cpp/objc download clangd, clangd-format, and clang-tidy using your package manager
The formating standard is based on WebKit (tabsize - 4, strictly using tabs)

<h3>DAP</h3>

DAP is currently supported for C/C++

For cpp debugger download vscode and inside download debugger for cpp.
Find 

    find / -xdev -type f -name "OpenDebugAD7" 2> /dev/null

It should be located at ${HOME}/.vscode/...

copy the address to debug adapter for cpp in

    lua/usr/dap/settings/dapcpp.lua
