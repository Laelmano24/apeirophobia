local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Raelhub/Rael-hub-function/refs/heads/main/RedzLibaryVersionRaelHub/Source.Lua"))()
local RaelHubFunction = loadstring(game:HttpGet("https://raw.githubusercontent.com/Raelhub/Rael-hub-function/refs/heads/main/function/RaelHubFunctionV2/script.txt"))()

local Window = redzlib:MakeWindow({"Rael Hub | apeirophobia", "by laelmano24, riley and tvzone", ""})
Window:AddMinimizeButton({
  Button = { Image = redzlib:GetIcon("rbxassetid://107050233461374"),
    Size = UDim2.fromOffset(60, 60),
    BackgroundTransparency = 0 },
  Corner = { CornerRadius = UDim.new(0, 6) }
})
local Main = Window:MakeTab({"Main", "home"})
local Player = Window:MakeTab({"Player", "user"})
local Esp = Window:MakeTab({"Esp", "eye"})
local Credits = Window:MakeTab({"Credits", "star"})

Main:AddSection("Example section ")
Main:AddButton({
  Title = "Example button",
  Description = "",
  Callback = function()
    
    
    
  end
})

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

Player:AddButton({"Teleport player", function()
  local targetPlayerName = PlayerId
  local targetPlayer = game.Players:FindFirstChild(targetPlayerName)
  if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
  end
end})

local JogadorSpeedValue = 25
local JogadorSpeedRunService

Player:AddSection({"Player speed"})

local PlayerSpeed = Player:AddSlider({
  Name = "Velocidade",
  Min = 14,
  Max = 100,
  Default = 16
})

PlayerSpeed:Callback(function(Value)

  JogadorSpeedValue = Value
end)

local ToggleSpeed = Player:AddToggle({
  Name = "Enable speed",
  Description = "",
  Flag = "",
  Default = false
})

ToggleSpeed:Callback(function(Value)
  local RunService = game:GetService("RunService")
  local Player = game.Players.LocalPlayer
  local Humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")

  if Value then

    JogadorSpeedRunService = RunService.Heartbeat:Connect(function()
      if Humanoid then
        Humanoid.WalkSpeed = JogadorSpeedValue
      end
    end)
  else

    if JogadorSpeedRunService then
      JogadorSpeedRunService:Disconnect()
      JogadorSpeedRunService = nil
    end
    if Humanoid then
      Humanoid.WalkSpeed = 16
    end
  end
end)

Player:AddSection({"Illuminates around you"})

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

local Esp_Monsters_button = Esp:AddToggle({
  Name = "Esp monsters",
  Description = "",
  Flag = "",
  Default = false
})

Esp_Monsters_button:Callback(function(Value)
  local Monsters -- Place the monsters
  if Value then
    
    for _, Monster in ipairs(Monsters) do
      if not Monster:FindFirstChild("RaelHubIcon") and not Monster:FindFirstChild("RaelHubDestaque") then
         RaelHubFunction.CreateEspDistance(Monster, Color3.fromRGB(255, 102, 102), Monster.Name, true)
      end
    end
  else

    local Monsters -- Place the monsters
    for _, Monster in ipairs(Monsters) do
      RaelHubFunction.DisableEsp(Monster)
    end
  end
end)

Credits:AddDiscordInvite({
  Name = "Rael Hub",
  Description = "Join my Discord or my tour channel",
  Logo = "rbxassetid://107050233461374",
  Invite = "Laelmano24"
})
