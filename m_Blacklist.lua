-- mazexz
local ID
local Blacklist = {
	--- IDs:
	[0] = false,

	--- Usernames:	
	['Miuseko'] = true, -- just put the username of whoever you absolutely want out of your game.

}
local reason = 'Invalid Reason' -- Change this to anything you want
local ply = game.Players.LocalPlayer
game.Players.PlayerAdded:connect(function(player)
	if Blacklist[player.UserId] or player.UserId == ID or Blacklist[player.Name] then
		player:Kick(string.format('You have been kicked for: %s.', reason))
	end
end)
