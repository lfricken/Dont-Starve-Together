local STRINGS = GLOBAL.STRINGS
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local TUNING = GLOBAL.TUNING
local ACTIONS = GLOBAL.ACTIONS

local TheSim = GLOBAL.TheSim
local TheNet = GLOBAL.TheNet

local Ingredient = GLOBAL.Ingredient
local Vector3 = GLOBAL.Vector3

-- Load language file

local LANGUAGEFILES = {
    ["schinese"] = "language_chs.lua",
}

local language = GetModConfigData("Language") or TheNet:GetLanguageCode()
local languagefile = LANGUAGEFILES[language] or "language_en.lua"
modimport(languagefile)

-- Register prefabe.

PrefabFiles = {
    "safechest",
}

local assets= {
    Asset("ATLAS", "images/inventoryimages/safechest.xml"),
    Asset("IMAGE", "images/inventoryimages/safechest.tex"),
}

AddMinimapAtlas("images/inventoryimages/safechest.xml")

STRINGS.NAMES.SAFECHEST = MODSTRINGS.NAME
STRINGS.RECIPE_DESC.SAFECHEST = MODSTRINGS.RECIPE_DESC
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SAFECHEST = MODSTRINGS.CHARACTERS_DESC

TUNING.SAFECHEST_FIRMNESS = GetModConfigData('Firmness')
TUNING.SAFECHEST_OWNERHIT = 8

local materials = {
    { name = "Gold Nugget", material = "goldnugget" },
    { name = "Gears", material = "gears" },
    { name = "Cut Stone", material = "cutstone" },
}
local formula = { }
local fsize = 0

for i = 1, #materials do
    local name = materials[i]["name"]
    local material = materials[i]["material"]
    local count = GetModConfigData(name)
    if count > 0 then
        fsize = fsize + 1
        formula[fsize] = Ingredient(material, count)
    end
end

local safechest = AddRecipe("safechest", formula, RECIPETABS.TOWN, TECH.SCIENCE_TWO, "safechest_placer",
    nil, nil, nil, nil, "images/inventoryimages/safechest.xml", "safechest.tex")


-- Setup container.

local params = {}
params.safechest = {
    widget = {
        slotpos = {},
        animbank = "ui_chester_shadow_3x4",
        animbuild = "ui_chester_shadow_3x4",
        pos = Vector3(0, 220, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

for y = 2.5, -0.5, -1 do
    for x = 0, 2 do
        table.insert(params.safechest.widget.slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

local containers = GLOBAL.require "containers"
containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, params.safechest.widget.slotpos ~= nil and #params.safechest.widget.slotpos or 0)
local containers_widgetsetup = containers.widgetsetup
function containers.widgetsetup(container, prefab, data)
    local t = prefab or container.inst.prefab
    if t == "safechest" then
        local t = params[t]
        if t ~= nil then
            for k, v in pairs(t) do
                container[k] = v
            end
            container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        end
    else
        return containers_widgetsetup(container, prefab)
    end
end


-- Lock system, only on server side

local function checkPermission(target, doer)
    -- Allow if target is not a safechest
    if target.prefab ~= "safechest" then
        return true
    end

    -- Allow if target has no owner.
    if target.owner == nil then
        return true
    end

    -- Allow if target's owner is the doer
    if target.owner.userid == doer.userid then
        return true
    end

    -- Otherwise do not allow 
    return false
end

local function notifyLocked(target, doer)
    doer.components.talker:Say(MODSTRINGS.LOCKED_TIP)
end

AddComponentPostInit("container", function(container, target)
    if not GLOBAL.TheWorld.ismastersim then return end
    container.OriginalOpen = container.Open
    function container:Open(doer)
        if checkPermission(target, doer) then
            return container:OriginalOpen(doer)
        end
        notifyLocked(target, doer)
    end
end)

local ACTIONS_STORE_fn = ACTIONS.STORE.fn
ACTIONS.STORE.fn = function (action)
    local target = action.target
    local doer = action.doer
    if not GLOBAL.TheWorld.ismastersim or checkPermission(target, doer) then
        return ACTIONS_STORE_fn(action)
    end
    return false, "NOTALLOWED"
end
