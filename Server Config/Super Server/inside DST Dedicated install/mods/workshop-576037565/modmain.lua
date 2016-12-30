TUNING.ETHRL_SPEAR_USES = 150
TUNING.ETHRL_SPEAR_DAMAGE = 85

PrefabFiles = {
	"ethrl_spear"
}

Assets = {
	Asset("IMAGE", "images/inventoryimages/ethrl_spear.tex"),
	Asset("ATLAS", "images/inventoryimages/ethrl_spear.xml"),
}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH

GLOBAL.STRINGS.NAMES.ETHRL_SPEAR = "Ethereal spear"
GLOBAL.STRINGS.RECIPE_DESC.ETHRL_SPEAR = "It whispers secrets to you..."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ETHRL_SPEAR = "It's an ethereal-looking spear."

local ethrl_spear = GLOBAL.Recipe("ethrl_spear", { Ingredient("twigs", 3), Ingredient("nightmarefuel", 8), Ingredient("purplegem", 2)}, RECIPETABS.WAR,  TECH.SCIENCE_TWO)
ethrl_spear.atlas = "images/inventoryimages/ethrl_spear.xml"

