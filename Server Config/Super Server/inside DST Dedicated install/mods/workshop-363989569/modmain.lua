local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

PrefabFiles = {
	"marbleseed"
}

Assets = 
{
	Asset("ATLAS", "images/inventoryimages/marbleseed.xml"),
    Asset("ANIM", "anim/marbleseed.zip")
}

GLOBAL.STRINGS.NAMES.MARBLESEED = "Marble Seed"
GLOBAL.STRINGS.NAMES.MARBLESEED_SAPLING = "Planted Marble Seed"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.MARBLESEED = 
{
    GENERIC = "Looks just like a rock",
    PLANTED = "Why would someone plant a rock?"
}

AddPrefabPostInit("marbletree", function (inst)
    local prefabs =
    {
        "marbleseed"
    }
    
    if not inst.components.lootdropper then inst:AddComponent("lootdropper") inst.components.lootdropper:SetChanceLootTable('marble_tree') end
    
    inst.components.lootdropper:AddChanceLoot("marbleseed",1.0)
end)

local function ModifyTree(inst)
    
    local assets =
    {
        Asset("ANIM", "anim/marbleseed.zip")
    }
    
    local prefabs =
    {
        "marble",
        "marbleseed"
    } 
    
    local function handler_growfromseed(inst)
        inst:AddTag("NOCLICK")
        inst:DoTaskInTime(1.2, inst.RemoveTag, "NOCLICK")
        inst:DoTaskInTime(1.5, function()
            inst.AnimState:PlayAnimation("full_"..inst.animnumber)
            GLOBAL.MakeSnowCovered(inst)
            end)
        inst.AnimState:PlayAnimation("growing_"..inst.animnumber)
        inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
    end
    
    inst.AnimState:SetBank("marble_trees")
    inst.AnimState:SetBuild("marbleseed")
    
    inst.growfromseed = handler_growfromseed 
    
    if not inst.components.lootdropper then inst:AddComponent("lootdropper") inst.components.lootdropper:SetChanceLootTable('marble_tree') end
    
    inst.components.lootdropper:AddChanceLoot("marbleseed",1.0)
    inst.components.lootdropper:AddChanceLoot("marbleseed",0.3)
end

for i=1,4 do
    AddPrefabPostInit("marbletree_"..i, ModifyTree)
end