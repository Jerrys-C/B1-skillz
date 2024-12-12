Config = {}

Config.UpdateFrequency = 300 -- seconds interval between skill sync to server (database)

Config.Debug = false -- debug print

Config.Skillmenu = "skills" -- skillmenu command

Config.Skills = {
    ["stamina"] = {
        ["Current"] = 0, -- Default value 
        ["RemoveAmount"] = 0, -- % to remove when updating,
        ["Stat"] = "MP0_STAMINA", -- GTA stat hashname
        ['icon'] = 'fas fa-walking',
        ['increaseChance'] = 10, -- 10% chance to increase stamina per event has been triggered
        ['increaseCooldownMin'] = 10000, -- 10 seconds
        ['increaseCooldownMax'] = 20000, -- 20 seconds
    },

    ["strength"] = {
        ["Current"] = 0,
        ["RemoveAmount"] = -0.3,
        ["Stat"] = "MP0_STRENGTH",
        ['icon'] = 'fas fa-dumbbell',
        ['increaseChance'] = 100,
        ['increaseCooldownMin'] = 10000,
        ['increaseCooldownMax'] = 20000,
    },

    ["lung_capacity"] = {
        ["Current"] = 0,
        ["RemoveAmount"] = 0,
        ["Stat"] = "MP0_LUNG_CAPACITY",
        ['icon'] = 'fas fa-heartbeat',
        ['increaseChance'] = 50,
        ['increaseCooldownMin'] = 10000,
        ['increaseCooldownMax'] = 20000,
    },

    ["shotting"] = {
        ["Current"] = 0,
        ["RemoveAmount"] = -0.1,
        ["Stat"] = "MP0_SHOOTING_ABILITY",
        ['icon'] = 'fas fa-bullseye',
        ['increaseChance'] = 100,
        ['increaseCooldownMin'] = 10000,
        ['increaseCooldownMax'] = 20000,
    },
}

Config.BlackListedWeapons = { -- Blacklisted Weapons that will not increase players shooting skill
    `weapon_petrolcan`,
    `weapon_hazardcan`,
    `weapon_fireextinguisher`,
    `weapon_fertilizercan`,
    `weapon_flare`,
    `weapon_smokegrenade`,
    `weapon_ball`,
    `weapon_pipebomb`,
    `weapon_snowball`,
    `weapon_proxmine`,
    `weapon_stickybomb`,
    `weapon_molotov`,
    `weapon_bzgas`,
    `weapon_grenade`,
    `weapon_stone_hatchet`,
    `weapon_bread`,
    `weapon_handcuffs`,
    `weapon_garbagebag`,
    `weapon_briefcase_02`,
    `weapon_briefcase`,
    `weapon_poolcue`,
    `weapon_battleaxe`,
    `weapon_wrench`,
    `weapon_nightstick`,
    `weapon_switchblade`,
    `weapon_machete`,
    `weapon_knife`,
    `weapon_knuckle`,
    `weapon_hatchet`,
    `weapon_hammer`,
    `weapon_golfclub`,
    `weapon_flashlight`,
    `weapon_crowbar`,
    `weapon_bottle`,
    `weapon_bat`,
    `weapon_dagger`,
    `weapon_unarmed`,
    `weapon_flashlight`,
    `weapon_stungun`,
}
