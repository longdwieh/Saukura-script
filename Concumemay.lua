--// NEON HUB UI v2 (tương thích Delta, Arceus X)
local Player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

--// Giao diện chính
local ScreenGui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 600, 0, 350)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
MainFrame.Active = true
MainFrame.Draggable = true

--// Thanh bên trái
local SideBar = Instance.new("Frame", MainFrame)
SideBar.Size = UDim2.new(0, 150, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Instance.new("UICorner", SideBar).CornerRadius = UDim.new(0, 10)

local Logo = Instance.new("TextLabel", SideBar)
Logo.Size = UDim2.new(1, 0, 0, 40)
Logo.Position = UDim2.new(0, 0, 0, 10)
Logo.Text = "Neon HUB"
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 20
Logo.TextColor3 = Color3.fromRGB(255, 0, 100)
Logo.BackgroundTransparency = 1

--// Avatar
local AvatarImage = Instance.new("ImageButton", SideBar)
AvatarImage.Size = UDim2.new(0, 80, 0, 80)
AvatarImage.Position = UDim2.new(0.5, -40, 0, 60)
AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
AvatarImage.BorderSizePixel = 0
Instance.new("UICorner", AvatarImage).CornerRadius = UDim.new(1, 0)

-- Đổi ID ảnh Roblox ở đây (ví dụ ảnh đại diện bạn tải lên Roblox)
local avatarID = 111367887827717  -- thay ID bằng ảnh Roblox của bạn
AvatarImage.Image = "rbxassetid://" .. avatarID

-- Tên người chơi
local PlayerName = Instance.new("TextLabel", SideBar)
PlayerName.Size = UDim2.new(1, 0, 0, 20)
PlayerName.Position = UDim2.new(0, 0, 0, 145)
PlayerName.Text = Player.Name
PlayerName.Font = Enum.Font.GothamBold
PlayerName.TextSize = 16
PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerName.BackgroundTransparency = 1
PlayerName.TextYAlignment = Enum.TextYAlignment.Center

--// Danh sách Tab
local Tabs = {"info", "Farm", "Quest", "Stats", "Teleport", "Shop", "Misc"}
local Buttons = {}

for i, name in ipairs(Tabs) do
	local btn = Instance.new("TextButton", SideBar)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, 180 + (i * 45))
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.Text = name
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	table.insert(Buttons, btn)
end

--// Khung nội dung
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

--// Hàm tạo nút trong Content
local function createButton(parent, text, callback)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0, 200, 0, 35)
	b.Position = UDim2.new(0, 20, 0, 70)
	b.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.Font = Enum.Font.Gotham
	b.TextSize = 16
	b.Text = text
	b.MouseButton1Click:Connect(callback)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	return b
end

--// Hàm xử lý mỗi tab
local tabFunctions = {
	Farm = function(frame)
		local btn = createButton(frame, "Auto Farm Level: OFF", function(self)
			_G.AutoFarm = not _G.AutoFarm
			self.Text = "Auto Farm Level: " .. (_G.AutoFarm and "ON" or "OFF")
			while _G.AutoFarm do
				task.wait(1)
				print("Đang farm level...")
			end
		end)
	end,
	Quest = function(frame)
		local btn = createButton(frame, "Auto Quest: OFF", function(self)
			_G.AutoQuest = not _G.AutoQuest
			self.Text = "Auto Quest: " .. (_G.AutoQuest and "ON" or "OFF")
			while _G.AutoQuest do
				task.wait(1)
				print("Đang làm nhiệm vụ...")
			end
		end)
	end,
}

--// Chuyển tab
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

--// Ẩn / Hiện UI khi bấm avatar (có hiệu ứng mượt)
local uiVisible = true
AvatarImage.MouseButton1Click:Connect(function()
	uiVisible = not uiVisible
	local goal = {BackgroundTransparency = uiVisible and 0 or 1}
	local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), goal)
	tween:Play()
	task.wait(0.3)
	MainFrame.Visible = uiVisible
end)
