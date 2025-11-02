--// Tải thư viện Orion UI
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

--// Tạo cửa sổ chính (Window)
local Window = OrionLib:MakeWindow({
    Name = "Neon Hub", 
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "NeonHub"
})

--// Tạo danh mục (Tabs)
local Tabs = {
	Main = Window:MakeTab({Name = "Tab Farming", Icon = "rbxassetid://4483345998", PremiumOnly = false}),
	Settings = Window:MakeTab({Name = "Tab Local Player", Icon = "rbxassetid://4483345998", PremiumOnly = false}),
	Prehistoric = Window:MakeTab({Name = "Tab Prehistoric Event", Icon = "rbxassetid://4483345998", PremiumOnly = false}),
	Dragon = Window:MakeTab({Name = "Tab Dragon Dojo", Icon = "rbxassetid://4483345998", PremiumOnly = false}),
}

--// Thêm chức năng trong tab "Main"
Tabs.Main:AddToggle({
	Name = "Auto Farm Level",
	Default = false,
	Callback = function(Value)
		_G.AutoFarm = Value
		print("Auto Farm:", Value)
	end    
})

--// Thêm nút trong tab "Settings"
Tabs.Settings:AddButton({
	Name = "Teleport to Start Island",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
	end    
})

--// Bắt đầu UI
OrionLib:Init()
