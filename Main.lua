-- 📌 Rayfield Library'yi yükle
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 📌 Oyun ID'si Kontrolü
local allowedGameId = 14004668761  -- İzin verilen oyun ID'si

-- Eğer oyuncu doğru oyunda değilse, hata mesajı göster
if game.PlaceId ~= allowedGameId then
    Rayfield:CreateNotification({
        Name = "Error",
        Content = "This script can only be executed in the 'Real Futbol 24' game.",
        Image = "rbxassetid://4483362458",
        Time = 5
    })
    return
end

-- 📌 Ana pencereyi oluştur
local Window = Rayfield:CreateWindow({
    Name = "ReachGod",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Helian Official",
    Theme = "Ocean",  -- Tema olarak Ocean seçildi
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "ReachGod",
        FileName = "config"
    },
    Discord = {
        Enabled = false, -- Discord bağlantısını devre dışı bırak
        Invite = "noinvitelink", -- Discord davet bağlantısı
        RememberJoins = true -- Discord'a her girişte hatırlamak
    },
    KeySystem = false, -- Key sistemi devre dışı
})

-- 📌 Reach Mesafesi Değiştirici Sekmesi
local ReachTab = Window:CreateTab("Reach Hack", 4483362458)

-- 📌 Varsayılan Reach Mesafesi
local ReachStuds = 1 -- Varsayılan mesafe (1 Studs)

-- 📌 Reach Slider (Mesafe Ayarı) - Mobil ve PC Desteği
ReachTab:CreateSlider({
    Name = "Reach Distance",
    Range = {1, 20},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = ReachStuds,
    Flag = "ReachStuds",
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
ReachTab:CreateButton({
    Name = "Enable Reach Hack",
    Callback = function()
        ExtendReach()
        game:GetService("RunService").Stepped:Connect(ExtendReach) -- Sürekli aktif olması için
    end
})

-- 📌 GUI'yi Açık Tutma
Rayfield:LoadConfiguration()
