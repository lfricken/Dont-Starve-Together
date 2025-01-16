require "prefabutil"
require "recipe"
require "modutil"

local assets= {
    Asset("ATLAS", "images/inventoryimages/safechest.xml"),
    Asset("IMAGE", "images/inventoryimages/safechest.tex"),
    Asset("ANIM", "anim/safechest.zip"),
}

local prefabs = {
    "collapse_small",
}

local function onopen(inst) 
    inst.AnimState:PlayAnimation("open")
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_open")
end 

local function onclose(inst) 
    inst.AnimState:PlayAnimation("idle")
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_close")
end 

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    inst.components.container:DropEverything()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle", false)
    inst.components.container:Close()
    if inst.owner ~= nil and inst.owner.userid == worker.userid then
        inst.ownerHitCount = inst.ownerHitCount - 1
        if inst.ownerHitCount <= 0 then
            onhammered(inst, worker)
        end
    end
end

local function onsave(inst, data)
    if inst.owner ~= nil then
        data.owner = inst.owner
    end
end

local function onload(inst, data)
    if data ~= nil then
        inst.owner = data.owner
    end
end

local function onbuilt(inst, data)
    local doer = data.builder
    if doer ~= nil then
        inst.owner = {
            userid = doer.userid,
            name = doer.name,
        }
    end
    inst.AnimState:PlayAnimation("idle")
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("safechest.tex")

    inst.AnimState:SetBank("safechest")
    inst.AnimState:SetBuild("safechest")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("structure")
    inst:AddTag("chest")
    inst:AddTag("safechest")

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("safechest")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(TUNING.SAFECHEST_FIRMNESS)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst.ownerHitCount = TUNING.SAFECHEST_OWNERHIT

    inst.OnSave = onsave
    inst.OnLoad = onload

    inst:ListenForEvent("onbuilt", onbuilt)

    return inst
end

return Prefab( "common/safechest", fn, assets),
    MakePlacer("common/safechest_placer", "safechest", "safechest", "idle")
