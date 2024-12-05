lib.callback.register('skillsystem:fetchStatus', function()
	local Player = exports.qbx_core:GetPlayer(source).PlayerData
	if Player then
		local row = exports.oxmysql:single_async('SELECT * FROM player_skills WHERE citizenid = ?', { Player.citizenid })
		if not row then return end
		return row
	end
 end)


lib.callback.register('skillsystem:update', function (source, data)
	local Player = exports.qbx_core:GetPlayer(source).PlayerData
	data = json.decode(data)
	MySQL.update('UPDATE player_skills SET stamina = ?, strength = ?, lung_capacity = ?, shotting = ? WHERE citizenid = ?', {
		data.stamina, data.strength, data.lung_capacity, data.shotting, Player.citizenid
	})
end)
