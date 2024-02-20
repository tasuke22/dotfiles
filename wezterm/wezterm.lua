local status, wezterm = pcall(require, "wezterm")
if not status then
	return
end

local base_colors = {
	dark = "#172331",
	yellow = "#ffe64d",
}

local colors = {
	cursor_bg = base_colors["yellow"],
	split = "#6fc3df",
	-- the foreground color of selected text
	selection_fg = base_colors["dark"],
	-- the background color of selected text
	selection_bg = base_colors["yellow"],
	tab_bar = {
		background = base_colors["dark"],
		-- The active tab is the one that has focus in the window
		active_tab = {
			bg_color = "aliceblue",
			fg_color = base_colors["dark"],
		},
	},
}

-- キーバインドの設定、macOSの場合は以下のようになる
--
-- CTRL →  CMD
-- ALT → OPTION

-- leader keyを CTRL + sにマッピング
local leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
local act = wezterm.action
local keys = {
	-- CMD + cでタブを新規作成
	{ key = "t", mods = "CTRL", action = act({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
	-- CMD + xでタブを閉じる
	{ key = "x", mods = "CTRL", action = act({ CloseCurrentTab = { confirm = true } }) },
	-- CTRL + s + numberでタブの切り替え
	{ key = "1", mods = "LEADER", action = act({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = act({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = act({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = act({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = act({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = act({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = act({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = act({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = act({ ActivateTab = 8 }) },
	-- PANEを水平方向に開く
	{ key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	-- PANEを縦方向に開く
	{ key = "|", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	-- hjklでPANEを移動する
	{ key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
	-- PANEを閉じる
	{ key = "x", mods = "ALT", action = act({ CloseCurrentPane = { confirm = true } }) },
	-- ALT + hjklでペインの幅を調整する
	{ key = "h", mods = "CTRL|SHIFT", action = act({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "l", mods = "CTRL|SHIFT", action = act({ AdjustPaneSize = { "Right", 5 } }) },
	{ key = "k", mods = "CTRL|SHIFT", action = act({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "j", mods = "CTRL|SHIFT", action = act({ AdjustPaneSize = { "Down", 5 } }) },
	-- QuickSelect・・・画面に表示されている文字をクイックにコピペできる機能
	{ key = "Enter", mods = "SHIFT", action = "QuickSelect" },
	-- copymode
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
	-- Tab keybindings
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "n", mods = "LEADER", action = act.ShowTabNavigator },
}

return {
	color_scheme = "Gruvbox Dark (Gogh)",
	colors = colors,
	window_background_opacity = 0.8,
	tab_bar_at_bottom = false,
	hide_tab_bar_if_only_one_tab = false,
	leader = leader,
	keys = keys,
	font = wezterm.font("HackGen", { weight = "Regular", stretch = "Normal", style = "Normal" }),
	font_size = 14.5,
	line_height = 1,
	use_ime = true, -- wezは日本人じゃないのでこれがないとIME動かない
	window_padding = {
		left = "0.5cell",
		right = "0cell",
		top = "0cell",
		bottom = "0cell",
	},
	-- アクティブではないペインの彩度を変更しない
	inactive_pane_hsb = {
		saturation = 1,
		brightness = 1,
	},

	-- Tab bar
	-- I don't like the look of "fancy" tab bar
	-- https://github.com/theopn/dotfiles/blob/main/wezterm/wezterm.lua
	window_decorations = "RESIZE",
	use_fancy_tab_bar = false,
	status_update_interval = 1000,
	wezterm.on("update-status", function(window, pane)
		-- Workspace name
		local stat = window:active_workspace()
		local stat_color = "#f7768e"
		-- It's a little silly to have workspace name all the time
		-- Utilize this to display LDR or current key table name
		if window:active_key_table() then
			stat = window:active_key_table()
			stat_color = "#7dcfff"
		end
		if window:leader_is_active() then
			stat = "LDR"
			stat_color = "#bb9af7"
		end

		-- Current working directory
		local basename = function(s)
			-- Nothing a little regex can't fix
			return string.gsub(s, "(.*[/\\])(.*)", "%2")
		end
		-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l). Not a big deal, but check in case
		local cwd = pane:get_current_working_dir()
		cwd = cwd and basename(cwd) or ""
		-- Current command
		local cmd = pane:get_foreground_process_name()
		cmd = cmd and basename(cmd) or ""

		-- Time
		local time = wezterm.strftime("%H:%M")

		-- Left status (left of the tab line)
		window:set_left_status(wezterm.format({
			{ Foreground = { Color = stat_color } },
			{ Text = "  " },
			{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
			{ Text = " |" },
		}))

		-- Right status
		window:set_right_status(wezterm.format({
			-- Wezterm has a built-in nerd fonts
			-- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
			{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
			{ Text = " | " },
			{ Foreground = { Color = "#e0af68" } },
			{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
			"ResetAttributes",
			{ Text = " | " },
			{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
			{ Text = "  " },
		}))
	end),

	window_close_confirmation = "AlwaysPrompt",
	scrollback_lines = 3000,
	default_workspace = "main",
}
