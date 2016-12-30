name = "SUMMON BIGFOOT( With Old Bell)"
description = ""
author = "Dark Xero"
version = "1.6"
forumthread = ""
api_version = 10
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
all_clients_require_mod = true
client_only_mod = false
server_filter_tags = { "Old Bell" }

configuration_options = {
	{
		name = "Recipe",
		label = "Recipe",
		options = {
			{description = "Statue", data = "Statue"}, 
			{description = "Ruins", data = "Ruins"},
		}, 
		default = "Ruins",
	},
}
