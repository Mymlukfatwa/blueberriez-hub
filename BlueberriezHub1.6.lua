-- 💙 Blueberriez Hub 1.6 by MYM
-- Key System
local correctKey = "mym"
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "KeyGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 180)
frame.Position = UDim2.new(0.5, -175, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.4
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "🔐 Enter Key"
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.9, 0, 0, 40)
textBox.Position = UDim2.new(0.05, 0, 0.3, 0)
textBox.PlaceholderText = "Enter your key here"
textBox.BackgroundTransparency = 0.3
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(255,255,255)
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 16

local submit = Instance.new("TextButton", frame)
submit.Size = UDim2.new(0.5, 0, 0, 35)
submit.Position = UDim2.new(0.25, 0, 0.7, 0)
submit.Text = "✔ Submit"
submit.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
submit.TextColor3 = Color3.fromRGB(255, 255, 255)
submit.TextSize = 18
submit.Font = Enum.Font.GothamBold
submit.BackgroundTransparency = 0.2
submit.BorderSizePixel = 0

submit.MouseButton1Click:Connect(function()
    local inputKey = textBox.Text
    if inputKey == correctKey then
        gui:Destroy()
        loadMainGUI()
    else
        textBox.Text = ""
        title.Text = "❌ Salah! Coba lagi"
    end
end)

function loadMainGUI()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("💙 Blueberriez Hub v1.6", "DarkTheme")

    -- Notify
    Library:Notify("Blueberriez Hub 1.6 aktif!", "Selamat datang!", 5)

    -- Auto Farm
    local autoFarmTab = Window:NewTab("🌴 Auto Farm")
    local afSection = autoFarmTab:NewSection("Farming")
    getgenv().autofarm = false

    afSection:NewToggle("⚔️ Auto Farm", "Serang musuh terdekat", function(val)
        getgenv().autofarm = val
        while getgenv().autofarm do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                for _, mob in pairs(workspace:WaitForChild("Enemies"):GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                        root.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                        wait(0.3)
                        if char:FindFirstChildOfClass("Tool") then
                            char:FindFirstChildOfClass("Tool"):Activate()
                        end
                        break
                    end
                end
            end)
            wait(0.4)
        end
    end)

    -- Tools
    local toolsTab = Window:NewTab("🧰 Tools")
    local toolsSection = toolsTab:NewSection("Senjata")

    toolsSection:NewButton("🗡️ Equip Weapon", "Ambil senjata dari backpack", function()
        local bp = game.Players.LocalPlayer.Backpack
        local char = game.Players.LocalPlayer.Character
        for _, v in pairs(bp:GetChildren()) do
            if v:IsA("Tool") then
                v.Parent = char
                break
            end
        end
    end)

    -- Misc Tab
    local miscTab = Window:NewTab("⚙️ Misc")
    local miscSection = miscTab:NewSection("Lainnya")

    miscSection:NewButton("🔁 Respawn Character", "Respawn cepat", function()
        local plr = game.Players.LocalPlayer
        plr:LoadCharacter()
    end)

    miscSection:NewButton("❌ Tutup GUI", "Menutup semua GUI", function()
        for _, v in pairs(game.CoreGui:GetChildren()) do
            if v.Name == "KavoUI" then
                v:Destroy()
            end
        end
    end)
end
