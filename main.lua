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
local Credits = Window:MakeTab({"Credits", "star"})

Main:AddSection("Example section ")
Main:AddButton({
  Title = "Example button",
  Description = "",
  Callback = function()
    
    
    
  end
})

Credits:AddDiscordInvite({
  Name = "Rael Hub",
  Description = "Join my Discord or my tour channel",
  Logo = "rbxassetid://107050233461374",
  Invite = "Laelmano24"
})