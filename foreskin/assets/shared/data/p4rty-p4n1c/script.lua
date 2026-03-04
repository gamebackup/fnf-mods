--Credit 
--applyNoteSpeed Script:DeLMiK(Friday Night Funkin: Rhythmic Revolution)

local HP = 0

function onCreate()
    makeLuaSprite('C00lgui','c00lgui',-360,360)
    setObjectCamera('C00lgui','other')
    scaleObject('C00lgui', 0.2, 0.15)
    addLuaSprite('C00lgui')
    

    makeLuaText('C00ltxt','Gravity Coil',1280,-360,380)
    setTextFont('C00ltxt', 'c00lgui.ttf')
    setTextAlignment('C00ltxt', 'left')
    setObjectCamera('C00ltxt','other')
    setTextBorder('C00ltxt', 1, 'white')
    setTextSize('C00ltxt', 48)
    addLuaText('C00ltxt', true)

	makeAnimatedLuaSprite('fire2', 'BG/kid/fire', -1280, 230);
    addAnimationByPrefix('fire2', 'fire2', 'fire20', 12, true);
    scaleObject('fire2', 1.3, 1.3);
    addLuaSprite('fire2', false);
    playAnim('fire2', 'fire2')

	makeAnimatedLuaSprite('fire', 'BG/kid/fire', -280, 590);
    addAnimationByPrefix('fire', 'fire', 'fire0', 12, true);
    scaleObject('fire', 1.3, 1.3);
    addLuaSprite('fire', true);
    playAnim('fire', 'fire')

    makeLuaSprite('burning','mechanic/c00l/burning',0,0)
    setBlendMode('burning', 'add')
    setObjectCamera('burning','other')
    addLuaSprite('burning',true)

    setProperty('burning.alpha',0)
    setProperty('fire.alpha',0)
    setProperty('fire2.alpha',0)
end

function onSectionHit()
    if curSection == 17 then
        doTweenX('C00lguiin', 'C00lgui', 0, 0.5, 'quadOut')
        doTweenX('C00ltextin', 'C00ltxt', 15, 0.5, 'quadOut')
        runTimer("GuiDelete",5)
    end
    if curSection >= 17 and curSection < 25 then
        if curSection % 2 == 1 then
            if downscroll then
            noteTweenY('noteen1', 4, 530, 1.3, 'quadOut')
            noteTweenY('noteen2', 6, 530, 1.3, 'quadOut')
            noteTweenY('noteen3', 5, 570, 1.3, 'quadOut')
            noteTweenY('noteen4', 7, 570, 1.3, 'quadOut')
            else
            noteTweenY('noteen1', 4, 30, 1.3, 'quadOut')
            noteTweenY('noteen2', 6, 30, 1.3, 'quadOut')
            noteTweenY('noteen3', 5, 70, 1.3, 'quadOut')
            noteTweenY('noteen4', 7, 70, 1.3, 'quadOut')
            end
        end
        if curSection % 2 == 0 then
            if downscroll then
            noteTweenY('noteen1', 4, 570, 1.3, 'quadOut')
            noteTweenY('noteen2', 6, 570, 1.3, 'quadOut')
            noteTweenY('noteen3', 5, 530, 1.3, 'quadOut')
            noteTweenY('noteen4', 7, 530, 1.3, 'quadOut')
            else
            noteTweenY('noteen1', 4, 70, 1.3, 'quadOut')
            noteTweenY('noteen2', 6, 70, 1.3, 'quadOut')
            noteTweenY('noteen3', 5, 30, 1.3, 'quadOut')
            noteTweenY('noteen4', 7, 30, 1.3, 'quadOut')
            end
        end
    end
    if curSection == 49 then
        if downscroll then
            noteTweenY('noteen1', 4, 560, 1.3, 'quadOut')
            noteTweenY('noteen2', 6, 560, 1.3, 'quadOut')
            noteTweenY('noteen3', 5, 560, 1.3, 'quadOut')
            noteTweenY('noteen4', 7, 560, 1.3, 'quadOut')
        else
            noteTweenY('noteen1', 4, 50, 1.3, 'quadOut')
            noteTweenY('noteen2', 6, 50, 1.3, 'quadOut')
            noteTweenY('noteen3', 5, 50, 1.3, 'quadOut')
            noteTweenY('noteen4', 7, 50, 1.3, 'quadOut')
        end
        setTextString('C00ltxt', 'Set NoteSpeed:4')
        setTextSize('C00ltxt', 36)
        setProperty('C00ltxt.y', 390)
        triggerEvent('Change Scroll Speed', 1.25)
        doTweenX('C00lguiin', 'C00lgui', 0, 0.5, 'quadOut')
        doTweenX('C00ltextin', 'C00ltxt', 8, 0.5, 'quadOut')
        runTimer("GuiDelete",5)
    end


    if curSection == 65 then
        setTextString('C00ltxt', 'Random Note Speed')
        setTextSize('C00ltxt', 30)
        setProperty('C00ltxt.y', 395)
        triggerEvent('Change Scroll Speed', 1)
        doTweenX('C00lguiin', 'C00lgui', 0, 0.5, 'quadOut')
        doTweenX('C00ltextin', 'C00ltxt', 3.5, 0.5, 'quadOut')
        runTimer("GuiDelete",5)
    end
    if curSection >= 65 and curSection < 81 then
        applyNoteSpeed(0.8, 1.2)
    end
    if curSection == 81 then
        setProperty('health',2)
        setTextString('C00ltxt', 'Burning')
        setTextSize('C00ltxt', 48)
        setProperty('C00ltxt.y', 380)
        doTweenX('C00lguiin', 'C00lgui', 0, 0.5, 'quadOut')
        doTweenX('C00ltextin', 'C00ltxt', 45, 0.5, 'quadOut')
        runTimer("GuiDelete",5)
        doTweenAlpha('burningTween', 'burning', 1, 0.5, 'linear')
        doTweenAlpha('burningTween2', 'fire', 1, 0.5, 'linear')
        doTweenAlpha('burningTween3', 'fire2', 1, 0.5, 'linear')
    end
    if curSection >= 81 and curSection < 114 then
        applyNoteSpeed(1, 1) 
    end
