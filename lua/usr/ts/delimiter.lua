local rainbow = require('rainbow-delimiters')
local rainbow_setup = require('rainbow-delimiters.setup')

rainbow_setup.setup({
	strategy = {
		[''] = rainbow.strategy['global'],
		lua = nil,
	},
	query = {
		[''] = 'rainbow-delimiters',
		lua = nil,
	},
	priority = {
		[''] = 110,
	},
	highlight = {
		'RainbowDelimiterRed',
		'RainbowDelimiterYellow',
		'RainbowDelimiterBlue',
		'RainbowDelimiterOrange',
		'RainbowDelimiterGreen',
		'RainbowDelimiterViolet',
		'RainbowDelimiterCyan',
	},
})
