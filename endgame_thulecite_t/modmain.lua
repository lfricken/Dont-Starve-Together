STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

--Rename
STRINGS.NAMES.GREENAMULET = "Energy Amulet"
STRINGS.NAMES.GREENSTAFF = "Anti-Energy Staff"


--Description
STRINGS.RECIPE_DESC.MULTITOOL_AXE_PICKAXE = "Triply useful."
STRINGS.RECIPE_DESC.GREENSTAFF = "Make things sleepy."
STRINGS.RECIPE_DESC.GREENAMULET = "Fill your belly with pure energy."

--Tool Tip
STRINGS.GREENAMULET_TOOLTIP = "Reduced food consumption."

--Bat
TUNING.RuinsBatUses = 2000
TUNING.RuinsBatDamage = TUNING.NIGHTSWORD_DAMAGE*1.25
TUNING.RuinsBatSummonChance = 0.5


--For Both Armors
TUNING.RuinsArmorDurability = 40000
--Crown
TUNING.RuinsHatAbsorption = 0.0

TUNING.ShieldSanityDamage = 0.0
TUNING.ShieldChance = 1.0
TUNING.ShieldTime = 10
TUNING.ShieldCooldown = 10
--Armor
TUNING.RuinsArmorAbsorption = 0.9


--General
TUNING.EndGame_Thulecite_Durability = 20000

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
TUNING.SleepPower = 3
TUNING.SleepTime = TUNING.PANFLUTE_SLEEPTIME
--Orange Staff
TUNING.SpeedMult = 1.35
--Yellow Staff

--Thulecite Stack
TUNING.ThuleciteStackSize = 40

--Eye Turret
TUNING.RegenRate = 20
TUNING.EyeTurretDamage = TUNING.NIGHTSWORD_DAMAGE

Recipe("nightmare_timepiece", {Ingredient("thulecite", 1), Ingredient("nightmarefuel", 1)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, nil, nil, true)

Recipe("eyeturret_item", {Ingredient("deerclops_eyeball", 1), Ingredient("minotaurhorn", 1), Ingredient("thulecite", 5)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)

Recipe("multitool_axe_pickaxe", {Ingredient("thulecite", 20), Ingredient("goldenaxe", 2),Ingredient("goldenpickaxe", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)

Recipe("orangeamulet", {Ingredient("thulecite", 20), Ingredient("nightmarefuel", 10),Ingredient("orangegem", 4)}, RECIPETABS.ANCIENT,  TECH.ANCIENT_FOUR, nil, nil, true)
Recipe("yellowamulet", {Ingredient("thulecite", 20), Ingredient("nightmarefuel", 10),Ingredient("yellowgem", 4)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, nil, nil, true)
Recipe("greenamulet", {Ingredient("thulecite", 20), Ingredient("nightmarefuel", 10),Ingredient("greengem", 4), Ingredient("slurper_pelt", 10)}, RECIPETABS.ANCIENT,  TECH.ANCIENT_TWO, nil, nil, true)

Recipe("orangestaff", {Ingredient("nightmarefuel", 25), Ingredient("livinglog", 10), Ingredient("orangegem", 4)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)
Recipe("yellowstaff", {Ingredient("nightmarefuel", 25), Ingredient("livinglog", 10), Ingredient("yellowgem", 4)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, nil, nil, true)
Recipe("greenstaff", {Ingredient("nightmarefuel", 25), Ingredient("livinglog", 10), Ingredient("greengem", 4)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, nil, nil, true)

Recipe("ruinshat", {Ingredient("thulecite", 30), Ingredient("nightmarefuel", 30)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)
Recipe("armorruins", {Ingredient("thulecite", 30), Ingredient("nightmarefuel", 30)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)
Recipe("ruins_bat", {Ingredient("thulecite", 30), Ingredient("nightmarefuel", 30), Ingredient("livinglog", 20)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)

