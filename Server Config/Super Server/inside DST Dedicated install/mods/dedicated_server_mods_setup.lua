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
ServerModSetup("352499675") -- resurection_shelter
ServerModSetup("378160973") -- gps
ServerModSetup("382177939") -- cellar
ServerModSetup("456028339") -- craftable_living_log
ServerModSetup("537902048") -- scyth
ServerModSetup("576037565") -- ethereal_spear
ServerModSetup("670918115") -- durability_thermal_stone
ServerModSetup("771629575") -- better_beehat
ServerModSetup("683788408") -- better_thulecite
ServerModSetup("816057392") -- combined_stats_server
ServerModSetup("758532836") -- pause
ServerModSetup("797304209") -- no_disease
ServerModSetup("375850593") -- extraequip_slots
ServerModSetup("458587300") -- fasttravel
ServerModSetup("380423963") -- mineable_gems
ServerModSetup("363989569") -- marble_trees
ServerModSetup("556027744") -- oldbell
ServerModSetup("829521521") -- minimap
ServerModSetup("829519717") -- smartcrockpot


--ServerModSetup("751616547") -- safe chest safe icebox


	

	
	
	