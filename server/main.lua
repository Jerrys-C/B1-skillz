lib.callback.register('skillsystem:initCharacter', function(source)
	local Player = exports.qbx_core:GetPlayer(source).PlayerData
	if Player then
		local row = exports.oxmysql:single_async('SELECT * FROM player_skills WHERE citizenid = ?', { Player.citizenid })
		if not row then
			MySQL.Async.execute('INSERT INTO player_skills (citizenid, stamina, strength, lung_capacity, shooting) VALUES (?, ?, ?, ?, ?)', {
				Player.citizenid, 0, 0, 0, 0
			})
		end
	end
end)


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
	if not Player then return end
	data = json.decode(data)
	MySQL.update('UPDATE player_skills SET stamina = ?, strength = ?, lung_capacity = ?, shooting = ? WHERE citizenid = ?', {
		data.stamina, data.strength, data.lung_capacity, data.shooting, Player.citizenid
	})
end)
