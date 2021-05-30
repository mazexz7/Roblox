--- mazexz
---TODO: user tags/colors
---		gamepass tags/colors
local Players = game:GetService('Players')
local ServerScriptService = game:GetService('ServerScriptService')
local ChatService = require(ServerScriptService:WaitForChild('ChatServiceRunner'):WaitForChild('ChatService'))
local FakeGroup = {
	{
		GroupId = 1156259,
		Members = {
			{
				Name = 'Player1',
				Rank = 1337
			},
			{
				Name = 'VSTnex',
				Rank = 252
			},
			{
				Name = 'KazuyuaSan',
				Rank = 252
			},
			{
				Name = 'BogdanMarin302',
				Rank = 1337
			},
		--	{
		--		Name = 'glucowse',
		--		Rank = 252
		--	},
		}
	},
}

local GroupTags = {
	{
		GroupId = 1156259,
		Tags = {
			{
				Tag = 'Owner',
				Color = Color3.fromRGB(0, 115, 255),
				Rank = 255,
			},
			{
				Tag = 'Bot',
				Color = Color3.fromRGB(0, 115, 255),
				Rank = 254,
			},
			{
				Tag = 'Developer',
				Color = Color3.fromRGB(255, 47, 50),
				Rank = 253,
			},
			{
				Tag = 'Friend',
				Color = Color3.fromRGB(255, 163, 33),
				Rank = 252,
			},
			{
				Tag = 'Noticed',
				Color = Color3.fromRGB(24, 138, 77),
				Rank = 251,
			},	
			{
				Tag = 'VIP',
				Color = Color3.fromRGB(255, 216, 124),
				Rank = 248,
			},
			{
				Tag = 'Donator',
				Color = Color3.fromRGB(255, 138, 209),
				Rank = 2,
			},
			{
				Tag = 'Member',
				Color = Color3.fromRGB(149, 149, 149),
				Rank = 1,
			},
			{
				Tag = 'Owner',
				Color = Color3.fromRGB(0, 115, 255),
				Rank = 250,
			},
			{
				Tag = 'Wra',
				Color = Color3.fromRGB(59, 0, 255),
				Rank = 1337
			}
		}
	},
}

local VIP = {
	Usernames = {
	--	{
	--		Name = 'ohkaii',
	--		Tag = '<3',
	--		Color = Color3.fromRGB(255, 137, 224)
	--	},
		{
			Name = 'idelww',
			Tag = 'Brother',
		},
		{
			Name = 'BogdanMarin302',
			Tag = 'Wra',
		},
		{
			Name = 'v_lse',
			Tag = 'Best Friend'
		},
		{
			Name = 'gliscorhero1',
			Tag = 'Budiinz',
		},
		{
			Name = 'Player1',
			Tag = 'Tag',
		}
	}
}

ChatService.SpeakerAdded:Connect(function(PlayerName)
	local Speaker = ChatService:GetSpeaker(PlayerName)
	if Players:FindFirstChild(PlayerName) then
		local Player = Players[PlayerName]
		for _, group in pairs(GroupTags) do
			for i, v in pairs(group.Tags) do
				local Rank = v.Rank
				if Player:GetRankInGroup(group.GroupId) == Rank then
					Speaker:SetExtraData('Tags',{{TagText = v.Tag, TagColor = v.Color}})
				--	Speaker:SetExtraData('ChatColor', v.Color)
					for _, player in pairs(VIP.Usernames) do
						local clr = player.Color or v.Color
						local tag = player.Tag
						local name = player.Name
						if Player.Name == name then
							Speaker:SetExtraData('Tags', {{TagText = tag, TagColor = clr}})
						end
					end
				else
					for _, group in pairs(FakeGroup) do
						local groupid = group.GroupId
						for _, member in pairs(group.Members) do
							local name = member.Name
							local rank = member.Rank
							if Player.Name == name then
								for _, group in pairs(GroupTags) do
									for i, v in pairs(group.Tags) do
										if v.Rank == rank then
											local clr = v.Color
											local tag= v.Tag
											Speaker:SetExtraData('Tags', {{TagText = tag, TagColor = clr}})
										--	Speaker:SetExtraData('ChatColor', clr)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		for _, group in pairs(GroupColors) do
			if Player:IsInGroup(group.GroupId) then
				Speaker:SetExtraData('ChatColor', group.Color)
			end
		end
	end
end)

warn('Loading m_NewExtraDataInitializer')
