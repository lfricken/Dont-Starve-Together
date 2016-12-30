PrefabFiles = {
	"bigfoot",
	"glommerbell",
}


local ACTIONS = GLOBAL.ACTIONS
local AllRecipes = GLOBAL.AllRecipes
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local EventHandler = GLOBAL.EventHandler
local FRAMES = GLOBAL.FRAMES
local SpawnPrefab = GLOBAL.SpawnPrefab
local State = GLOBAL.State
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local TimeEvent = GLOBAL.TimeEvent
local TUNING = GLOBAL.TUNING


local function DX_GetUpvalue(func, name)
	local debug = GLOBAL.debug
	local i = 1
	while true do
		local n, v = debug.getupvalue(func, i)
		if not n then
			return nil, nil
		end
		if n == name then
			return v, i
		end
		i = i + 1
	end
end

local function DX_SetUpvalue(func, ind, value)
	local debug = GLOBAL.debug
	debug.setupvalue(func, ind, value)
end


local recipeunlock = GetModConfigData("Recipe")

local bell_statue = recipeunlock == "Statue"

local bell_ingredients = {Ingredient("glommerwings", 1), Ingredient("glommerflower", 1)}
local bell_tab = bell_statue and RECIPETABS.MAGIC or RECIPETABS.ANCIENT
local bell_tech = bell_statue and TECH.LOST or TECH.ANCIENT_FOUR
local bell_nounlock = not bell_statue and true or nil

AddRecipe("bell", bell_ingredients, bell_tab, bell_tech, nil, nil, bell_nounlock, nil, nil, "images/inventoryimages/bell.xml", "bell.tex")

AllRecipes["bell"].sortkey = 0


local function AddBigFooter(inst)
	if inst.ismastersim then
		inst:AddComponent("bigfooter")

		if bell_statue then
			local statueglommer_fn = GLOBAL.Prefabs["statueglommer"].fn
			local OnInit, OnInit_index = DX_GetUpvalue(statueglommer_fn, "OnInit")
			local OnWorked, OnWorked_index = DX_GetUpvalue(statueglommer_fn, "OnWorked")
			local OnLoadWorked, OnLoadWorked_index = DX_GetUpvalue(statueglommer_fn, "OnLoadWorked")
			local OnIsFullmoon, OnIsFullmoon_index = DX_GetUpvalue(OnInit, "OnIsFullmoon")

			local function PlayerLearnsBell(worker)
				worker.sg:GoToState("learn_bell")
			end
			local function TeachBellToWorker(inst, data)
				local worker = data and data.worker
				local worker_builder = worker and worker.components.builder
				if worker_builder and not table.contains(worker_builder.recipes, "bell") then
					worker:DoTaskInTime(1 + 2 * math.random(), PlayerLearnsBell)
				end
			end

			local old_OnIsFullmoon = OnIsFullmoon
			local new_OnIsFullmoon = function(inst, isfullmoon)
				if isfullmoon and inst.components.workable == nil and inst.components.lootdropper == nil then
					inst.SoundEmitter:PlaySound("dontstarve/sanity/shadowrock_down")
					inst.AnimState:PlayAnimation("full")
					inst:AddComponent("workable")
					inst.components.workable:SetWorkAction(ACTIONS.MINE)
					inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
					inst.components.workable:SetOnWorkCallback(OnWorked)
					inst.components.workable.savestate = true
					inst.components.workable:SetOnLoadFn(OnLoadWorked)
					inst:AddComponent("lootdropper")
					inst.components.lootdropper:SetChanceLootTable("statueglommer")

					local px, py, pz = inst.Transform:GetWorldPosition()
					local fx1 = SpawnPrefab("sanity_lower")
					local fx2 = SpawnPrefab("collapse_big")
					fx1.Transform:SetPosition(px, py, pz)
					fx2.Transform:SetPosition(px, py, pz)	
				end
				if inst.components.workable and not inst.bell_learning_enabled then
					inst.bell_learning_enabled = true
					inst:ListenForEvent("workfinished", TeachBellToWorker)
				end
				return old_OnIsFullmoon(inst, isfullmoon)
			end

			DX_SetUpvalue(OnInit, OnIsFullmoon_index, new_OnIsFullmoon)
		end
	end
end

AddPrefabPostInit("world", AddBigFooter)


if bell_statue then
	local unlock_fn = function(inst)
		inst.components.builder:UnlockRecipe("bell")
	end

	AddStategraphState("wilson", State {
		name = "learn_bell",
		tags = {"busy", "pausepredict", "nomorph"},

		onenter = function(inst)
			inst.sg.statemem.unlockbell = unlock_fn
			inst.AnimState:OverrideSymbol("shadow_hands", "shadow_skinchangefx", "shadow_hands")
			inst.AnimState:OverrideSymbol("shadow_ball", "shadow_skinchangefx", "shadow_ball")
			inst.AnimState:OverrideSymbol("splode", "shadow_skinchangefx", "splode")
			inst.AnimState:PlayAnimation("skin_change", false)
			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:RemotePausePrediction()
			end
			inst.components.locomotor:Stop()
		end,

		timeline = {
			TimeEvent(0 * FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/HUD/Together_HUD/skin_change")
			end),
			TimeEvent(42 * FRAMES, function(inst)
				if inst.sg.statemem.unlockbell ~= nil then
					inst.sg.statemem.unlockbell(inst)
					inst.sg.statemem.unlockbell = nil
				end
			end)
		},

		events = {
			EventHandler("animqueueover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("idle")
				end
			end),
		},

		onexit = function(inst)
			if inst.sg.statemem.unlockbell ~= nil then
				inst.sg.statemem.unlockbell(inst)
				inst.sg.statemem.unlockbell = nil
			end
			inst.AnimState:OverrideSymbol("shadow_hands", "shadow_hands", "shadow_hands")
			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:EnableMapControls(true)
				inst.components.playercontroller:Enable(true)
			end
			inst.components.inventory:Show()
			inst:ShowActions(true)
		end,
	})
end


-- Movement prediction client fix to see bell playing animation

AddStategraphState("wilson", State {
	name = "play_bell",
	tags = {"doing", "playing"},

	onenter = function(inst)
		inst.components.locomotor:Stop()
		inst.AnimState:PlayAnimation("action_uniqueitem_pre")
		inst.AnimState:PushAnimation("bell", false)
		inst.AnimState:OverrideSymbol("bell01", "bell", "bell01")
		inst.AnimState:Show("ARM_normal")
		inst.components.inventory:ReturnActiveActionItem(inst.bufferedaction ~= nil and inst.bufferedaction.invobject or nil)
	end,

	timeline = {
		TimeEvent(15 * FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/glommer_bell")
		end),
		TimeEvent(60 * FRAMES, function(inst)
			inst:PerformBufferedAction()
		end),
	},

	events = {
		EventHandler("animover", function(inst)
			if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle")
			end
		end),
	},

	onexit = function(inst)
		if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
			inst.AnimState:Show("ARM_carry") 
			inst.AnimState:Hide("ARM_normal")
		end
	end,
})
