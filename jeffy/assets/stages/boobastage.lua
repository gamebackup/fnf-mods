function onCreate()

		

	makeLuaSprite('bg','booba/get',-900, -1300)
    setLuaSpriteScrollFactor('bg',0.8,0.8)
	addLuaSprite('bg',false)
	
	makeLuaSprite('doll','booba/ken', 1400, 300)
    setLuaSpriteScrollFactor('doll',1.0, 1.0)
	addLuaSprite('doll',true)
	
	makeAnimatedLuaSprite('glare', 'booba/eyeglare', 1510, 265);
	addAnimationByPrefix('glare', 'glareshake', 'shake', 24, true)
	setScrollFactor('glare',1.0, 1.0);
	addLuaSprite('glare',true)
	setProperty('glare.alpha', 0)
	
	makeAnimatedLuaSprite('Britknee', 'booba/Brit', -1100, -150);
	addAnimationByPrefix('Britknee', 'Britkneeidle', 'idle', 24, true)
	addAnimationByPrefix('Britknee', 'HeartEyes', 'love', 24, true)
	setScrollFactor('Britknee',1.2, 1.2);
	addLuaSprite('Britknee',true)
	scaleObject('Britknee',1.1,1.1)
	
	makeLuaSprite('Britkneedesk','booba/desk',-2000, 600)
    setLuaSpriteScrollFactor('Britkneedesk',1.2,1.2)
	addLuaSprite('Britkneedesk',true)
	
	
	makeLuaSprite('Light','booba/light',-750, -400)
    setLuaSpriteScrollFactor('Light',-0.1,-0.1)
	addLuaSprite('Light',true)
	setProperty('Light.alpha', 0.5)
	
		makeLuaSprite('vignette', 'theb', -380, -250)
		addLuaSprite('vignette',true)
		setLuaSpriteScrollFactor('vignette', 0, 0)
		scaleObject('vignette', 0.7,0.7)
		setProperty('vignette.alpha', 0)
	
	

	end
	
function onStepHit()

	if curStep == 352 then
	
	doTweenAlpha('glaretween', 'glare', 1, 3.4)
	
	end


	if curStep == 415 then
	
		removeLuaSprite('doll')
		removeLuaSprite('glare')

		
		end



	if curStep == 542 then
	
	objectPlayAnimation('Britknee','HeartEyes', true)
	setProperty('Britknee.x', -1000)
	
	
	end
	
	if curStep == 615 then

	doTweenAlpha('Lighttween', 'Light', 0, 1);
	
	end
	
	if curStep == 639 then

	
	removeLuaSprite('gf')
	removeLuaSprite('bg')
	removeLuaSprite('Britknee')
	removeLuaSprite('Britkneedesk')


	makeLuaSprite('classwall','booba/2/roomwall',-2430, -1991)
    setLuaSpriteScrollFactor('classwall',0.9, 1.0)
	addLuaSprite('classwall',false)
	
	makeLuaSprite('classroombg','booba/2/room',-2430, -700)
    setLuaSpriteScrollFactor('classroombg',1.0,1.0)
	addLuaSprite('classroombg',false)
	

	makeLuaSprite('bdesk','booba/2/britdesk',-2430, -700)
    setLuaSpriteScrollFactor('bdesk',1.0,1.0)
	addLuaSprite('bdesk',true)
	
	makeLuaSprite('cody','booba/2/codydesk',-2230, -720)
    setLuaSpriteScrollFactor('cody',1.0, 1.0)
	addLuaSprite('cody',false)
	
	makeLuaSprite('jr','booba/2/jrdesk',-2230, -720)
    setLuaSpriteScrollFactor('jr',1.0, 1.0)
	addLuaSprite('jr',false)
			
	makeLuaSprite('pinnk','booba/2/pink',-2530, -700)
    setLuaSpriteScrollFactor('pinnk',1.0,1.0)
	addLuaSprite('pinnk',true)

	setProperty('pinnk.alpha', 0)

	
	
	setCharacterX('dad', -1000)
	setCharacterY('dad', 50)
	
	setCharacterX('boyfriend', 180)
	setCharacterY('boyfriend', 70)
	end
	
	if curStep == 768 then

	cameraFlash(game, '0xffff94db', 1)
	
	setProperty('pinnk.alpha', 1)

	end

		if curStep == 1500 then
		
		cameraFlash(game, '0xffffffff', 1)
			
		removeLuaSprite('pinnk')
		removeLuaSprite('bdesk')
		setProperty('vignette.alpha', 0.9)
		
		end
		
		
		if curStep == 2400 then
		
		doTweenAlpha('vignettetween','vignette', 0, 0.3)



		end
		
	function onBeatHit()
		
	if curBeat % 2 == 0 and curStep > 1504 and curStep < 1887 then
	
	triggerEvent('Add Camera Zoom', 0.05, 0.05)
	
	end
	
		if curBeat % 1 == 0 and curStep > 1888 and curStep < 2400 then 
		
		triggerEvent('Add Camera Zoom', 0.11, 0.011)

		
		end

	end
	


end
