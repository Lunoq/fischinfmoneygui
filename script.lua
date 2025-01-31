local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "safe gui", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
 
 
Tab:AddLabel("FISCH INF MONEY <<")
 
 
Tab:AddButton({
	Name = "Get inf money and all rods(devs include)",
	Callback = function()
 
		OrionLib:MakeNotification({
			Name = ".",
			Content = ".",
			Image = "rbxassetid://4483345998",
			Time = 5
		})
 
 
		local function purchaseRods()
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
		end
 
 
		purchaseRods()
		task.delay(1, purchaseRods) 
	end
})
 
 
Tab:AddSection({Name = "Buy any item"})
 
 
local itemsFolder = game:GetService("ReplicatedStorage").resources.items.items
local itemOptions = {}
 
if itemsFolder then
	for _, item in ipairs(itemsFolder:GetChildren()) do
		if item:IsA("Folder") then
			table.insert(itemOptions, item.Name)
		end
	end
else
	warn("Items folder not found")
end
 
 
local selectedItem = ""
local selectedAmount = 1
 
 
Tab:AddDropdown({
	Name = "Item",
	Default = itemOptions[1] or "None",
	Options = itemOptions,
	Callback = function(Value)
		selectedItem = Value
		print("Selected item:", selectedItem)
	end    
})
 
 
Tab:AddTextbox({
	Name = "Amount",
	Default = "Amount of items",
	TextDisappear = true,
	Callback = function(Value)
		local amount = tonumber(Value)
		if amount and amount > 0 then
			selectedAmount = amount
			print("Selected amount:", selectedAmount)
		else
			warn("Invalid amount entered")
		end
	end	  
})
 
 
Tab:AddButton({
	Name = "Buy selected item",
	Callback = function()
		if selectedItem == "" then
			warn("No item selected")
			return
		end
 
		game:GetService("ReplicatedStorage").events.purchase:FireServer(selectedItem, "Item", nil, selectedAmount)
		print("Purchased", selectedAmount, selectedItem)
	end
})
 
Tab:AddLabel("NUKES AND TREASURE MAPS DOESNT STACK")
