function onCreate()


	makeLuaSprite('bg', 'sofa', -1100, -770)
	addLuaSprite('bg',false)
    setLuaSpriteScrollFactor('bg', 1.0, 1.0)
	scaleObject('bg',1.25,1.25)
	
	makeLuaSprite('vignette', 'theb', -500, -300)
	addLuaSprite('vignette',true)
    setLuaSpriteScrollFactor('vignette', 0, 0)
	scaleObject('vignette', 0.8,0.8)
	setProperty('vignette.alpha', 0)

	end
	
	function onStepHit()
		if curStep == 576 then
		doTweenAlpha('vignettetween','vignette', 0.9, 0.3)
		
		end
		
		if curStep == 384 then
		cameraFlash(game, 0xfffffff, 1)
		
		end
		
			if curStep == 512 then
		cameraFlash(game, 0xfffffff, 1)

		end
	
	end