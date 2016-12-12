--There are two functions that will install mods, ServerModSetup and ServerModCollectionSetup. Put the calls to the functions in this file and they will be executed on boot.

--ServerModSetup takes a string of a specific mod's Workshop id. It will download and install the mod to your mod directory on boot.
	--The Workshop id can be found at the end of the url to the mod's Workshop page.
	--Example: http://steamcommunity.com/sharedfiles/filedetails/?id=350811795
	--ServerModSetup("350811795")

--ServerModCollectionSetup takes a string of a specific mod's Workshop id. It will download all the mods in the collection and install them to the mod directory on boot.
	--The Workshop id can be found at the end of the url to the collection's Workshop page.
	--Example: http://steamcommunity.com/sharedfiles/filedetails/?id=379114180
	--ServerModCollectionSetup("379114180")

ServerModSetup("346962876") -- freezer
ServerModSetup("352499675") -- resurection shelter
ServerModSetup("378160973") -- gps
ServerModSetup("382177939") -- cellar
ServerModSetup("456028339") -- craftable living log
ServerModSetup("537902048") -- scyth
ServerModSetup("576037565") -- ethereal spear
ServerModSetup("670918115") -- durability thermal stone
ServerModSetup("771629575") -- better_beehat
ServerModSetup("683788408") -- better_thulecite
ServerModSetup("816057392") -- combined_stats_server


	

	
	
	