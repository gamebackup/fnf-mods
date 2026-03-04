function onCreatePost()
    if luachartingmode == true then
        setProperty('camFollow.x', 650)
        setProperty('camFollow.y', 500)
        camnowtrue = false
        setProperty('camHUD.alpha', 1)
        setProperty('darka.alpha', 0)
        setProperty('cameraSpeed', 2.0)
        setProperty('camGame', 0.45)
    end
end

function onBeatHit()
    if luachartingmode == true then
        return Function_Stop
    end
    
    if curBeat == 1 then
        doTweenAlpha('aaada', 'darka', 0, 18, 'cubeOut')
        --[[
        doTweenY('aaaaa','johnwick1',-690 ,10, 'cubeInOut')
        doTweenY('aaaaa2','johnwick2',-120 ,10, 'cubeInOut')
        doTweenY('aaaaa3','boyfriend',480 ,10, 'cubeInOut')
        doTweenY('aaaaa4','dad',200 ,10, 'cubeInOut')
        ]]
    end

    if curBeat == 30 then
        doTweenAlpha('aaada', 'camHUD', 1, 2, 'linear')
        setProperty('cameraSpeed', 2.0)
    end

    if curBeat == 32 then
        camnowtrue = false
    end

    if curBeat == 328 then
        camnowtrue = true
        doTweenZoom('camz', 'camGame', 0.55, 3, 'quintInOut')
        doTweenY('gwoengoagioe', "camnow", -3000, 13, 'quintInOut')
        doTweenX('idiobvuis', "camnow", 650, 3, 'linear')
        doTweenAlpha('HUDunvisible', "camHUD", 0, 3, 'linear')
    end

    if curBeat == 360 then
        setProperty('darka.alpha', 1)
    end
end
function onUpdate()
    camnow = getProperty('camnow.y')
    golden = getProperty('camnow.x')

    luachartingmode = false

    if camnowtrue == true and luachartingmode == false then
        if curBeat < 328 then
            setProperty('camFollow.x', 650)
            setProperty('camnow.x', 950)
        end
        if curBeat >= 328 then
            setProperty('camFollow.x', golden)
        end
        setProperty('camFollow.y', camnow)
    end
end

function onSongStart()
    if luachartingmode == true then
        return Function_Stop
    end

    setProperty('cameraSpeed', 999.0)
    doTweenY('gwoengoagioe', "camnow", 500, 12.30, 'quintInOut')
    doTweenZoom('camz', 'camGame', 0.45, 12, 'quintInOut')
    camnowtrue = true
end
