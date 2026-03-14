local http = game:GetService("HttpService")
local run = game:GetService("RunService")
local testurl = "https://api.ipify.org/" -- Note: We are not using this as a IP logger, as this is for checking if HttpService is on, since it's not a website that will get ratelimited.
local module = {
	Http = function()
		local success,_ = pcall(function()
			return http:GetAsync(testurl)
		end)
		if success then
			return true
		else
			return false
		end
	end,
	Studio = function()
		if run:IsStudio() then
			return true
		else
			return false
		end
	end
} return module
