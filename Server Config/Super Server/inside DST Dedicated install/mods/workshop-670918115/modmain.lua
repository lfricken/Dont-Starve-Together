-- #############################################################################
-- Removes Thermal Stone durability
-- #############################################################################

-- These represent the boundaries between the ranges (relative to ambient, so ambient is always "0")
relative_temperature_thresholds = { -30, -10, 10, 30 }

function GetRangeForTemperature(temp, ambient)
    local range = 1
    for i,v in ipairs(relative_temperature_thresholds) do
        if temp > ambient + v then
            range = range + 1
        end
    end
    return range
end

function UpdateImages(inst, range)
    inst.currentTempRange = range

    inst.AnimState:PlayAnimation(tostring(range), true)
    inst.components.inventoryitem:ChangeImageName("heat_rock"..tostring(range))
    if range == 5 then
        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        inst._light.Light:Enable(true)
    else
        inst.AnimState:ClearBloomEffectHandle()
        inst._light.Light:Enable(false)
    end
end

function AdjustLighting(inst, range)
    if range == 5 then
        local relativetemp = inst.components.temperature:GetCurrent() - GLOBAL.TheWorld.state.temperature
        local baseline = relativetemp - relative_temperature_thresholds[4]
        local brightline = relative_temperature_thresholds[4] + 20
        inst._light.Light:SetIntensity( math.clamp(0.5 * baseline/brightline, 0, 0.5 ) )
    else
        inst._light.Light:SetIntensity(0)
    end
end

AddPrefabPostInit("heatrock", function (inst)
	if not GLOBAL.TheWorld.ismastersim then
		return
	end
	inst.event_listeners["temperaturedelta"] = {}
	inst:ListenForEvent("temperaturedelta", function (inst, data)
        -- body
        local range = GetRangeForTemperature(inst.components.temperature:GetCurrent(), GLOBAL.TheWorld.state.temperature)
        AdjustLighting(inst, range)
        if range ~= inst.currentTempRange then

            UpdateImages(inst, range)

            if range == 5 or range == 1 then
                inst.reachedHighTemp = true
            end

        end
    end)
	inst.currentTempRange = 0

	inst:RemoveComponent("fueled")
end)


