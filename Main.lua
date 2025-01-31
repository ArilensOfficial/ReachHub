-- 📌 Orion Library'yi yükle
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- 📌 Ana pencereyi oluştur
local Window = OrionLib:MakeWindow({
    Name = "ReachGod",
    HidePremium = false,
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
local BoxVisible = true -- Varsayılan olarak görünür

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

-- 📌 Reach Box Görünmezlik Toggle
ReachTab:AddToggle({
    Name = "Hide Reach Box",
    Default = false,
    Callback = function(Value)
        BoxVisible = not Value
        if ReachBox then
            ReachBox.Transparency = BoxVisible and 0 or 1 -- 0 = Görünür, 1 = Görünmez
        end
    end
})

-- 📌 Karakter Uzuvlarını Büyütme Fonksiyonu
local function ScaleCharacterParts()
    local Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    if not Character then return end

    local ScaleFactor = ReachStuds / 5  -- Orantılı büyütme (Varsayılan: 5 studs)

    local PartsToScale = {
        "Head",
        "LeftHand", "RightHand",
        "LeftFoot", "RightFoot"
    }

    for _, PartName in pairs(PartsToScale) do
        local Part = Character:FindFirstChild(PartName)
        if Part then
            Part.Size = Vector3.new(Part.Size.X * ScaleFactor, Part.Size.Y * ScaleFactor, Part.Size.Z * ScaleFactor)
        end
    end
end

-- 📌 Reach Hilesi (Hitbox ve Karakter Boyutu Güncelleme)
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

    -- Görünürlük Güncelleme
    ReachBox.Transparency = BoxVisible and 0 or 1

    -- Karakter Uzuvlarını Büyüt
    ScaleCharacterParts()
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
