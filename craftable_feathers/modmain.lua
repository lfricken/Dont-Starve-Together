STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

--Prestihatitator

--Azure Feather
STRINGS.RECIPE_DESC.FEATHER_ROBIN_WINTER = "Blue as the sky."
AddRecipe("feather_robin_winter", {
	Ingredient("houndstooth", 2),
	Ingredient("twigs", 2),
	Ingredient("nightmarefuel", 1)
}, RECIPETABS.REFINE, TECH.MAGIC_TWO)


--Crimson Feather
STRINGS.RECIPE_DESC.FEATHER_ROBIN = "Red as a sunset."
AddRecipe("feather_robin", {
	Ingredient("charcoal", 2),
	Ingredient("twigs", 2),
	Ingredient("nightmarefuel", 1)
}, RECIPETABS.REFINE, TECH.MAGIC_TWO)


--Jet Feather
STRINGS.RECIPE_DESC.FEATHER_CROW = "Black as night."
AddRecipe("feather_crow", {
	Ingredient("stinger", 2),
	Ingredient("twigs", 2),
	Ingredient("nightmarefuel", 1)
}, RECIPETABS.REFINE, TECH.MAGIC_TWO)

--Safron Feather
STRINGS.RECIPE_DESC.FEATHER_CANARY = "Gold as... gold."
AddRecipe("feather_canary", {
	Ingredient("gold", 2),
	Ingredient("twigs", 2),
	Ingredient("nightmarefuel", 1)
}, RECIPETABS.REFINE, TECH.MAGIC_TWO)



