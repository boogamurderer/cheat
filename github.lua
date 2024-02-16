--------------------- Key System V.04 --------------------------------------------------------


-------------------------- Keys

_G.Key = "9f09f869-3cef-4b2a-a030-b55f5dfd5b"  --------------------------- Current Key

local keys = {
	["9f09f869-3cef-4b2a-a030-b55f5dfd3c5b"] = true, -------------- Key 1
	["CA1W8T2psiqVgtSeLFzaMikCJy5raricC4j1erNk1D9bkBSxra"] = true, -------------- Key 2
	["5Bqp7fBOa7fmnIdbOOIoowGR3Qidhm2irb2LMlQe6HpfVK26IB"] = true -------------- Key 2
}









---------------------------

------------------------------------------ Whitelisted Successfully Worked!
if keys[_G.Key] == true then
	-------------------------------------------------------------------------------------------------           

	local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")() -- Self explaining

	_G.closeBind = Enum.KeyCode.C

	local win = lib:Window("Title", "Subtitle", Color3.fromRGB(255, 110, 48), _G.closeBind) -- _G.closeBind is the bind to close the gui, kinda cool for a bind in your GUI



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
