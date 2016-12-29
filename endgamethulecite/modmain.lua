STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

local dayTime = 8 * 60

--Rename
STRINGS.NAMES.GREENAMULET = "Energy Amulet"
STRINGS.NAMES.GREENSTAFF = "Anti-Energy Staff"

--General
TUNING.EndGame_Thulecite_Durability = 3000
TUNING.EndGame_Thulecite_Durability_Time = dayTime * 30
TUNING.EndGame_Thulecite_Durability_Uses = 300

--Description
STRINGS.RECIPE_DESC.MULTITOOL_AXE_PICKAXE = "Triply useful."
STRINGS.RECIPE_DESC.GREENSTAFF = "Make things more basic."
STRINGS.RECIPE_DESC.GREENAMULET = "Fill your belly with pure energy."

--Tool Tip
STRINGS.GREENAMULET_TOOLTIP = "Regular Craft Cost"

--Bat
TUNING.RuinsBatUses = TUNING.EndGame_Thulecite_Durability_Uses
TUNING.RuinsBatDamage = TUNING.NIGHTSWORD_DAMAGE*1.5
TUNING.RuinsBatSummonChance = 0.5


--For Both Armors
TUNING.RuinsArmorDurability = TUNING.EndGame_Thulecite_Durability
--Crown
TUNING.RuinsHatAbsorption = 0.0

TUNING.ShieldSanityDamage = 0.0
TUNING.ShieldChance = 1.0
TUNING.ShieldTime = 10
TUNING.ShieldCooldown = 10
--Armor
TUNING.RuinsArmorAbsorption = 0.9


--Wall
TUNING.RUINSWALL_HEALTH = TUNING.EndGame_Thulecite_Durability

--Tool
TUNING.ToolSpeed = 3

--Green Amulet
TUNING.HungerRate = 0.1
--Orange Amulet
TUNING.PickupRate = 0.1
--Yellow Amulet
TUNING.SanityGain = TUNING.DAPPERNESS_LARGE*2

--Staff Use
TUNING.SanityOnUse = 5
--Green Staff
--TUNING.GREENSTAFF_USES = 5
--Orange Staff
TUNING.SpeedMult = 1.35
TUNING.ORANGESTAFF_USES = TUNING.EndGame_Thulecite_Durability_Uses
--Yellow Staff
TUNING.YELLOWSTAFF_USES = TUNING.EndGame_Thulecite_Durability_Uses

--Thulecite Stack
TUNING.ThuleciteStackSize = 40

--Eye Turret
TUNING.RegenRate = 20
TUNING.EyeTurretDamage = TUNING.NIGHTSWORD_DAMAGE

AddRecipe("nightmare_timepiece", {Ingredient("thulecite", 1), Ingredient("nightmarefuel", 1)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, nil, nil, true)

AddRecipe("eyeturret_item", {Ingredient("deerclops_eyeball", 1), Ingredient("minotaurhorn", 1), Ingredient("thulecite", 5)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)

AddRecipe("multitool_axe_pickaxe", {Ingredient("thulecite", 8), Ingredient("goldenaxe", 2),Ingredient("goldenpickaxe", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)

AddRecipe("orangeamulet", {Ingredient("thulecite", 5), Ingredient("nightmarefuel", 5),Ingredient("orangegem", 2)}, RECIPETABS.ANCIENT,  TECH.ANCIENT_FOUR, nil, nil, true)
AddRecipe("yellowamulet", {Ingredient("thulecite", 5), Ingredient("nightmarefuel", 5),Ingredient("yellowgem", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, nil, nil, true)
AddRecipe("greenamulet", {Ingredient("thulecite", 5), Ingredient("slurper_pelt", 5),Ingredient("greengem", 2)}, RECIPETABS.ANCIENT,  TECH.ANCIENT_TWO, nil, nil, true)

AddRecipe("orangestaff", {Ingredient("nightmarefuel", 6), Ingredient("livinglog", 3), Ingredient("orangegem", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)
AddRecipe("yellowstaff", {Ingredient("nightmarefuel", 8), Ingredient("livinglog", 5), Ingredient("yellowgem", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, nil, nil, true)
AddRecipe("greenstaff", {Ingredient("nightmarefuel", 10), Ingredient("livinglog", 7), Ingredient("greengem", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, nil, nil, true)

AddRecipe("ruinshat", {Ingredient("thulecite", 6), Ingredient("nightmarefuel", 6)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)
AddRecipe("armorruins", {Ingredient("thulecite", 8), Ingredient("nightmarefuel", 8)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)
AddRecipe("ruins_bat", {Ingredient("thulecite", 6), Ingredient("nightmarefuel", 6), Ingredient("livinglog", 6)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)

