local http = game.HttpService
local module = require(loadstring(game:HttpGet(('https://raw.githubusercontent.com/Lunoq/fischinfmoneygui/refs/heads/main/script.lua'))))()

local a = module.MakeWindow("rod")

local ab = module.AddButton("get inf money + all rod (not reversable)",a,Color3.new(1, 0.145098, 0.258824),function()
	local rodsFolder = game:GetService("ReplicatedStorage").resources.items.rods
	if not rodsFolder then
		warn("Folder Rods not found")
		return
	end

	local purchaseEvent = game:GetService("ReplicatedStorage").events.purchase
	local quantity = math.huge

	for _, rod in ipairs(rodsFolder:GetChildren()) do
		if rod:IsA("Folder") then
			local rodName = rod.Name
			purchaseEvent:FireServer(rodName, "Rod", nil, quantity)
		end
	end
end)
