local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Test UI",
    SubTitle = "bylong",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 350),
    Acrylic = true,
    Theme = "Dark"
})

local Tab = Window:AddTab({ Title = "Main", Icon = "home" })

Tab:AddButton({
    Title = "Click Me",
    Callback = function()
        print("Button Clicked!")
    end
})

Tab:AddToggle({
    Title = "Auto Farm",
    Default = false,
    Callback = function(Value)
        print("AutoFarm:", Value)
    end
})
