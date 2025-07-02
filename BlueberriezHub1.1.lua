local correctKey = "blue123"
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

local button = Instance.new("ImageButton")
button.Size = UDim2.new(0, 60, 0, 60)
button.Position = UDim2.new(0, 20, 0, 20)
button.BackgroundTransparency = 1
button.Image = "rbxassetid://6031075937"
button.Draggable = true
button.Active = true
button.Parent = game.CoreGui

button.MouseButton1Click:Connect(function()
    button.Visible = false
    local KeyWindow = Library.CreateLib("🔐 Blueberriez Key", "DarkTheme")
    local KeyTab = KeyWindow:NewTab("Key")
    local KeySection = KeyTab:NewSection("Masukkan Key")

    KeySection:NewTextBox("Masukkan Key", "Contoh: blue123", function(input)
        if input == correctKey then
            Library:Notify("✅ Key Benar!", "Membuka GUI...", 3)
            wait(1)
            KeyWindow:Destroy()
            loadMainGUI()
            makeKavoTransparent()
        else
            Library:Notify("❌ Key Salah!", "Coba lagi", 3)
        end
    end)

    makeKavoTransparent()
end)

function loadMainGUI()
    local Window = Library.CreateLib("💙 Blueberriez Hub", "DarkTheme")

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
        "Starter Island",
        "Jungle",
        "Pirate Village",
        "Desert",
        "Marine Fortress",
        "Kingdom of Rose",
        "Green Zone",
        "Graveyard",
        "Snow Mountain",
        "Hot and Cold",
        "Cursed Ship",
        "Ice Castle",
        "Forgotten Island",
        "Usoap Island"
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

    Library:Notify("Blueberriez Hub berhasil dimuat!", "Versi 1.0", 5)
end
