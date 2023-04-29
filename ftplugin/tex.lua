vim.opt.textwidth=120

local no_at_end = {
	"a",
	"aj",
	"ak",
	"ale",
	"cez",
	"do",
	"k",
	"kde",
	"ku",
	"na",
	"o",
	"od",
	"po",
	"pre",
	"preto",
	"pri",
	"s",
	"so",
	"sú",
	"tak",
	"to",
	"u",
	"už",
	"v",
	"vo",
	"z",
	"za",
	"zo",
	"že",
	"či",
}

vim.keymap.set('n', '<leader>at', function ()
	for _, x in pairs(no_at_end) do
		vim.cmd('%s/\\<' .. x .. ' /' .. x .. '\\~/ge')
		x = x:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end) 
		vim.cmd('%s/\\<' .. x .. ' /' .. x .. '\\~/ge')
	end
end)
