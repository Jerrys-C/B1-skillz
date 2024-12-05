
FetchSkills = function()
    lib.callback("skillsystem:fetchStatus", false, function(data)
        if data then
            for status, value in pairs(data) do
                if Config.Skills[status] then
                    Config.Skills[status]["Current"] = value or 0
                end
            end
        end
        RefreshSkills()
    end)
end

GetCurrentSkill = function(skill)
    return Config.Skills[skill]
end

exports('GetCurrentSkill', GetCurrentSkill)

UpdateSkill = function(skill, amount)

    if not Config.Skills[skill] then
        print("Skill " .. skill .. " doesn't exist")
        return
    end

    local SkillAmount = Config.Skills[skill]["Current"]
    
    if SkillAmount + tonumber(amount) < 0 then
        Config.Skills[skill]["Current"] = 0
    elseif SkillAmount + tonumber(amount) > 100 then
        Config.Skills[skill]["Current"] = 100
    else
        Config.Skills[skill]["Current"] = SkillAmount + tonumber(amount)
    end

    RefreshSkills()
end

exports('UpdateSkill', UpdateSkill)


local function round(num)
    return math.floor(num+.5)
end

RefreshSkills = function()
    for type, value in pairs(Config.Skills) do
        if Config.Debug then
            print(type .. ": " .. value['Current'])
        end
        if value["Stat"] then
            StatSetInt(value["Stat"], round(value["Current"]), true)
        end
    end
end

exports('CheckSkill', function(skill, val, hasskill)
    if Config.Skills[skill] then
        if Config.Skills[skill]["Current"] >= tonumber(val) then
            hasskill(true)
        else
            hasskill(false)
        end
    else
        print("Skill " .. skill .. " doesn't exist")
        hasskill(false)
    end
end)