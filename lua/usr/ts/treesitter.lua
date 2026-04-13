local treesitter = require("nvim-treesitter")

local ensure_installed = {
	"bash", "bibtex", "c", "c_sharp", "cmake", "comment", "cpp", "desktop", "diff",
	"dockerfile", "doxygen", "git_config", "git_rebase", "gitattributes", "gitcommit",
	"gitignore", "html", "javascript", "json", "lua", "luadoc", "markdown",
	"markdown_inline", "python", "rust", "ssh_config", "thrift", "toml", "vim",
	"vimdoc", "xml", "yaml", "yaml",
},

treesitter.install(ensure_installed):wait(30000)
