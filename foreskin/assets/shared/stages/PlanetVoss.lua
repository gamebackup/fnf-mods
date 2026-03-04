function onCreate()
    initLuaShader('greenFire')

    makeLuaSprite('BG', 'BG/1x/normal/BG', -1250, -750);
    setScrollFactor('BG', 1.35, 1.35);
    scaleObject('BG', 1.0, 1.0);

    addLuaSprite('BG', false);

    makeLuaSprite('s', 'BG/1x/normal/s', -1325, -750);
    setScrollFactor('s', 1.2, 1.2);
    scaleObject('s', 1.0, 1.0);

    addLuaSprite('s', false);

    makeLuaSprite('b', 'BG/1x/normal/b', -1250, -750);
    setScrollFactor('b', 1.1, 1.1);
    scaleObject('b', 1.0, 1.0);

    addLuaSprite('b', false);

    makeLuaSprite('greenback', '', -1550, -750);
    makeGraphic('greenback', 1560, 1440, '00FF00')
    scaleObject('greenback', 5.1, 1.2);
    addLuaSprite('greenback', false);
    setBlendMode('greenback', 'layer')
    setProperty('greenback.alpha',0)


    makeLuaSprite('k', 'BG/1x/normal/k', -1250, -750);
    setScrollFactor('k', 1.0, 1.0);
    scaleObject('k', 1.0, 1.0);

    addLuaSprite('k', false);

    makeLuaSprite('BG1', 'BG/1x/green/BG1', -1250, -750);
    setScrollFactor('BG1', 1.5, 1.5);
    scaleObject('BG1', 1.0, 1.0);

    addLuaSprite('BG1', false);

    makeLuaSprite('s1', 'BG/1x/green/s1', -1325, -750);
    setScrollFactor('s1', 1.25, 1.25);
    scaleObject('s1', 1.0, 1.0);

    addLuaSprite('s1', false);

    makeLuaSprite('b1', 'BG/1x/green/b1', -1250, -750);
    setScrollFactor('b1', 1.1, 1.1);
    scaleObject('b1', 1.0, 1.0);

    addLuaSprite('b1', false);
    
    makeLuaSprite('fireShaderSprite', '', -1000, -1350);
    makeGraphic('fireShaderSprite', 5000, 2000, '000000');
    setScrollFactor('fireShaderSprite', 1.1, 1.1);
    setSpriteShader('fireShaderSprite', 'greenFire');
    setProperty('fireShaderSprite.alpha', 0);
    addLuaSprite('fireShaderSprite', false);

    makeLuaSprite('k1', 'BG/1x/green/k1', -1250, -750);
    setScrollFactor('k1', 1.0, 1.0);
    scaleObject('k1', 1.0, 1.0);

    addLuaSprite('k1', false);
    setProperty('BG1.alpha',0)
    setProperty('s1.alpha',0)
    setProperty('b1.alpha',0)
    setProperty('k1.alpha',0)

    makeLuaSprite('greenback2', '', -1550, -750);
    makeGraphic('greenback2', 1560, 1440, '00FF00')
    scaleObject('greenback2', 5.1, 1.2);
    addLuaSprite('greenback2', true);
    setBlendMode('greenback2', 'multiply')
    setProperty('greenback2.alpha',0.1)

    setProperty('cameraSpeed',2)


end

function onUpdate(elapsed)
    setShaderFloat('fireShaderSprite', 'iTime', os.clock())
end

function onBeatHit()

    if curBeat >= 4 and curBeat % 2 == 0 then

        setProperty('greenback.alpha',0.05)
        doTweenAlpha('greenbackfade', 'greenback', 0.0, 0.3, 'linear')
    end

    if curBeat == 400 then
        setProperty('fireShaderSprite.alpha', 1)
        
        local k1Order = getObjectOrder('b1')
        setObjectOrder('fireShaderSprite', k1Order)
    end
end

function onEvent(name,v1,v2)

    if name == "Green" then

        if v1 == "1" then


        setProperty('BG.alpha',0)

        setProperty('s.alpha',0)

        setProperty('b.alpha',0)

        setProperty('k.alpha',0)

        setProperty('BG1.alpha',1)

        setProperty('s1.alpha',1)

        setProperty('b1.alpha',1)

        setProperty('k1.alpha',1)

        end

        if v1 == "0" then


        setProperty('BG.alpha',1)

        setProperty('s.alpha',1)

        setProperty('b.alpha',1)

        setProperty('k.alpha',1)

        setProperty('BG1.alpha',0)

        setProperty('s1.alpha',0)

        setProperty('b1.alpha',0)

        setProperty('k1.alpha',0)

        end

    end

end