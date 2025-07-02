-- 🔐 Key System Blueberriez Hub
local correctKey = "blue123" -- Ganti key sesuai keinginanmu
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local KeyWindow = Library.CreateLib("🔐 Blueberriez Key", "DarkTheme")
local KeyTab = KeyWindow:NewTab("🔑 Key")
local KeySection = KeyTab:NewSection("Masukkan Key")

KeySection:NewTextBox("Masukkan Key", "Contoh: blue123", function(input)
    if input == correctKey then
        Library:Notify("✅ Key Benar!", "Membuka Blueberriez Hub...", 3)
        wait(1)
        KeyWindow:Destroy()
        loadMainGUI() -- Panggil GUI utama
    else
        Library:Notify("❌ Key Salah!", "Silakan coba lagi", 3)
    end
end)

-- 💙 Fungsi GUI Utama
function loadMainGUI()
    local Window = Library.CreateLib("💙 Blueberriez Hub Lite", "DarkTheme")

    getgenv().autofarm = false
    getgenv().flyon = false

    -- Tab: Auto Farm
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

    -- Tab: Player
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

    -- Tab: Teleport
    local Tab3 = Window:NewTab("🧭 Teleport")
    local Section3 = Tab3:NewSection("Island")

    Section3:NewDropdown("Pilih Pulau", "Teleport ke tempat", {
        "Starter Island",
        "Jungle",
        "Pirate Village",
        "Desert",
        "Marine Fortress"
    }, function(sel)
        local locs = {
            ["Starter Island"] = Vector3.new(1097, 16, 1428),
            ["Jungle"] = Vector3.new(-1249, 11, 342),
            ["Pirate Village"] = Vector3.new(-1121, 4, 3855),
            ["Desert"] = Vector3.new(1324, 6, 4487),
            ["Marine Fortress"] = Vector3.new(-4500, 424, 4260)
        }

        local pos = locs[sel]
        if pos then
            game.Players.LocalPlayer.Character:MoveTo(pos)
        end
    end)

    -- Notifikasi berhasil dimuat
    Library:Notify("Blueberriez Hub berhasil dimuat!", "Versi 1.0", 5)
end
