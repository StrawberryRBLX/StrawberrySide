local logserv = game:GetService("LogService")
local module = {
	Cleanup = function()
		print(string.rep("\n",500))
		logserv:ClearOutput()
	end,
	FakeLogs = function()
		for _ = 1,250 do
			warn("Humanoid:Move() is deprecated. Did you mean Player:Move?")
			warn("Humanoid:Move() is deprecated. Did you mean Player:Move? ")
		end
	end,
} return module
