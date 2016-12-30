local assets =
{
	Asset("ANIM", "anim/ethrl_spear.zip"),
	Asset("ANIM", "anim/swap_ethrl_spear.zip"),
    Asset("ATLAS", "images/inventoryimages/ethrl_spear.xml"),
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_ethrl_spear", "swap_spear")
	owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end

local function fn(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("spear")
    inst.AnimState:SetBuild("ethrl_spear")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddTag("sharp")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.ETHRL_SPEAR_DAMAGE)
    
    -------
    
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.ETHRL_SPEAR_USES)
    inst.components.finiteuses:SetUses(TUNING.ETHRL_SPEAR_USES)
    
    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ethrl_spear.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)
    
    return inst
end

return Prefab("common/inventory/ethrl_spear", fn, assets)