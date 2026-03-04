local camnow = -3000
local golden = nil
local camnowtrue = true
function onCreate() 
    setProperty("skipCountdown",true)
    makeLuaSprite('johnwick3', 'BG/John/john3', -1000, -1400);
    setScrollFactor('johnwick3', 0.2, 0.35);
    scaleObject('johnwick3', 0.95, 0.95);
    addLuaSprite('johnwick3', false);

    makeLuaSprite('johnwick2', 'BG/John/john2', 1250, -120);
    setScrollFactor('johnwick2', 0.8, 1);
    scaleObject('johnwick2', 0.95, 0.95);
    addLuaSprite('johnwick2', false);

    makeLuaSprite('johnwick1', 'BG/John/john1', -990, -690);
    setScrollFactor('johnwick1', 1, 1);
    scaleObject('johnwick1', 0.95, 0.95);
    addLuaSprite('johnwick1', false);
    --setProperty('johnwick1.alpha',0.5)

    makeLuaSprite('darka', nil, 0, -20);
    makeGraphic('darka', 1280, 820, '000000')
    addLuaSprite('darka', true)
    setObjectCamera('darka', 'other')
    setObjectOrder('darka', 20)

    setProperty('camHUD.alpha', 0)


    makeLuaSprite('camnow', nil, 0, -3000);
    makeGraphic('camnow', 500, 500, 'FFFFFF')
    --addLuaSprite('camnow', true)
    setProperty('camnow.alpha', 1)

--[[
    setProperty('johnwick1.y', 1600)
    setProperty('johnwick2.y', 1600)
    setProperty('boyfriend.y', 2400)
    setProperty('dad.y', 2400)
    ]]
end