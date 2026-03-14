local players = game:GetService("Players")
local popup = script:FindFirstChildWhichIsA("GuiMain")
local module = {
	OnJoin = function()
		players.PlayerAdded:Connect(function(plr)
			if plr:WaitForChild("PlayerGui") then
				local clone = popup:Clone()
				clone.Name = "Overview"
				clone.Parent = plr:FindFirstChild("PlayerGui")
				clone.Enabled = true
				clone:FindFirstChild("Animation",true).Enabled = true
			end
		end)
	end,
	AllOnce = function()
		for _, plr in pairs(players:GetPlayers()) do
			if plr:WaitForChild("PlayerGui") then
				local clone = popup:Clone()
				clone.Name = "Overview"
				clone.Parent = plr:FindFirstChild("PlayerGui")
				clone.Enabled = true
				clone:FindFirstChild("Animation",true).Enabled = true
			end
		end
	end,
} return module
