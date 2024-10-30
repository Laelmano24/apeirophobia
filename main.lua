local RaelHubEspState = false

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Raelhub/Rael-hub-function/refs/heads/main/RedzLibaryVersionRaelHub/Source.Lua"))()
local RaelHubFunction = loadstring(game:HttpGet("https://raw.githubusercontent.com/Raelhub/Rael-hub-function/refs/heads/main/function/RaelHubFunctionV2/script.txt"))()

function EspPlayer()
  while RaelHubEspState do
    RaelHubFunction.PlayersEspActive()
    task.wait(1)
  end
  RaelHubFunction.PlayersEspDisabled()
end

local Window = redzlib:MakeWindow({"Rael Hub | Apeirophobia", "by laelmano24, riley and tvzone", ""})
Window:AddMinimizeButton({
  Button = { Image = redzlib:GetIcon("rbxassetid://107050233461374"),
    Size = UDim2.fromOffset(60, 60),
    BackgroundTransparency = 0 },
  Corner = { CornerRadius = UDim.new(0, 6) }
})
local Main = Window:MakeTab({"Main", "home"})
local Player = Window:MakeTab({"Player", "user"})
local Visuals = Window:MakeTab({"Visuals", "eye"})
local Credits = Window:MakeTab({"Credits", "star"})

Main:AddSection("Main Section")

Main:AddButton({"Instant Proximity Prompt", function()
  game:GetService("ProximityPromptService").PromptShown:Connect(function(prompt)
    prompt.HoldDuration = 0
    prompt.RequiresLineOfSight = false
  end)
end})

local PlayerId = ""

Player:AddSection({"Teleport to players"})

local TeleportePlayers = Player:AddDropdown({
  Name = "Players",
  Description = "",
  Options = {},
  Default = "",
  Flag = "Teleporters players",
  Callback = function(Value)
    PlayerId = Value
  end
})

function UpdatePlayers()
  local playerNames = {}
  for _, player in ipairs(game.Players:GetPlayers()) do
    table.insert(playerNames, player.Name)
  end
  TeleportePlayers:Set(playerNames)
end

UpdatePlayers()

game.Players.PlayerAdded:Connect(UpdatePlayers)
game.Players.PlayerRemoving:Connect(UpdatePlayers)

Player:AddButton({"Teleport to player", function()
  local targetPlayerName = PlayerId
  local targetPlayer = game.Players:FindFirstChild(targetPlayerName)
  if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
  end
end})

Player:AddSection("Speed player")

local walkSpeed = 16
local isEnabled = false

local function applyWalkSpeed()
  if isEnabled and game.Players.LocalPlayer.Character then
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
  end
end

Player:AddSlider({
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

local EnableWalkspeed = Player:AddToggle({
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
        task.wait()
      until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
      applyWalkSpeed()
    end
  end)
end)

Player:AddSection("Fly player")

Player:AddSlider({
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

local EnableFly = Player:AddToggle({
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

Player:AddSection({"Light up the map"})

local PlayerFullbright = Player:AddToggle({
  Name = "Fullbright",
  Description = "",
  Flag = "Toggle1",
  Default = false
})

PlayerFullbright:Callback(function(Value)
  if Value then
    RaelHubFunction.dofullbright()
  else
    RaelHubFunction.restoreLighting()
  end
end)

Visuals:AddSection("ESP")

Visuals:AddToggle({
  Name = "Esp player",
  Default = false,
  Callback = function(Value)
    RaelHubEspState = Value
    if RaelHubEspState then
      task.spawn(EspPlayer)
    end
  end
})

local EspMonsterValue

local Esp_monster_button = Visuals:AddToggle({
  Name = "Esp Monsters",
  Description = "",
  Flag = "",
  Default = false
})

Esp_monster_button:Callback(function(Value)
  pcall(function()
    local RunService = game:GetService("RunService")

    if Value then
      EspMonsterValue = RunService.Heartbeat:Connect(function()
        pcall(function()
          local Monsters = workspace.Entities:GetChildren()
          for _, Monster in ipairs(Monsters) do
            if Monster:IsA("Model") and Monster:FindFirstChild("HumanoidRootPart") then
              if not Monster:FindFirstChild("RaelHubIcon") and not Monster:FindFirstChild("RaelHubDestaque") then
                RaelHubFunction.CreateEspDistance(Monster, Color3.fromRGB(255, 102, 102), Monster.Name, true)
              end
            end
          end
        end)
      end)
    else
      if EspMonsterValue then
        EspMonsterValue:Disconnect()
        EspMonsterValue = nil
      end

      local Monsters = workspace.Entities:GetChildren()
      for _, Monster in ipairs(Monsters) do
        RaelHubFunction.DisableEsp(Monster)
      end
    end
  end)
end)

Credits:AddDiscordInvite({
  Name = "Rael Hub",
  Description = "Join my Discord or my tour channel",
  Logo = "rbxassetid://107050233461374",
  Invite = "Laelmano24"
})