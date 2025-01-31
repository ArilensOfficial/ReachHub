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

    -- 📌 Reach & Speed Tab
    local ReachTab = Window:MakeTab({
        Name = "Reach & Speed",
        Icon = "rbxassetid://4483362458",
        PremiumOnly = false
    })

    -- 📌 Varsayılan Reach ve Speed Değerleri
    local ReachStuds = 1 -- Varsayılan reach mesafesi (1 Studs)
    local SpeedValue = 1 -- Varsayılan speed (1)

    -- 📌 Reach Slider
    ReachTab:AddSlider({
        Name = "Reach Distance",
        Min = 1,
        Max = 20,
        Default = ReachStuds,
        Increment = 1,
        Text = "Studs",
        Callback = function(Value)
            ReachStuds = Value -- Seçilen mesafeyi güncelle
            UpdateReachBox() -- Reach kutusunu güncelle
        end
    })

    -- 📌 Speed Slider
    ReachTab:AddSlider({
        Name = "Speed",
        Min = 1,
        Max = 100,
        Default = SpeedValue,
        Increment = 1,
        Text = "Speed",
        Callback = function(Value)
            SpeedValue = Value -- Seçilen hızı güncelle
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = SpeedValue -- Yürüyüş hızını ayarla
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

    -- 📌 Reach Hack Butonu
    ReachTab:AddButton({
        Name = "Enable Reach Hack",
        Callback = function()
            ExtendReach()
            game:GetService("RunService").Stepped:Connect(ExtendReach) -- Sürekli aktif olması için
        end
    })

    -- 📌 Reach Kutusunu Güncelleme Fonksiyonu
    local ReachBox = Instance.new("Frame")
    ReachBox.Size = UDim2.new(0, ReachStuds * 10, 0, 10) -- Şu anda Reach değerine göre
    ReachBox.Position = UDim2.new(0.5, -ReachStuds * 5, 0, 50)
    ReachBox.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    ReachBox.BackgroundTransparency = 0.5
    ReachBox.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui") -- GUI'ye ekle

    -- Reach kutusunu güncelleme
    local function UpdateReachBox()
        ReachBox.Size = UDim2.new(0, ReachStuds * 10, 0, 10) -- Boyutu günceller
        ReachBox.Position = UDim2.new(0.5, -ReachStuds * 5, 0, 50) -- Konumunu günceller
    end

    -- 📌 GUI'yi Açık Tutma
    OrionLib:SaveConfig()
end

-- 📌 Ana menüyü doğrudan göster
CreateMainMenu()
