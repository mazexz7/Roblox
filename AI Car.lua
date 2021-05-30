-- AI Car that randomly drives
-- Kind of a boring thing but might be helpful

-- You must have workspace.Terrain.Bots folder instance; inside add an `ObjectValue` and give it your car as value
wait(1)
local seat = script.Parent
local players = game:GetService('Players')
local bots = workspace:WaitForChild('Terrain'):WaitForChild('Bots')
local myName = seat.Parent.Name

local hasPlayers = false
local hasBots = false

local function accelerate()
	seat.Throttle = 1
end

local function deccelerate()
	seat.Throttle = 0
end

local function reverse()
	seat.Throttle = -1
end

local function steerRight(n)
	seat.Steer = n
end

local function steerLeft(n)
	seat.Steer = -n
end

local function unsteer()
	seat.Steer = 0
end

local functions = {
	[1] = accelerate,
	[2] = deccelerate,
	[3] = reverse,
	[4] = steerRight,
	[5] = steerLeft,
	[6] = unsteer
}

local function getSeatPosition()
	return seat.Position
end

local function getPlayerList()
	return players:GetPlayers()
end

local function getBotList()
	return bots:GetChildren()	
end	

local function getPlayerPosition(player)
	local X = 0
	local Y = 0
	local Z = 0
	if player.Character then
		if player.Character:FindFirstChild('HumanoidRootPart') then
			H = player.Character.HumanoidRootPart
			X = H.Position.X
			Y = seat.Position.Y
			Z = H.Position.Z
		end
	end
	local Position = Vector3.new(X, Y, Z)
	return Position
end

local function getBotPosition(bot)
	local X = 0
	local Y = 0
	local Z = 0
	if bot.Value ~= nil and bot.Value.Name ~= myName then
		if bot.Value:FindFirstChild('VehicleSeat') then
			H = bot.Value.VehicleSeat
			X = H.Position.X
			Y = seat.Position.Y
			Z = H.Position.Z
		end
	end
	local Position = Vector3.new(X, Y, Z)
	return Position
end

local function r(n, m)
	return math.random(n, m)
end

local function randomDrive()
	functions[1]()
	wait(r(1, 3))
	functions[r(4, 6)](r(1, 5)*10)
	wait(r(1, 3))
	functions[r(4, 6)](r(1, 5)*10)
end

local function driveTo(X, Y, Z)
	while wait(.04) do
		functions[1]()
		if getSeatPosition().X > X then
			repeat 
				wait(.04)
				functions[4](15)
			until getSeatPosition().X - X < 5
		elseif getSeatPosition().X < X then
			repeat 
				wait(.04)
				functions[5](15)
			until getSeatPosition().X + X < 5
		else
			functions[6]()
		end
	end
end

local function botOrPlayer()
	is = 0
	if math.random(1, 2) == 1 then
		is = 1
	else
		is = 2
	end
	return is
end
local function findDriver()
	local n_Players = getPlayerList()
	local n_Bots = getBotList()
	local p = 0
	local b = 0
	p = #n_Players
	b = #n_Bots
	if p > 0 then
		hasPlayers = true
	elseif p <= 0 then
		hasPlayers = false
	end
	if b > 0 then
		hasBots = true
	elseif b <= 0 then
		hasBots = false
	end
	if hasPlayers == true and hasBots == true then
		if botOrPlayer() == 1 then
			for _, player in pairs(n_Players) do
				POS = getPlayerPosition(player)
				driveTo(POS.X, POS.Y, POS.Z)
			end
		elseif botOrPlayer() == 2 then
			for _, bot in pairs(n_Bots) do
				POS = getBotPosition(bot)
				driveTo(POS.X, POS.Y, POS.Z)
			end
		end
	elseif hasPlayers == true then
		for _, player in pairs(n_Players) do
			POS = getPlayerPosition(player)
			driveTo(POS.X, POS.Y, POS.Z)
		end
	elseif hasBots == true then
		for _, bot in pairs(n_Bots) do
			POS = getBotPosition(bot)
			driveTo(POS.X, POS.Y, POS.Z)
		end
	end
end

findDriver()
