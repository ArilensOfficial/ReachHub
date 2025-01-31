-- 📌 Orion Library'yi yükle
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- 📌 Ana menüyü oluşturmak için fonksiyon
local function CreateMainMenu()
    -- Ana menü oluşturuluyor
    local Window = OrionLib:MakeWindow({
        Name = "ReachGod",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "ReachGod",
        ConfigName = "config"
    })

    -- 📌 Reach Tab
    local ReachTab = Window:MakeTab({
        Name = "Reach",
        Icon = "rbxassetid://4483362458",
        PremiumOnly = false
    })

    -- 📌 Varsayılan Reach Mesafesi
    local ReachStuds = 5 -- Varsayılan reach mesafesi (5 Studs)
    local ReachEnabled = false -- Reach aktif değil

    -- 📌 Reach Toggle (Aç/Kapa) Butonu
    ReachTab:AddToggle({
        Name = "Enable Reach Hack",
        Default = false,
        Callback = function(Value)
            ReachEnabled = Value
            if ReachEnabled then
                ExtendReach() -- Reach mesafesini uygula
            else
                ResetReach() -- Reach'i sıfırla
            end
        end
    })

    -- 📌 Reach Hilesi (Hitbox Büyütme) Fonksiyonu
    local function ExtendReach()
        local Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local Tool = Character:FindFirstChildWhichIsA("Tool") -- Oyuncunun kullandığı eşyayı al
        if Tool and Tool:FindFirstChild("Handle") then
            local Handle = Tool.Handle
            Handle.Size = Vector3.new(ReachStuds, ReachStuds, ReachStuds) -- Hitbox büyütme
            Handle.Massless = true -- Fiziksel çakışmayı engelle
        end
    end

    -- 📌 Reach'i sıfırlama fonksiyonu
    local function ResetReach()
        local Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local Tool = Character:FindFirstChildWhichIsA("Tool") -- Oyuncunun kullandığı eşyayı al
        if Tool and Tool:FindFirstChild("Handle") then
            local Handle = Tool.Handle
            Handle.Size = Vector3.new(1, 1, 1) -- Varsayılan boyutları geri yükle
            Handle.Massless = false -- Fiziksel çakışmaya izin ver
        end
    end
end

-- 📌 Menü gösterme
CreateMainMenu()
