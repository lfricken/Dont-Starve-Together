name = "Safe Chest"
description = "A locked chest to protect your personal stuff. It's very safe... theoretically."
author = "Eric.Tsai"
version = "1.2"

forumthread = "http://steamcommunity.com/sharedfiles/filedetails/?id=742895252"

api_version = 10

dst_compatible = true
all_clients_require_mod = true
client_only_mod = false

icon_atlas = "safechest.xml"
icon = "safechest.tex"

priority = 0

configuration_options = {
	{
		name = "Language",
		options = {
			{ description = "Follow Steam", data = false },
			{ description = "English", data = "default" },
			{ description = "简体中文", data = "schinese" },
		},
		default = false,
	},
	{
		name = "Firmness",
		options = {
			{ description = "Weak", data = 120 },
			{ description = "Normal", data = 600 },
			{ description = "Hard", data = 1800 },
		},
		default = 600,
	},
	{
		name = "Gold Nugget",
		options = {
			{ description = "1", data = 1, },
			{ description = "2", data = 2, },
			{ description = "4", data = 4, },
			{ description = "6", data = 6, },
			{ description = "8", data = 8, },
		},
		default = 6
	},
	{
		name = "Gears",
		options = {
			{ description = "0", data = 0, },
			{ description = "1", data = 1, },
			{ description = "2", data = 2, },
		},
		default = 1
	},
	{
		name = "Cut Stone",
		options = {
			{ description = "1", data = 1, },
			{ description = "2", data = 2, },
			{ description = "5", data = 5, },
			{ description = "10", data = 10, },
			{ description = "20", data = 20, },
		},
		default = 15
	},
}
