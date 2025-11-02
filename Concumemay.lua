-- Neon Hub UI (chạy ổn trên Delta)
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 600, 0, 350)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local SideBar = Instance.new("Frame", MainFrame)
SideBar.Size = UDim2.new(0, 150, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Instance.new("UICorner", SideBar).CornerRadius = UDim.new(0, 10)

local Logo = Instance.new("TextLabel", SideBar)
Logo.Size = UDim2.new(1, 0, 0, 50)
Logo.Text = "Neon HUB"
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 20
Logo.TextColor3 = Color3.fromRGB(255, 0, 100)
Logo.BackgroundTransparency = 1

local Tabs = {"Farm", "Quest", "Stats", "Teleport", "Shop", "Misc"}
local Buttons = {}

for i, name in ipairs(Tabs) do
	local btn = Instance.new("TextButton", SideBar)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, 50 + (i * 45))
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.Text = name
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	table.insert(Buttons, btn)
end

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -160, 1, 0)
ContentFrame.Position = UDim2.new(0, 160, 0, 0)
ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Instance.new("UICorner", ContentFrame).CornerRadius = UDim.new(0, 10)

local TitleLabel = Instance.new("TextLabel", ContentFrame)
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.Text = "Chọn danh mục bên trái..."
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 20
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.BackgroundTransparency = 1

-- Hàm tạo nút chức năng
local function createButton(parent, text, callback)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0, 200, 0, 35)
	b.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.Font = Enum.Font.Gotham
	b.TextSize = 16
	b.Text = text
	b.MouseButton1Click:Connect(callback)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	return b
end

-- Chức năng tab
local tabFunctions = {
	Farm = function(frame)
		local autoFarm = createButton(frame, "Auto Farm Level: OFF", function(btn)
			_G.AutoFarm = not _G.AutoFarm
			btn.Text = "Auto Farm Level: " .. (_G.AutoFarm and "ON" or "OFF")
			while _G.AutoFarm do
				task.wait(1)
				print("Đang farm level...")
				-- Thêm code farm thật ở đây (TP tới quái, đánh, v.v.)
			end
		end)
		autoFarm.Position = UDim2.new(0, 20, 0, 70)
	end,

	Quest = function(frame)
		local quest = createButton(frame, "Auto Quest: OFF", function(btn)
			_G.AutoQuest = not _G.AutoQuest
			btn.Text = "Auto Quest: " .. (_G.AutoQuest and "ON" or "OFF")
			while _G.AutoQuest do
				task.wait(1)
				print("Đang làm nhiệm vụ...")
			end
		end)
		quest.Position = UDim2.new(0, 20, 0, 70)
	end,

	Stats = function(frame)
		local stats = createButton(frame, "Auto Stats: OFF", function(btn)
			_G.AutoStats = not _G.AutoStats
			btn.Text = "Auto Stats: " .. (_G.AutoStats and "ON" or "OFF")
			while _G.AutoStats do
				task.wait(2)
				print("Phân bổ điểm chỉ số...")
			end
		end)
		stats.Position = UDim2.new(0, 20, 0, 70)
	end,

	Teleport = function(frame)
		local tp = createButton(frame, "Teleport to Start Island", function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 20, 0)
		end)
		tp.Position = UDim2.new(0, 20, 0, 70)
	end,

	Shop = function(frame)
		local shop = createButton(frame, "Mở Shop", function()
			print("Mở cửa hàng (chưa làm thật).")
		end)
		shop.Position = UDim2.new(0, 20, 0, 70)
	end,

	Misc = function(frame)
		local fps = createButton(frame, "FPS Boost", function()
			print("Đang giảm đồ họa để tăng FPS...")
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
			end
		end)
		fps.Position = UDim2.new(0, 20, 0, 70)

		local autoclick = createButton(frame, "Auto Click: OFF", function(btn)
			_G.AutoClick = not _G.AutoClick
			btn.Text = "Auto Click: " .. (_G.AutoClick and "ON" or "OFF")
			while _G.AutoClick do
				task.wait(0.3)
				game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
				game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0))
			end
		end)
		autoclick.Position = UDim2.new(0, 20, 0, 120)
	end
}

-- Chuyển tab
for _, btn in pairs(Buttons) do
	btn.MouseButton1Click:Connect(function()
		for _, other in pairs(Buttons) do
			other.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
		end
		btn.BackgroundColor3 = Color3.fromRGB(70, 50, 120)
		TitleLabel.Text = "Tab: " .. btn.Text

		for _, v in pairs(ContentFrame:GetChildren()) do
			if v:IsA("TextButton") and v ~= TitleLabel then v:Destroy() end
		end

		if tabFunctions[btn.Text] then
			tabFunctions[btn.Text](ContentFrame)
		end
	end)
end
