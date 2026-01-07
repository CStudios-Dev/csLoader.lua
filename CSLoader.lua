print("Loader executed! Current game ID:", game.PlaceId)

local gameId = game.PlaceId

if gameId == 142823291 then -- mm2
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CStudios-Dev/csLoader.lua/main/mm2.lua"))()
    
elseif gameId == 6042520 then -- 99nights
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CStudios-Dev/csLoader.lua/main/99nights.lua"))()

elseif gameId == 35489258 then -- forge
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CStudios-Dev/csLoader.lua/main/forge.lua"))()
        
elseif gameId == 4372130 then -- bloxfruits
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CStudios-Dev/csLoader.lua/main/bloxfruits.lua"))()

elseif gameId == 33548380 then -- forsaken
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CStudios-Dev/csLoader.lua/main/forsaken.lua"))()
        
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "Not Supported";
        Text = "This game is not supported!";
        Duration = 5;
    })
end
