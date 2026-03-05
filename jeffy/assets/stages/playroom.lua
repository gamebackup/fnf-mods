function onCreate()


	makeLuaSprite('bg', 'playroombg', -200, -300)
	addLuaSprite('bg',false)
    setLuaSpriteScrollFactor('bg', 1.0, 1.0)
	
	
	makeLuaSprite('light', 'spotlight', -60, -300)
    setLuaSpriteScrollFactor('light', 1.0, 1.0)
	addLuaSprite('light',true)
	setProperty('light.alpha', 0)



	
	end
	
function onStepHit()

	if curStep == 569 then
	
		setProperty('light.alpha', 1)
		
		playSound('SpotlightSound')

	end
	
		if curStep == 768 then
		
		removeLuaSprite('light')
		
		playSound('SpotlightSound')
	end
	
end