return {
	"selimacerbas/markdown-preview.nvim",
	dependencies = { "selimacerbas/live-server.nvim" },
	config = function()
		require("markdown_preview").setup({
			instance_mode = "takeover",					 -- "takeover" or "multi" (see below)
			port = 0,														 -- 0 = auto (8421 for takeover, OS-assigned for multi)
			host = "127.0.0.1",									 -- bind address; "0.0.0.0" for network access (see Remote access)
			open_browser = true,									-- auto-open browser on start

			-- nil = system default browser
			-- string = browser name ("Firefox") or binary ("google-chrome")
			-- table = full command, URL appended ({ "google-chrome", "--incognito" })
			-- On macOS, string values are passed via `open -a <name>`.
			browser = nil,

			content_name = "content.md",					-- workspace content file
			index_name = "index.html",						-- workspace HTML file
			custom_css = "",											-- CSS file layered over bundled styles (~ and $VARS ok; "" = off)
			workspace_dir = nil,									-- nil = auto (shared for takeover, per-buffer for multi)

			overwrite_index_on_start = true,			-- copy plugin's index.html on every start

			auto_refresh = true,									-- auto-update on buffer changes
			auto_refresh_events = {							 -- which events trigger refresh
				"InsertLeave", "TextChanged", "TextChangedI", "BufWritePost"
			},
			debounce_ms = 300,										-- debounce interval
			notify_on_refresh = false,						-- show notification on refresh

			mermaid_renderer = "js",							-- "js" (browser mermaid.js) or "rust" (mmdr CLI, ~400x faster)

			default_theme = "dark",							 -- "dark" or "light"; initial preview theme (toggleable in browser)

			yaml_mode = "panel",									-- front matter: "panel" (collapsible above preview), "hide", or "raw"

			allow_raw_html = true,								-- render raw HTML in markdown; set false for untrusted files (see Security)

			scroll_sync = true,									 -- browser follows cursor position

			-- Fraction (0–1): vertical position of the final line when scrolled to end.
			-- 0.5 = middle of viewport (default), 1.0 = bottom edge (no extra space)
			bottom_padding = 0.5,

			hooks = {
				on_start = nil,	 -- fun(url: string)|nil — called after preview starts
				on_stop	= nil,	 -- fun()|nil — called after preview stops
			},
		})
	end,
}
