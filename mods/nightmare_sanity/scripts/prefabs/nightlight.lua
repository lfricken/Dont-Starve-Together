require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/nightmare_torch.zip"),
}

local prefabs =
{
    "collapse_small",
    "nightlight_flame",
}

--LEON MOD
local function stateRemaining(inst)
	local healthStatus = math.floor(0.5 + inst.components.fueled:GetPercent() * TUNING.NIGHTLIGHT_FUEL_MAX_DAYS)
	inst.components.talker:Say(healthStatus .. " Days", 4, nil, true)
end
--END LEON MOD

local function onhammered(inst)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    inst:Remove()
end

local function onhit(inst)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle")
end

local function onextinguish(inst)
    if inst.components.fueled ~= nil then
        inst.components.fueled:InitializeFuelLevel(0)
    end
end

local function CalcSanityAura(inst, observer)
    local lightRadius = inst.components.burnable ~= nil and inst.components.burnable:GetLargestLightRadius() or 0
    return lightRadius > 0 and observer:IsNear(inst, .5 * lightRadius) and -.05 or 0
end

local function ontakefuel(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
	stateRemaining(inst)
end

local function onupdatefueled(inst)
    if inst.components.burnable ~= nil then
        inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
    end
end

local function onfuelchange(newsection, oldsection, inst)
    if newsection <= 0 then
        inst.components.burnable:Extinguish()
    else
        if not inst.components.burnable:IsBurning() then
            inst.components.burnable:Ignite()
        end

        inst.components.burnable:SetFXLevel(newsection, inst.components.fueled:GetSectionPercent())
    end
end

local function onbuilt(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", false)
end

local function OnHaunt(inst, haunter)
    local ret = false
    if inst.components.fueled ~= nil and
        not inst.components.fueled:IsEmpty() and
        math.random() <= TUNING.HAUNT_CHANCE_HALF then
        inst.components.fueled:MakeEmpty()
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        ret = true
    end
    --#HAUNTFIX
    --if inst.components.workable ~= nil and
        --inst.components.workable:CanBeWorked() and
        --math.random() <= TUNING.HAUNT_CHANCE_HALF then
        --inst.components.workable:WorkedBy(haunter, 1)
        --inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        --ret = true
    --end
    return ret
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .1)

    inst.MiniMapEntity:SetIcon("nightlight.png")

    inst.AnimState:SetBank("nightmare_torch")
    inst.AnimState:SetBuild("nightmare_torch")
    inst.AnimState:PlayAnimation("idle", false)

    inst:AddTag("structure")
    inst:AddTag("wildfireprotected")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    -----------------------
	--leon mod
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 24
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.offset = Vector3(0, -500, 0)
	
	inst.speak = inst:DoPeriodicTask(TUNING.NIGHTLIGHT_FUEL_SAY_PERIOD, stateRemaining, 1)
	--leon mod end
    -----------------------

    -----------------------
    inst:AddComponent("burnable")
    inst.components.burnable:AddBurnFX("nightlight_flame", Vector3(0, 0, 0), "fire_marker")
    inst.components.burnable.canlight = false
    inst:ListenForEvent("onextinguish", onextinguish)

    -------------------------
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    -------------------------
    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.NIGHTLIGHT_FUEL_MAX
    inst.components.fueled.accepting = true
    inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
    inst.components.fueled:SetSections(4)
    inst.components.fueled:SetTakeFuelFn(ontakefuel)
    inst.components.fueled:SetUpdateFn(onupdatefueled)
    inst.components.fueled:SetSectionCallback(onfuelchange)
    inst.components.fueled:InitializeFuelLevel(TUNING.NIGHTLIGHT_FUEL_START)

    -----------------------------

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)

    -----------------------------

    inst:AddComponent("inspectable")

    inst:ListenForEvent("onbuilt", onbuilt)

    return inst
end

return Prefab("nightlight", fn, assets, prefabs),
    MakePlacer("nightlight_placer", "nightmare_torch", "nightmare_torch", "idle")
