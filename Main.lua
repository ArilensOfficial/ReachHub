-- 📌 Rayfield GUI'yi yükle
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- 📌 Ana pencereyi oluştur
local MainWindow = Rayfield:CreateWindow({
    Name = "Main",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Falxe",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "McDonalds Hub"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD.
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "McDonalds Hub",
       Subtitle = "Key System",
       Note = "Key: McDonalds",
       FileName = "SiriusKey",
       SaveKey = true,
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = "McDonalds"
    }
})

-- 📌 GUI İçin Sekme ve Bölüm Aç
local Tab = MainWindow:CreateTab("Main", 4483362458) -- Sol menüde sekme oluşturur
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
