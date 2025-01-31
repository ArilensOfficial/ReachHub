-- 📌 Rayfield GUI'yi yükle
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- 📌 Ana pencereyi oluştur
local Window = Rayfield:CreateWindow({
    Name = "Reach Hack | Lua God",
    LoadingTitle = "Real Futbol 24",
    LoadingSubtitle = "Rayfield GUI",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "ReachHack",
        FileName = "config"
    },
    Discord = {
        Enabled = false, 
        Invite = "discord",
        RememberJoins = true
    },
    KeySystem = true, -- Key sistemi aktif
    KeySettings = {
        Key = "LuaGod", -- Giriş anahtarı
        KeyDetection = function()
            return game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.E) -- E tuşuna basarak giriş yapılabilir
        end,
        KeyMessage = "Lütfen 'E' tuşuna basın!" -- Mesaj
    }
})

-- 📌 GUI İçin Sekme ve Bölüm Aç
local Tab = Window:CreateTab("Main", 4483362458) -- Sol menüde sekme oluşturur
local Section = Tab:CreateSection("Reach Settings")

-- 📌 Reach Mesafesi Değiştirici
local ReachStuds = 5 -- Varsayılan mesafe (5 Studs)

local ReachSlider = Tab:CreateSlider({
    Name = "Reach Distance",
    Range = {1, 20}, -- Minimum 1, Maksimum 20 Studs
    Increment = 1,
    Suffix = " Studs",
    CurrentValue = ReachStuds,
    Flag = "ReachStuds",
    Callback = function(Value)
        ReachStuds = Value -- Seçilen mesafeyi güncelle
    end
})

-- 📌 Oyuncu Bilgilerini Al
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- 📌 Reach Hilesi (Hitbox Büyütme)
local function ExtendReach()
    local Tool = Character:FindFirstChildWhichIsA("Tool") -- Oyuncunun kullandığı eşyayı al
    if Tool and Tool:FindFirstChild("Handle") then
        local Handle = Tool.Handle
        Handle.Size = Vector3.new(ReachStuds, ReachStuds, ReachStuds) -- Hitbox büyütme
        Handle.Massless = true -- Fiziksel çakışmayı engelle
    end
end

-- 📌 Reach Hack Butonu
Tab:CreateButton({
    Name = "Enable Reach Hack",
    Callback = function()
        ExtendReach()
        game:GetService("RunService").Stepped:Connect(ExtendReach) -- Sürekli aktif olsun
    end
})

-- 📌 GUI'yi Açık Tutma
Rayfield:LoadConfiguration()
