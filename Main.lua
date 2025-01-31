-- 📌 Orion Library'yi yükle
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/OurModder/Orion/main/Source'))()

-- 📌 Ana pencereyi oluştur
local Window = OrionLib:MakeWindow({
    Name = "ReachGod",
    HidePremium = false, -- Premium üyeler için pencereyi gizlemeyi isteyebilirsiniz
    SaveConfig = true,
    ConfigFolder = "ReachGod",
    ConfigName = "config"
})

-- 📌 Reach Mesafesi Değiştirici Sekmesi
local ReachTab = Window:MakeTab({
    Name = "Reach Hack",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

-- 📌 Reach Mesafesi Varsayılan Değeri
local ReachStuds = 5 -- Varsayılan mesafe (5 Studs)

-- 📌 Reach Slider (Mesafe Ayarı)
ReachTab:AddSlider({
    Name = "Reach Distance",
    Min = 1,
    Max = 20,
    Default = ReachStuds,
    Increment = 1,
    Text = "Studs",
    Callback = function(Value)
        ReachStuds = Value -- Seçilen mesafeyi güncelle
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

-- 📌 GUI'yi Açık Tutma
OrionLib:MakeNotification({
    Name = "Configuration Loaded",
    Content = "Your configuration has been loaded successfully.",
    Image = "rbxassetid://4483362458",
    Time = 5
})

-- 📌 GUI'yi tutmaya devam et
OrionLib:Init()
