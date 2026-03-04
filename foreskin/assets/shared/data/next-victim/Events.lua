function opponentNoteHit(index, noteData, noteType, isSustain)
    triggerEvent('Screen Shake', '0.03, 0.005', '')
end

function onCreate()
    makeLuaSprite('greenive', 'greenive', 0, 0)
    setObjectCamera("greenive","other")
    addLuaSprite("greenive", true)
    setBlendMode('greenive', 'screen')
    setProperty('greenive.alpha',0)
end

function onBeatHit()

    if curBeat >= 4 and curBeat % 2 == 0 then
        triggerEvent('Add Camera Zoom', '0.015', '0.03')
        setProperty('greenive.alpha',0.2)
        doTweenAlpha('greenive', 'greenive', 0.0, 0.5, 'linear')
    end
end


