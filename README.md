# nvimLua

## Compatibility

nvim version >= 0.7 <br />
https://github.com/neovim/neovim/releases <br />

I currently use `bob` (https://github.com/MordechaiHadad/bob/releases) to keep the nvim updated

## Startup

    git clone git@github.com:Fildo7525/nvim.git
    mv nvim/ ~/.config/

Open the config for the first time and install all the plugins

#### optional Latex

If you want to setup latex with tree-sitter:

    sudo npm install --save-dev tree-sitter-cli
    echo 'export PATH="\$PATH:$HOME/node_modules/.bin"' >> ~/.zshrc

setup guide [here](https://tree-sitter.github.io/tree-sitter/creating-parsers#installation)

### NerdFonts

Download Nerdfont from
https://www.nerdfonts.com/font-downloads
unzip it delete all unneccessery files (If you are on linux delete everything containing ```Windows```).
Move the remaining files to ```/usr/share/fonts``` so everyone can use them or to ```~/.fonts``` for your own usage.

### Dependencies

Install ```python3```, ```python2.7```, ```nodejs```, ```build-essential```, ```python3.10-venv```, ```pip```

### Lsp

Supported languages in this config are located in ```lua/usr/lsp/lsp-installer.lua```

To use the LSP's type :LspInstall and install given servers

### C++

To use lsp for c/cpp/objc download clangd, clangd-format, and clang-tidy using your package manager
The formating standard is based on WebKit (tabsize - 4, strictly using tabs)

### DAP

DAP is currently supported for `C/C++`, `bash`, `python3`, `lua`
Use `Mason` to install the debuggers. The configuration files are located in `lua/usr/DAP/`

### Spelling

If the spell file you are looking for in not downloaded by neovim automaticly head to the server ```https://ftp.nluug.nl/vim/runtime/spell/```
and download it manually to ```~/.config/nvim/spell/```. This will fix the issue.

