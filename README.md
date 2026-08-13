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

## Compatibility

nvim version >= 0.7 <br />
There is a specific branch for every branch from version 0.7.2. From version 0.11 I started using bob, [https://github.com/MordechaiHadad/bob](https://github.com/MordechaiHadad/bob)
command for nvim version management. The version is included in the tags of the releases if they changed. Otherwise you can find the neovim releases on
[https://github.com/neovim/neovim/releases](https://github.com/neovim/neovim/releases) <br />

## Startup

    mv ~/.config/nvim ~/.config/nvim.bak
    git clone git@github.com:Fildo7525/nvim.git ~/.config/nvim

Open the config for the first time and install all the plugins

#### optional Latex

If you want to setup latex with tree-sitter:

    sudo npm install --save-dev tree-sitter-cli
    echo 'export PATH="\$PATH:$HOME/node_modules/.bin"' >> ~/.zshrc

setup guide [here](https://tree-sitter.github.io/tree-sitter/creating-parsers#installation)

---

### Dependencies

#### NerdFonts

Download NerdFont from [https://www.nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads)
unzip it delete all unnecessary files (If you are on Linux delete everything containing ```Windows```).
Move the remaining files to ```/usr/share/fonts``` so everyone can use them or to ```~/.fonts``` for your own usage.

#### tree-sitter-cli

A relatively new thing is the tree-sitter-cli executable that is needed to download the tree-sitter parsers.
The executable according to nvim-treesitter **CANNOT** be from npm. If you are on ubuntu the best choice is to use
`cargo binstall tree-sitter-cli` if you are on arch just use `sudo pacman -Ss tree-sitter-cli`.

#### Other

If you have any other unmet dependencies you can see them after invoking command ```:checkhealth```

---

### LSP (Language Server Protocol)

The custom LSP configurations are located in ```lua/usr/lsp/settings/```
If you do no want to or need to change the configuration you can just install the servers using ```Mason``` command
the default configuration from mason-lspconfig will be used.

To use the LSP's type ```:Mason``` and install given servers.

---

### DAP

DAP is currently supported for `C/C++` - `cpptools`, `bash` - `bash-debug-adapter`, `python3` - `debugpy`, `lua` (maybe, I
did not use it for a long time). Use `Mason` to install the debuggers. The configuration files are located
in `lua/usr/DAP/`.

---

### Spelling

If the spell file you are looking for in not downloaded by neovim automatically head to the server [https://ftp.nluug.nl/vim/runtime/spell/](https://ftp.nluug.nl/vim/runtime/spell/)
and download it manually to ```~/.config/nvim/spell/```. This will fix the issue.

### Markdown

Markdown has a custom parser for danish dictionary. This utility is switched off by flag `allow_external_libraries`
located in the beginning of the `ftplugin/markdown.lua` file. For the markdown ftplugins to work there are requirements that
can be installed the following way:

```bash
sudo apt install luarocks
sudo luarocks install luasocket htmlparser luasec html-entities
luarocks path >> ~/.zshrc
```

