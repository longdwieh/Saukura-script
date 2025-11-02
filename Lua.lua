-- Tải thư viện Fluent
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Tạo cửa sổ giao diện
local Window = Fluent:CreateWindow({
    Title = "Longdeptrai Hub",
    SubTitle = "Blox Fruits Script",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 350),
    Acrylic = true,
    Theme = "Dark"
})

-- Tạo tab chính
local Tab = Window:AddTab({ Title = "Main", Icon = "sword" })

Tab:AddToggle({
    Title = "Auto Farm Level",
    Default = false,
    Callback = function(v)
        _G.AutoFarm = v
        print("AutoFarm:", v)
    end
})

------------------------------------------------------------
-- 🧩 Thêm avatar góc trái có thể click để ẩn/hiện UI
------------------------------------------------------------

-- Tạo ảnh (avatar)
local Avatar = Instance.new("ImageButton")
Avatar.Name = "AvatarButton"
Avatar.Parent = game:GetService("CoreGui") or gethui()
Avatar.Size = UDim2.new(0, 80, 0, 80)
Avatar.Position = UDim2.new(0, 20, 0, 20)  -- Góc trên trái
Avatar.BackgroundTransparency = 1
Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=180&height=180&format=png"
Avatar.ZIndex = 10

-- Biến để bật/tắt UI
local Visible = true
Avatar.MouseButton1Click:Connect(function()
    Visible = not Visible
    if Window and Window.GUI then
        Window.GUI.Enabled = Visible
    end
end)
