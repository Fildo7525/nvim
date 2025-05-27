# nvim

 > The links are pasted here as full links. Some browsers might not be able to open them.
 > If you are using a browser that does not support the links, you can copy the link
 > and paste it into the address bar.

Table of Contents:
- [Compatibility](#compatibility)
- [Startup](#startup)
- [Dependencies](#dependencies)
- [Lsp](#lsp)
- [DAP](#dap)
- [Spelling](#spelling)
- [Markdown](#markdown)

| Language      | Files | Blank | Comment | Code  |
|---------------|-------|-------|---------|-------|
| Lua           | 73    | 448   | 567     | 3220  |
| JSON          | 4     | 0     | 0       | 173   |
| YAML          | 1     | 0     | 1       | 114   |
| Markdown      | 1     | 33    | 0       | 67    |
| **SUM:**      | 79    | 481   | 566     | 3574  |


## Compatibility

nvim version >= 0.7 <br />
There is a specific branch for every branch from version 0.7.2. From version 0.11 (prerelease) I started using bob, (https://github.com/MordechaiHadad/bob)
command for nvim version management. The version is included in the tags of the releases if they changed. Otherwise you can find the neovim releases on
https://github.com/neovim/neovim/releases <br />

## Startup

    git clone git@github.com:Fildo7525/nvim.git
    mv nvim/ ~/.config/

Open the config for the first time and install all the plugins

#### optional Latex

If you want to setup latex with tree-sitter:

    sudo npm install --save-dev tree-sitter-cli
    echo 'export PATH="\$PATH:$HOME/node_modules/.bin"' >> ~/.zshrc

setup guide [here](https://tree-sitter.github.io/tree-sitter/creating-parsers#installation)

---

### Dependencies

#### NerdFonts

Download Nerdfont from
https://www.nerdfonts.com/font-downloads
unzip it delete all unneccessery files (If you are on linux delete everything containing ```Windows```).
Move the remaining files to ```/usr/share/fonts``` so everyone can use them or to ```~/.fonts``` for your own usage.

#### Other

If you have any other unmet dependencies you can see them after invoking command ```:checkhealth```

---

### Lsp

The custom lsp configurations are located in ```lua/usr/lsp/settings/```
If you do no want to / need to change the confugration you can just install the servers using ```Mason``` command
the default configuration from mason-lspconfig will be used.

To use the LSP's type ```:Mason``` and install given servers

#### C++

To use lsp for c/cpp/objc download clangd, clangd-format, and clang-tidy using your package manager
The formating standard is based on WebKit (tabsize - 4, strictly using tabs)

---

### DAP

DAP is currently supported for `C/C++`, `bash`, `python3`, `lua`
Use `Mason` to install the debuggers. The configuration files are located in `lua/usr/DAP/`

---

### Spelling

If the spell file you are looking for in not downloaded by neovim automaticly head to the server ```https://ftp.nluug.nl/vim/runtime/spell/```
and download it manually to ```~/.config/nvim/spell/```. This will fix the issue.

### Markdown

For the markdown ftplugins to work there are requirements

```bash
sudo apt install luarocks
sudo luarocks install luasocket htmlparser luasec html-entities
luarocks path >> ~/.zshrc
```
