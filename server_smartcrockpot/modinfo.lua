-- This information tells other players more about the mod
name = "SmartCrockPot Server Version"
description = "Predicts your cooking ! Automatically installs on anyone who joins your server. All credits go to original author Nadevill."
author = "Nadevill"
version = "4.021"
priority = 10

api_version = 10
dst_compatible = true
all_clients_require_mod = true

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the URL
-- Example:
-- http://forums.kleientertainment.com/showthread.php?19505-Modders-Your-new-friend-at-Klei!
-- becomes
-- 19505-Modders-Your-new-friend-at-Klei!
forumthread = "/files/file/458-smarter-crock-pot/"

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10
dont_starve_compatible = true
reign_of_giants_compatible = true

icon_atlas = "SmartCrockPot.xml"
icon = "SmartCrockPot.tex"


configuration_options =
{
	{
		name = "Controller",
		label = "Controller support",
		options =	{
                        {description = "Off", data = false},
						{description = "On by Nav", data = true},
						
					},

		default = false,
	
	},
    
}