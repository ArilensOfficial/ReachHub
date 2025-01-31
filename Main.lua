-- 📌 Ana GUI Yapılandırması
local Player = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local SubmitButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- 📌 GUI'yi ekranın ortasına yerleştirme
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.Name = "CustomGUI"

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Size = UDim2.new(0.5, 0, 0.3, 0)
Frame.Position = UDim2.new(0.25, 0, 0.35, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)

-- 📌 Başlık
TitleLabel.Parent = Frame
TitleLabel.Text = "Reach Hack | Lua God"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Size = UDim2.new(1, 0, 0.3, 0)
TitleLabel.TextScaled = true
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold

-- 📌 Key Girişi Alanı
KeyInput.Parent = Frame
KeyInput.Size = UDim2.new(0.8, 0, 0.2, 0)
KeyInput.Position = UDim2.new(0.1, 0, 0.4, 0)
KeyInput.PlaceholderText = "Enter Key (e.g. LuaGod)"
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeyInput.TextScaled = true
KeyInput.Font = Enum.Font.Gotham

-- 📌 Submit Butonu
SubmitButton.Parent = Frame
SubmitButton.Size = UDim2.new(0.8, 0, 0.2, 0)
SubmitButton.Position = UDim2.new(0.1, 0, 0.7, 0)
SubmitButton.Text = "Submit"
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
SubmitButton.TextScaled = true
SubmitButton.Font = Enum.Font.GothamBold

-- 📌 Durum Etiketi
StatusLabel.Parent = Frame
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
StatusLabel.Size = UDim2.new(1, 0, 0.2, 0)
StatusLabel.Position = UDim2.new(0, 0, 1, 0)
StatusLabel.TextScaled = true
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.Gotham

-- 📌 Key Sistemi
local validKey = "LuaGod"  -- Kullanıcı girmesi gereken anahtar

-- 📌 Key Girişini Kontrol Etme
SubmitButton.MouseButton1Click:Connect(function()
    local enteredKey = KeyInput.Text
    if enteredKey == validKey then
        StatusLabel.Text = "Key Accepted! Access Granted!"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)  -- Yeşil renk, kabul edilen key
        wait(1)
        StatusLabel.Text = ""
        -- Burada GUI'yi kapatabilir veya başka işlemler ekleyebilirsiniz
        -- Frame.Visible = false
    else
        StatusLabel.Text = "Invalid Key! Please try again."
    end
end)

-- 📌 Reach Mesafesi Değiştirici
local ReachStuds = 5 -- Varsayılan mesafe (5 Studs)
local function ExtendReach()
    local Tool = Player.Character:FindFirstChildWhichIsA("Tool") -- Oyuncunun kullandığı eşyayı al
    if Tool and Tool:FindFirstChild("Handle") then
        local Handle = Tool.Handle
        Handle.Size = Vector3.new(ReachStuds, ReachStuds, ReachStuds) -- Hitbox büyütme
        Handle.Massless = true -- Fiziksel çakışmayı engelle
    end
end

-- 📌 Reach Hack Butonu
local HackButton = Instance.new("TextButton")
HackButton.Parent = Frame
HackButton.Text = "Enable Reach Hack"
HackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HackButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
HackButton.Size = UDim2.new(0.8, 0, 0.2, 0)
HackButton.Position = UDim2.new(0.1, 0, 1, 0)

HackButton.MouseButton1Click:Connect(function()
    ExtendReach()
    game:GetService("RunService").Stepped:Connect(ExtendReach) -- Sürekli aktif olsun
end)

-- 📌 GUI Animasyonunu Başlat
local function animateGUI()
    Frame.Position = UDim2.new(0.5, 0, 0.35, 0)  -- Başlangıçta frame ekranın ortasında olacak
    local tweenService = game:GetService("TweenService")
    local goal = {Position = UDim2.new(0.5, 0, 0.35, 0)}  -- Hedef pozisyon
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
    local tween = tweenService:Create(Frame, tweenInfo, goal)
    tween:Play()
end

-- GUI animasyonunu başlat
animateGUI()
