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
local ReachStuds = 5
local ReachBox = nil
local BoxVisible = true
local Connection = nil -- Kutunun sürekli güncellenmesi için bağlantı

-- 📌 Reach Slider (Mesafe Ayarı)
ReachTab:AddSlider({
    Name = "Reach Distance",
    Min = 1,
    Max = 20,
    Default = ReachStuds,
    Increment = 1,
    Text = "Studs",
    Callback = function(Value)
        ReachStuds = Value
        if ReachBox then
            ReachBox.Size = Vector3.new(ReachStuds, ReachStuds, ReachStuds)
        end
    end,
    MobileFriendly = true
})

-- 📌 Reach Box Görünmezlik Toggle
ReachTab:AddToggle({
    Name = "Hide Reach Box",
    Default = false,
    Callback = function(Value)
        BoxVisible = not Value
        if ReachBox then
            ReachBox.Transparency = BoxVisible and 0 or 1
        end
    end
})

-- 📌 Reach Box ve Karakter Uzuvlarını Güncelleme
local function ExtendReach()
    local Character = game.Players.LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end

    -- 📌 Eğer Reach Box yoksa, oluştur
    if not ReachBox then
        ReachBox = Instance.new("Part")
        ReachBox.Size = Vector3.new(ReachStuds, ReachStuds, ReachStuds)
        ReachBox.Anchored = true
        ReachBox.CanCollide = false
        ReachBox.Material = Enum.Material.SmoothPlastic
        ReachBox.Color = Color3.fromRGB(255, 0, 0) -- Kırmızı
        ReachBox.Parent = workspace
    end

    -- 📌 Kutunun boyutunu güncelle
    ReachBox.Size = Vector3.new(ReachStuds, ReachStuds, ReachStuds)
    
    -- 📌 Eski bağlantıyı temizle (önceki bağlantıyı kapatıp yenisini açıyoruz)
    if Connection then
        Connection:Disconnect()
    end

    -- 📌 Oyuncu hareket ettikçe Box'u güncelle
    Connection = game:GetService("RunService").Stepped:Connect(function()
        if Character and Character:FindFirstChild("HumanoidRootPart") and ReachBox then
            ReachBox.Position = Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
            ReachBox.Transparency = BoxVisible and 0 or 1
        end
    end)
end

-- 📌 Reach Hack Butonu
ReachTab:AddButton({
    Name = "Enable Reach Hack",
    Callback = function()
        ExtendReach()
    end
})

-- 📌 GUI'yi Açık Tutma
OrionLib:MakeNotification({
    Name = "Configuration Loaded",
    Content = "Your configuration has been loaded successfully.",
    Image = "rbxassetid://4483362458",
    Time = 5
})

-- 📌 GUI'yi başlat
OrionLib:Init()
