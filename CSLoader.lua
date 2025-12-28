-- loader.lua

local gameId = game.PlaceId

if gameId == 142823291 then -- mm2
    loadstring(game:HttpGet("https://github.com/CStudios-Dev/csLoader.lua/main/mm2.lua"))()
    
elseif gameId == 79546208627805 then -- 99nights
    loadstring(game:HttpGet("https://github.com/CStudios-Dev/csLoader.lua/main/99nights.lua"))()
    
elseif gameId == 76558904092080 then -- forge world 1
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CStudios-Dev/loader.lua/main/forge.lua"))()
    
elseif gameId == 129009554587176 then -- forge world 2
    loadstring(game:HttpGet("https://github.com/CStudios-Dev/csLoader.lua/main/forge.lua"))()
    
elseif gameId == 2753915549 then -- bloxfruits sea 1
    loadstring(game:HttpGet("https://github.com/CStudios-Dev/csLoader.lua/main/bloxfruits.lua"))()
    
elseif gameId == 4442272183 then -- bloxfruits sea 2
    loadstring(game:HttpGet("https://github.com/CStudios-Dev/csLoader.lua/main/bloxfruits.lua"))()
    
elseif gameId == 7449423635 then -- bloxfruits sea 3
    loadstring(game:HttpGet("https://github.com/CStudios-Dev/csLoader.lua/main/bloxfruits.lua"))()
    
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "Not Supported";
        Text = "This game is not supported!";
        Duration = 5;
    })
end
