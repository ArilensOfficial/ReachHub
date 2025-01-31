-- 📌 Orion Library'yi yükle
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- 📌 Oyun ID'si Kontrolü
local allowedGameId = 14004668761  -- İzin verilen oyun ID'si

-- Eğer oyuncu doğru oyunda değilse, hata mesajı göster
if game.PlaceId ~= allowedGameId then
    OrionLib:MakeNotification({
        Name = "Error",
        Content = "This script can only be executed in the 'Real Futbol 24' game.",
        Image = "rbxassetid://4483362458",
        Time = 5
    })
    return
end

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
local ReachBox = nil -- Reach Box başlangıçta yok

-- 📌 Reach Slider (Mesafe Ayarı) - Mobil ve PC Desteği
ReachTab:AddSlider({
    Name = "Reach Distance",
    Min = 1,
    Max = 20,
    Default = ReachStuds,
    Increment = 1,
    Text = "Studs",
    Callback = function(Value)
        ReachStuds = Value -- Seçilen mesafeyi güncelle
        if ReachBox then
            ReachBox.Size = Vector3.new(ReachStuds, ReachStuds, ReachStuds) -- Kutu boyutunu güncelle
        end
    end,
    MobileFriendly = true  -- Mobil cihazlar için uyumlu
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
