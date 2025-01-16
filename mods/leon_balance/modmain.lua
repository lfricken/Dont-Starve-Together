STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

local require = GLOBAL.require
local Ingredient = GLOBAL.Ingredient


-- time definition
local seg_time = 30
local total_day_time = seg_time*16

local day_segs = 10
local dusk_segs = 4
local night_segs = 2

local day_time = seg_time * day_segs
local dusk_time = seg_time * dusk_segs
local night_time = seg_time * night_segs


-- bee hat
TUNING.ARMOR_BEEHAT_ABSORPTION = 1.0
TUNING.ARMOR_BEEHAT = 1000

-- dark sword
TUNING.NIGHTSWORD_USES = 200
TUNING.NIGHTSWORD_DAMAGE = 100
AddPrefabPostInit("nightsword", function(inst)
    if inst.components.equippable ~= nil then
        inst.components.equippable.dapperness = 0
    end
end)
local function CalcDappernessNone(inst, owner)
    return 0.0;
end
AddPrefabPostInit("nightsword", function(inst)
    if inst.components.equippable ~= nil then
        inst.components.equippable.dapperfn = CalcDappernessNone
    end
end)

-- night armor
TUNING.ARMOR_SANITY = 150 * 5
TUNING.ARMOR_SANITY_DMG_AS_SANITY = 0.0
AddPrefabPostInit("armor_sanity", function(inst)
    if inst.components.equippable ~= nil then
        inst.components.equippable.dapperness = 0
    end
end)
AddPrefabPostInit("armor_sanity", function(inst)
    if inst.components.equippable ~= nil then
        inst.components.equippable.dapperfn = CalcDappernessNone
    end
end)


-- blow dart
TUNING.PIPE_DART_DAMAGE = 300

-- night light
TUNING.NIGHTLIGHT_FUEL_MAX = (night_time+dusk_time) * 24
TUNING.NIGHTLIGHT_FUEL_START = (night_time+dusk_time) * 24
AddPrefabPostInit("nightmarefuel", function(inst)
    -- Check that the item actually has a Fuel component
    if inst.components.fuel ~= nil then
        -- Change the fuel value to LARGE_FUEL
        inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL * 4
    end
end)

-- Example function to change a recipe's ingredients
local function ChangeRecipe(recipe_name, new_ingredients)
    local recipe = GLOBAL.AllRecipes[recipe_name]
    if recipe then
        recipe.ingredients = new_ingredients
    end
end

-- meat effigy buff
TUNING.EFFIGY_HEALTH_PENALTY = 0
ChangeRecipe(
    "resurrectionstatue", 
    {
       Ingredient("meat", 6),
       Ingredient("beardhair", 4),
       Ingredient("boards", 3)
    }
)

-- ice box buff
TUNING.PERISH_FRIDGE_MULT = 0.2

-- ice cream buff (never spoil in freezer)
AddPrefabPostInit("icecream", function(inst)
    inst:AddTag("frozen")
end)
