-- 📌 Orion Library'yi yükle
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- 📌 Key Sistemi Ayarları
local Key = "Helian200" -- Anahtar burada belirtilecek
local KeyEntered = false -- Key kontrolü

-- 📌 Ana pencereyi oluştur
local Window = OrionLib:MakeWindow({
    Name = "ReachGod",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "ReachGod",
    ConfigName = "config"
})

-- 📌 Key Giriş Penceresi
local function ShowKeyWindow()
    local KeyWindow = OrionLib:MakeWindow({
        Name = "Enter Key",
        HidePremium = false,
        SaveConfig = false
    })

    -- 📌 Key Giriş Kutusu
    KeyWindow:MakeTextbox({
        Name = "Enter Key",
        Placeholder = "Enter the key to continue",
        Text = "",
        Callback = function(Value)
            if Value == Key then
                KeyEntered = true
                OrionLib:MakeNotification({
                    Name = "Success",
                    Content = "Key validated successfully!",
                    Image = "rbxassetid://4483362458",
                    Time = 5
                })
                KeyWindow:Destroy() -- Key doğrulandıktan sonra pencereleri kapat
            else
                OrionLib:MakeNotification({
                    Name = "Error",
                    Content = "Invalid key! Please try again.",
                    Image = "rbxassetid://4483362458",
                    Time = 5
                })
            end
        end
    })
end

-- 📌 Eğer Key girilmediyse, key penceresini göster
if not KeyEntered then
    ShowKeyWindow()
else
    -- 📌 Key girildikten sonra ana pencereyi oluştur
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

    -- 📌 GUI'yi Açık Tutma
    OrionLib:SaveConfig()
end
