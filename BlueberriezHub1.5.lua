
-- 🔐 GUI KEY SYSTEM (mym)
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "KeyGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 180)
frame.Position = UDim2.new(0.5, -175, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
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
    if inputKey == "mym" then
        gui:Destroy()
        loadMainGUI()
    else
        submit.Text = "❌ Salah!"
        wait(1)
        submit.Text = "✔ Submit"
    end
end)




-- BlueberriezHub1.5.lua by mymlukfatwa

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local function makeKavoTransparent()
    local gui = game.CoreGui:FindFirstChild("KavoUI")
    if gui then
        for _, v in pairs(gui:GetDescendants()) do
            if v:IsA("Frame") or v:IsA("TextButton") or v:IsA("ScrollingFrame") then
                v.BackgroundTransparency = 0.3
            end
        end
    end
end

function loadMainGUI()
    local Window = Library.CreateLib("💙 Blueberriez Hub v1.3", "BlueTheme")

    getgenv().autofarm = false
    getgenv().flyon = false

    local Tab1 = Window:NewTab("🌴 Auto Farm")
    local Section1 = Tab1:NewSection("Main")

    Section1:NewToggle("⚔️ Auto Farm", "Farm musuh terdekat", function(val)
        getgenv().autofarm = val
        while getgenv().autofarm do
            pcall(function()
                local plr = game.Players.LocalPlayer
                local char = plr.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
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

    
Section1:NewToggle("⚔️ Auto Farm Level", "Naik level otomatis", function(val)
    getgenv().AutoFarmLevel = val
    if val then
        spawn(function()
            while getgenv().AutoFarmLevel do
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local level = player.Data.Level.Value
                    local tool = player.Character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
                    if tool and tool.Parent ~= player.Character then
                        tool.Parent = player.Character
                    end
                    local questData = {
                        {10, 49, "BanditQuest1", "Bandit", CFrame.new(1060,17,1547)},
                        {50, 99, "DesertBanditQuest", "Desert Bandit", CFrame.new(1141,5,4373)},
                        {100, 149, "SnowBanditQuest", "Snow Bandit", CFrame.new(1389, 87, -1297)},
                        {150, 199, "MarineQuest2", "Chief Petty Officer", CFrame.new(-4735, 20, 2183)},
                    }
                    local selected = nil
                    for _, data in ipairs(questData) do
                        if level >= data[1] and level <= data[2] then
                            selected = data
                            break
                        end
                    end
                    if selected then
                        local questName, mobName, questPos = selected[3], selected[4], selected[5]
                        if not player.PlayerGui:FindFirstChild("QuestTitle") then
                            game:GetService("ReplicatedStorage").Remotes.Comm:InvokeServer("StartQuest", questName, 1)
                            wait(1)
                        end
                        for _, mob in pairs(workspace.Enemies:GetChildren()) do
                            if mob.Name == mobName and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                                local hrp = player.Character.HumanoidRootPart
                                hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                                if tool then tool:Activate() end
                                break
                            end
                        end
                    end
                end)
                wait(0.5)
            end
        end)
    end
end)


Section1:NewButton("🗡️ Equip Weapon", "Ambil senjata dari backpack", function()
        local bp = game.Players.LocalPlayer.Backpack
        local char = game.Players.LocalPlayer.Character
        for _, v in pairs(bp:GetChildren()) do
            if v:IsA("Tool") then
                v.Parent = char
                break
            end
        end
    end)

    local Tab2 = Window:NewTab("🏃‍♂️ Player")
    local Section2 = Tab2:NewSection("Movement")

    Section2:NewSlider("WalkSpeed", "Ubah kecepatan jalan", 200, 16, function(s)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
    end)

    Section2:NewSlider("JumpPower", "Ubah tinggi lompatan", 200, 50, function(j)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = j
    end)

    Section2:NewToggle("🕊️ Fly Mode", "Terbang", function(val)
        getgenv().flyon = val
        local plr = game.Players.LocalPlayer
        local char = plr.Character or plr.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        if val then
            local bg = Instance.new("BodyGyro", hrp)
            local bv = Instance.new("BodyVelocity", hrp)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bv.velocity = Vector3.new(0, 0, 0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

            while getgenv().flyon do
                bg.CFrame = workspace.CurrentCamera.CFrame
                bv.velocity = workspace.CurrentCamera.CFrame.LookVector * 100
                wait()
            end

            bg:Destroy()
            bv:Destroy()
        end
    end)

    local Tab3 = Window:NewTab("🧭 Teleport")
    local Section3 = Tab3:NewSection("Island")

    Section3:NewDropdown("Pilih Pulau", "Teleport ke tempat", {
        "Starter Island", "Jungle", "Pirate Village", "Desert", "Marine Fortress",
        "Kingdom of Rose", "Green Zone", "Graveyard", "Snow Mountain", "Hot and Cold",
        "Cursed Ship", "Ice Castle", "Forgotten Island", "Usoap Island"
    }, function(sel)
        local locs = {
            ["Starter Island"] = Vector3.new(1097, 16, 1428),
            ["Jungle"] = Vector3.new(-1249, 11, 342),
            ["Pirate Village"] = Vector3.new(-1121, 4, 3855),
            ["Desert"] = Vector3.new(1324, 6, 4487),
            ["Marine Fortress"] = Vector3.new(-4500, 424, 4260),
            ["Kingdom of Rose"] = Vector3.new(-393, 73, 655),
            ["Green Zone"] = Vector3.new(-2250, 72, -3200),
            ["Graveyard"] = Vector3.new(-5400, 8, -800),
            ["Snow Mountain"] = Vector3.new(1390, 400, -1200),
            ["Hot and Cold"] = Vector3.new(-6000, 100, -5000),
            ["Cursed Ship"] = Vector3.new(925, 125, -3610),
            ["Ice Castle"] = Vector3.new(5400, 100, -6200),
            ["Forgotten Island"] = Vector3.new(-3050, 50, -10150),
            ["Usoap Island"] = Vector3.new(-4660, 800, -1500)
        }
        local pos = locs[sel]
        if pos then
            game.Players.LocalPlayer.Character:MoveTo(pos)
        end
    end)

    local Tab4 = Window:NewTab("⚙️ Settings")
    local Section4 = Tab4:NewSection("GUI")

    Section4:NewButton("❌ Tutup GUI", "Menutup Blueberriez Hub", function()
        for _, v in pairs(game.CoreGui:GetChildren()) do
            if v.Name == "KavoUI" then
                v:Destroy()
            end
        end
    end)

    makeKavoTransparent()
    Library:Notify("Blueberriez Hub v1.3 loaded!", "Welcome, use wisely!", 5)
end

local function loadKeyUI()
    local KeyWindow = Library.CreateLib("🔐 Blueberriez Key", "BlueTheme")
    local KeyTab = KeyWindow:NewTab("Key")
    local KeySection = KeyTab:NewSection("Masukkan Key")

    KeySection:NewTextBox("Masukkan Key", "Contoh: blue123", function(input)
        if input:lower() == correctKey then
            Library:Notify("✅ Key Benar!", "Membuka GUI...", 3)
            wait(1)
            KeyWindow:Destroy()
            loadMainGUI()
        else
            Library:Notify("❌ Key Salah!", "Silakan coba lagi", 3)
        end
    end)

    makeKavoTransparent()
end

local button = Instance.new("ImageButton")
button.Size = UDim2.new(0, 60, 0, 60)
button.Position = UDim2.new(0, 20, 0, 20)
button.BackgroundTransparency = 1
button.Image = "rbxassetid://6031075937"
button.Draggable = true
button.Active = true
button.Parent = game.CoreGui
button.MouseButton1Click:Connect(function()
    loadKeyUI()
end)

loadKeyUI()



-- ✅ Auto Haki
spawn(function()
    while wait(2) do
        pcall(function()
            if getgenv().AutoFarmLevel or getgenv().AutoFarm then
                local plr = game.Players.LocalPlayer
                if not plr.Character:FindFirstChild("HasBuso") then
                    game:GetService("ReplicatedStorage").Remotes.Comm:InvokeServer("Buso")
                end
            end
        end)
    end
end)

-- ✅ ESP Chest & Fruit
local espFolder = Instance.new("Folder", game.CoreGui)
espFolder.Name = "ESP_Objects"

function createESP(obj, color)
    if not obj:FindFirstChild("ESP") then
        local box = Instance.new("BillboardGui", obj)
        box.Name = "ESP"
        box.Size = UDim2.new(0, 100, 0, 40)
        box.AlwaysOnTop = true
        box.StudsOffset = Vector3.new(0, 3, 0)

        local label = Instance.new("TextLabel", box)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = obj.Name
        label.TextColor3 = color
        label.TextStrokeTransparency = 0
        label.Font = Enum.Font.GothamBold
        label.TextSize = 14
    end
end

spawn(function()
    while wait(1) do
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v.Name:match("Chest") then
                createESP(v, Color3.fromRGB(255, 255, 0)) -- Chest (kuning)
            elseif v:IsA("Tool") and v:FindFirstChild("Handle") and v.Name:match("Fruit") then
                createESP(v, Color3.fromRGB(0, 255, 0)) -- Buah (hijau)
            end
        end
    end
end)

-- ✅ Teleport GUI
local TeleportTab = Window:NewTab("🌍 Teleport")
local TeleportSection = TeleportTab:NewSection("Select Island")

local Teleports = {
    ["Starter"] = CFrame.new(1037, 17, 1579),
    ["Jungle"] = CFrame.new(-1250, 11, 389),
    ["Desert"] = CFrame.new(1160, 7, 4323),
    ["Snow Island"] = CFrame.new(1389, 87, -1297),
    ["Marine"] = CFrame.new(-4735, 20, 2183),
}

for name, cf in pairs(Teleports) do
    TeleportSection:NewButton(name, "Teleport to " .. name, function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
    end)
end