end

function onBeatHit()
    if curBeat >= 100 and curBeat < 196 then
        if curBeat % 2 == 1 then
            if downscroll then
            noteTweenY('noteen1', 4, 540, 0.2, 'quadOut')
            noteTweenY('noteen2', 6, 540, 0.2, 'quadOut')
            noteTweenY('noteen3', 5, 560, 0.2, 'quadOut')
            noteTweenY('noteen4', 7, 560, 0.2, 'quadOut')
            else
            noteTweenY('noteen1', 4, 40, 0.2, 'quadOut')
            noteTweenY('noteen2', 6, 40, 0.2, 'quadOut')
            noteTweenY('noteen3', 5, 60, 0.2, 'quadOut')
            noteTweenY('noteen4', 7, 60, 0.2, 'quadOut')
            end
        end
        if curBeat % 2 == 0 then
            if downscroll then
            noteTweenY('noteen1', 4, 560, 0.2, 'quadOut')
            noteTweenY('noteen2', 6, 560, 0.2, 'quadOut')
            noteTweenY('noteen3', 5, 540, 0.2, 'quadOut')
            noteTweenY('noteen4', 7, 540, 0.2, 'quadOut')
            else
            noteTweenY('noteen1', 4, 60, 0.2, 'quadOut')
            noteTweenY('noteen2', 6, 60, 0.2, 'quadOut')
            noteTweenY('noteen3', 5, 40, 0.2, 'quadOut')
            noteTweenY('noteen4', 7, 40, 0.2, 'quadOut')
            end
        end
    end
    if curBeat >= 68 then
        if curBeat % 2 == 0 then
            triggerEvent('Add Camera Zoom', 0.05)
        end
    end
    if curBeat >= 324 and curBeat < 356 then
        setProperty('health',HP - 0.025 )
    end
    if curBeat == 356 then
        --doTweenAlpha('burningendTween', 'burning', 0, 0.5, 'linear')
        setProperty('health',HP + 1 )
    end
    if curBeat == 388 then
        doTweenAlpha('burningendTween', 'burning', 0, 0.2, 'linear')
        setProperty('fire.alpha',0)
        setProperty('fire2.alpha',0)
    end
end
function onUpdate()
    HP = getProperty('health')
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "GuiDelete" then
        doTweenX('C00ltextout', 'C00ltxt', -360, 0.5, 'quadOut')
        doTweenX('C00lguiOut', 'C00lgui', -360, 0.5, 'quadOut')
    end
end

function applyNoteSpeed(minSpeed, maxSpeed)
    for i = 0, getProperty("unspawnNotes.length")-1 do
        if not getPropertyFromGroup("unspawnNotes", i, "isSustainNote") then
            local speed = getRandomFloat(minSpeed, maxSpeed)
            setPropertyFromGroup("unspawnNotes", i, "multSpeed", speed)
        else
            setPropertyFromGroup("unspawnNotes", i, "multSpeed", getPropertyFromGroup("unspawnNotes", i, "parent.multSpeed"))
        end
    end
end
