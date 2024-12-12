-- sort keys into an array then iterate the sorted array and return key & value
local function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
    end
    return iter
end

local function createSkillMenu()
    local skillMenu = {}

    skillMenu[#skillMenu + 1] = {
        title = 'Skills',
        description = nil,
        icon = 'fas fa-chart-simple',
        isHeader = true
    }

    for k, v in pairsByKeys(Config.Skills) do
        skillMenu[#skillMenu + 1] = {
            title = k,
            description = string.format('%s%%', v['Current']),
            icon = v['icon'],
            args = {skill = k, level = v['Current']}
        }
    end

    lib.registerContext({
        id = 'skill_menu',
        title = 'Player Skills',
        options = skillMenu
    })
    lib.showContext('skill_menu')
end

RegisterNUICallback('close', function()
    SendNUIMessage({action = "close"})
    SetNuiFocus(false)
end)

RegisterCommand(Config.Skillmenu, function()
    createSkillMenu()
end)
