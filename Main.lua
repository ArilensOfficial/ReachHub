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
        ConfigName = "config",
        IntroEnabled = true,  -- Menü açılış animasyonu
        Mobile = true -- Telefon desteği için ayar
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
    local ReachBox = nil -- Reach kutusu (part) başlangıçta yok

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

    -- 📌 Reach Slider
    ReachTab:AddSlider({
        Name = "Reach Distance",
        Min = 1,
        Max = 20,
        Default = ReachStuds,
        Callback = function(Value)
            ReachStuds = Value
            if ReachEnabled then
                ExtendReach() -- Reach aktifse, mesafeyi güncelle
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

        -- Reach kutusunu ekle ve boyutunu ayarla
        if not ReachBox then
            ReachBox = Instance.new("Part")
            ReachBox.Size = Vector3.new(ReachStuds, ReachStuds, ReachStuds)
            ReachBox.Position = Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0) -- Karakterin üst kısmında
            ReachBox.Anchored = true
            ReachBox.CanCollide = false
            ReachBox.Material = Enum.Material.SmoothPlastic
            ReachBox.Color = Color3.fromRGB(255, 0, 0) -- Kırmızı renk
            ReachBox.Parent = workspace
        else
            ReachBox.Size = Vector3.new(ReachStuds, ReachStuds, ReachStuds)
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

        -- Reach kutusunu sil
        if ReachBox then
            ReachBox:Destroy()
            ReachBox = nil
        end
    end
end

-- 📌 Menü gösterme
CreateMainMenu()
