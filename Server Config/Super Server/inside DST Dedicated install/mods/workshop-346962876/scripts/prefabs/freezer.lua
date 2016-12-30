require "prefabutil"

local assets=
{
	Asset("ANIM", "anim/freezer.zip"),
	Asset("ANIM", "anim/ui_chest_3x3.zip"),
	
}

local function onopen(inst) 
        inst.AnimState:PlayAnimation("open")	 
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")		

        inst.Light:Enable(true)
end 

local function onclose(inst) 
	inst.AnimState:PlayAnimation("closed")
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")		
    inst.Light:Enable(false)
end 

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	inst.components.container:DropEverything()
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
	inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit")
	inst.components.container:DropEverything()
	inst.AnimState:PushAnimation("closed", false)
	inst.components.container:Close()
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed", false)	
end

local function fn(Sim)
	local inst = CreateEntity()

	inst:AddTag("freezer")

	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()    

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "freezer.tex" )

    MakeSnowCoveredPristine(inst)

    if not TheWorld.ismastersim then
    return inst
    end

    inst.entity:SetPristine()
	
    inst.AnimState:SetBank("freezer")
    inst.AnimState:SetBuild("freezer")
    inst.AnimState:PlayAnimation("closed")

    local light = inst.entity:AddLight()
    inst.Light:Enable(false)
    inst.Light:SetRadius(2)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(0/0,0/0,255/255)    


    inst:AddComponent("container")
    inst.components.container:WidgetSetup("shadowchester")    
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

    inst:AddComponent("inspectable")
    --inst.components.inspectable.getstatus = function(inst)


    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit) 
--end
    return inst
end

return Prefab( "common/freezer", fn, assets),
		MakePlacer("common/freezer_placer", "freezer", "freezer", "closed") 

