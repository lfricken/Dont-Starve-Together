PrefabFiles = 
{
	"freezer",
}

Assets = 
{
--Asset("ATLAS", "images/inventoryimages/ui_freezer_3x4.xml"),
Asset("ATLAS", "images/inventoryimages/freezer.xml"),
Asset( "IMAGE", "minimap/freezer.tex" ),
Asset( "ATLAS", "minimap/freezer.xml" ),
}

AddMinimapAtlas("minimap/freezer.xml")

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

GLOBAL.STRINGS.NAMES.FREEZER = "Freezer"
STRINGS.RECIPE_DESC.FREEZER = "Nice!"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.FREEZER = "Should Do Nicely"
GLOBAL.chilltime = GetModConfigData("chilltime")

local Easy = (GetModConfigData("f_recipe")=="easy")

    if Easy then
local freezerrecipe = GLOBAL.Recipe("freezer",
{ 
	Ingredient("cutstone", 5),
	Ingredient("gears", 1),
	Ingredient("bluegem", 1)
},                      
    RECIPETABS.FARM, TECH.NONE, "freezer_placer" ) 
    freezerrecipe.atlas = "images/inventoryimages/freezer.xml"

    else

local freezerrecipe = GLOBAL.Recipe("freezer",
{ 
	Ingredient("cutstone", 10),
	Ingredient("gears", 3),
	Ingredient("bluegem", 3)
},                      
    RECIPETABS.FARM, TECH.NONE, "freezer_placer" ) 
    freezerrecipe.atlas = "images/inventoryimages/freezer.xml"
end

local containers = GLOBAL.require("containers")
local oldwidgetsetup = containers.widgetsetup
containers.widgetsetup = function(container, prefab, data)
if not prefab and container.inst.prefab == "freezer" then
prefab = "shadowchester"
end
return oldwidgetsetup(container, prefab, data)
end


--[[Vector3 = GLOBAL.Vector3

local function TintingPostInit(self, num, atlas, bgim, owner, container)
	if container.widgetbgimagetint then
	self.bgimage:SetTint(container.widgetbgimagetint.r, container.widgetbgimagetint.g, container.widgetbgimagetint.b, container.widgetbgimagetint.a)
    end
end

AddClassPostConstruct("widgets/invslot", TintingPostInit)

local function freezerPrefabPostInit(inst)
	local slotpos = {}
	for y = 3, 0, -1 do 
	for x = 0, 2 do
	table.insert(slotpos, Vector3(80*x-80*2+90, 80*y-80*2+40,0))
	end
end
	inst.components.container.widgetanimbank = nil
	inst.components.container.widgetanimbuild = nil

	inst.components.container.widgetbgatlas = "images/inventoryimages/ui_freezer_3x4.xml"
	inst.components.container.widgetbgimage = "ui_freezer_3x4.tex"

	inst.components.container.widgetpos = Vector3(200,0,0)
	inst.components.container.widgetbgimagetint = {r=.44,g=.74,b=1,a=1}
    inst.components.container.side_align_tip = 160

	inst.components.container.numslots = #slotpos
	inst.components.container.widgetslotpos = slotpos

end

AddPrefabPostInit("freezer", freezerPrefabPostInit)

	local seg_time = 30
	local total_day_time = seg_time*16
	

	TUNING.ICE_TIME = seg_time*16
--]]	