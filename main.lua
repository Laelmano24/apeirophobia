local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Raelhub/Rael-hub-function/refs/heads/main/RedzLibaryVersionRaelHub/Source.Lua"))()
local RaelHubFunction = loadstring(game:HttpGet("https://raw.githubusercontent.com/Raelhub/Rael-hub-function/refs/heads/main/function/RaelHubFunctionV2/script.txt"))()

local Window = redzlib:MakeWindow({"Rael Hub | Apeirophobia", "by laelmano24, riley and tvzone", ""})
Window:AddMinimizeButton({
  Button = { Image = redzlib:GetIcon("rbxassetid://107050233461374"),
    Size = UDim2.fromOffset(60, 60),
    BackgroundTransparency = 0 },
  Corner = { CornerRadius = UDim.new(0, 6) }
})
local Main = Window:MakeTab({"Main", "home"})
local Visuals = Window:MakeTab({"Visuals", "eye"})
local Chapter1 = Window:MakeTab({"Chapter 1", "eye"})
local Credits = Window:MakeTab({"Credits", "star"})

Main:AddSection("Main Section")

Main:AddButton({"Instant Proximity Prompt", function()
game:GetService("ProximityPromptService").PromptShown:Connect(function(prompt)
            prompt.HoldDuration = 0
            prompt.RequiresLineOfSight = false
        end)
end})

Main:AddButton({"FullBright", function()
game.Lighting.Brightness = 2
game.Lighting.ClockTime = 14
game.Lighting.FogEnd = 100000
game.Lighting.GlobalShadows = false
game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
game.Lighting.FogEnd = 1e10
for _, v in pairs(game.Lighting:GetDescendants()) do
	if v:IsA("Atmosphere") then
		v:Destroy()
	end
end
end})

Main:AddSection("Local Player")

local walkSpeed = 16
local isEnabled = false

local function applyWalkSpeed()
    if isEnabled and game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
    end
end

Main:AddSlider({
  Name = "Walkspeed",
  Min = 0,
  Max = 200,
  Increase = 1,
  Default = 16,
  Callback = function(value)
 walkSpeed = value
    applyWalkSpeed()
  end
})

local EnableWalkspeed = Main:AddToggle({
  Name = "Enable Walkspeed",
  Default = false,
  Callback = function(state)
 isEnabled = state
    if isEnabled then
        applyWalkSpeed()
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end   
  end
})

game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid").Died:Connect(function()
        if isEnabled then
            repeat
                wait()
            until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            applyWalkSpeed()
        end
    end)
end)

Main:AddSlider({
  Name = "Fly Speed",
  Min = 0,
  Max = 200,
  Increase = 1,
  Default = 100,
  Callback = function(Value)
  _G.SetSpeedFly = Value
  end
})

_G.SetSpeedFly = 100
local EnableFly = Main:AddToggle({
  Name = "Enable Fly",
  Default = false,
  Callback = function(Value)
  _G.StartFly = Value
if _G.StartFly == false then
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler:Destroy()
game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
end
end
while _G.StartFly do
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(9e9,9e9,9e9)
game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(9e9,9e9,9e9)
game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.CFrame = Workspace.CurrentCamera.CoordinateFrame
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = Vector3.new()
if require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().X > 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + game.Workspace.CurrentCamera.CFrame.RightVector * (require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().X * _G.SetSpeedFly)
end
if require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().X < 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + game.Workspace.CurrentCamera.CFrame.RightVector * (require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().X * _G.SetSpeedFly)
end
if require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().Z > 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - game.Workspace.CurrentCamera.CFrame.LookVector * (require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().Z * _G.SetSpeedFly)
end
if require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().Z < 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - game.Workspace.CurrentCamera.CFrame.LookVector * (require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().Z * _G.SetSpeedFly)
end
elseif game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") == nil and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") == nil then
local bv = Instance.new("BodyVelocity")
local bg = Instance.new("BodyGyro")

bv.Name = "VelocityHandler"
bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
bv.MaxForce = Vector3.new(0,0,0)
bv.Velocity = Vector3.new(0,0,0)

bg.Name = "GyroHandler"
bg.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
bg.MaxTorque = Vector3.new(0,0,0)
bg.P = 1000
bg.D = 50
end
task.wait()
end
  end
}) 

Visuals:AddSection("ESP")

local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
ESP:Toggle(true)
ESP.Players = false
ESP.Tracers = false
ESP.Boxes = false
ESP.Names = false

local Enable = Visuals:AddToggle({
  Name = "Enable",
  Default = false,
  Callback = function(Value)
  ESP.Players = Value   
  end
})

local Tracers = Visuals:AddToggle({
  Name = "Tracers",
  Default = false,
  Callback = function(Value)
  ESP.Tracers = Value   
  end
})

local Boxes = Visuals:AddToggle({
  Name = "Boxes",
  Default = false,
  Callback = function(Value)
  ESP.Boxes = Value   
  end
})

local Names = Visuals:AddToggle({
  Name = "Names",
  Default = false,
  Callback = function(Value)
  ESP.Names = Value   
  end
})

Credits:AddDiscordInvite({
  Name = "Rael Hub",
  Description = "Join my Discord or my tour channel",
  Logo = "rbxassetid://107050233461374",
  Invite = "Laelmano24"
})
