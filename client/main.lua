ESX = exports["es_extended"]:getSharedObject()
-- Do not touch this file unless you know what you are doing!
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    CreateThread(function()
        FetchSkills()

        while true do
            local seconds = Config.UpdateFrequency * 1000
            Wait(seconds)

            for skill, value in pairs(Config.Skills) do
                UpdateSkill(skill, value["RemoveAmount"])
            end

            TriggerServerEvent("skillsystem:update", json.encode(Config.Skills))
        end
    end)

    RegisterNetEvent('esx:onPlayerLogout')
    AddEventHandler('esx:onPlayerLogout', function()
        for skill, value in pairs(Config.Skills) do
            Config.Skills[skill]["Current"] = 0
        end
    end)

    CreateThread(function()
        while true do
            Wait(25000)
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsUsing(ped)
            local isDead = ESX.PlayerData.dead
            if ESX.IsPlayerLoaded and not isDead then
                if IsPedRunning(ped) then
                    UpdateSkill("Stamina", 0.1)
                elseif IsPedInMeleeCombat(ped) then
                    local isTargetting, targetEntity = GetPlayerTargetEntity(PlayerId())
                    if isTargetting and not IsEntityDead(targetEntity) and GetMeleeTargetForPed(ped) ~= 0 then
                        UpdateSkill("Strength", 0.2)
                    end
                elseif IsPedSwimmingUnderWater(ped) then
                    UpdateSkill("Lung Capacity", 0.5)
                elseif DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == ped then
                    local speed = GetEntitySpeed(vehicle) * 3.6
                    if GetVehicleClass(vehicle) == 8 or GetVehicleClass(vehicle) == 13 and speed >= 5 then
                        local rotation = GetEntityRotation(vehicle)
                        if IsControlPressed(0, 210) then
                            if rotation.x >= 25.0 then
                                UpdateSkill("Wheelie", 0.2)
                            end
                        end
                    end
                    if speed >= 80 then
                        UpdateSkill("Driving", 0.1)
                    end
                end
            end
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

CreateThread(function() -- Shooting
    while true do
        if ESX.IsPlayerLoaded then
            local ped = PlayerPedId()
            local weapon = GetSelectedPedWeapon(ped)
            if weapon ~= `WEAPON_UNARMED` then
                if IsPedShooting(ped) and not IsBlacklisteddWeapon(weapon) then
                    if math.random(1,100) < Config.ShootingSkillChance then
                        UpdateSkill("Shooting", Config.ShootingSkillUpAmount)
                    end
                end
            else
                Wait(1000)
            end
        end
        Wait(100)
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(100)
        FetchSkills()
    end
end)