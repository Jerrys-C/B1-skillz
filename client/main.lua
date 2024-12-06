local function updateServerSkill()
    local strength = Config.Skills.strength.Current
    local stamina = Config.Skills.stamina.Current
    local lung_capacity = Config.Skills.lung_capacity.Current
    local shotting = Config.Skills.shotting.Current
    local skillData = {
        strength = strength,
        stamina = stamina,
        lung_capacity = lung_capacity,
        shotting = shotting
    }
    lib.callback.await("skillsystem:update", false, json.encode(skillData))
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CreateThread(function()
        FetchSkills()
        while true do
            local seconds = Config.UpdateFrequency * 1000
            Wait(seconds)

            for skill, value in pairs(Config.Skills) do
                UpdateSkill(skill, value["RemoveAmount"])
            end
            updateServerSkill()
        end
    end)
end)


local function IsBlacklisteddWeapon(weapon)
    if weapon then
        for _, v in pairs(Config.BlackListedWeapons) do
            if weapon == v then
                return true
            end
        end
    end
    return false
end


AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(100)
        FetchSkills()
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        updateServerSkill()
    end
end)

AddEventHandler('onPlayerDropped', function()
    updateServerSkill()
end)

local StaminaCooldown = false
AddEventHandler('CEventShockingRunningPed', function(_, ped)
    if StaminaCooldown then return end
    if ped == cache.ped and math.random(1, 100) <= Config.Skills.stamina.increaseChance then
        UpdateSkill("stamina", 0.1)
        StaminaCooldown = true
        SetTimeout(math.random(Config.Skills.stamina.increaseCooldownMin, Config.Skills.stamina.increaseCooldownMax), function()
            StaminaCooldown = false
        end)
    end
end)

local ShootingCooldown = false
AddEventHandler('CEventGunShot', function(_, ped)
    if ShootingCooldown then return end
    if ped == cache.ped and math.random(1, 100) <= Config.Skills.shotting.increaseChance then
        UpdateSkill("shotting", 0.1)
        ShootingCooldown = true
        SetTimeout(math.random(Config.Skills.shotting.increaseCooldownMin, Config.Skills.shotting.increaseCooldownMax), function()
            ShootingCooldown = false
        end)
    end
end)


local SterngthCooldown = false
AddEventHandler('CEventShockingSeenMeleeAction', function(_, ped)
    if SterngthCooldown then return end
    if ped == cache.ped and math.random(1, 100) <= Config.Skills.strength.increaseChance then
        UpdateSkill("strength", 0.1)
        SterngthCooldown = true
        SetTimeout(math.random(Config.Skills.strength.increaseCooldownMin, Config.Skills.strength.increaseCooldownMax), function()
            SterngthCooldown = false
        end)
    end
end)


local LungCapacityCooldown = false
local underWaterDamage = 1090519040
local function OnEntityDamage(args)
    local victim = args[1]
    if victim == cache.ped then
        if args[3] == underWaterDamage and math.random(1, 100) <= Config.Skills.lung_capacity.increaseChance then
            UpdateSkill("lung_capacity", 0.1)
            LungCapacityCooldown = true
            SetTimeout(math.random(Config.Skills.lung_capacity.increaseCooldownMin, Config.Skills.lung_capacity.increaseCooldownMax), function()
                LungCapacityCooldown = false
            end)
        end
    end
end


AddEventHandler('gameEventTriggered', function (event, args)
    if LungCapacityCooldown then return end
	if event == "CEventNetworkEntityDamage" then
        OnEntityDamage(args)
    end
  end)
