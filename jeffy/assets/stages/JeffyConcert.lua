function onCreate()


	makeLuaSprite('bg', 'Jeffy/JeffyConcertBg', -300, -190)
	addLuaSprite('bg',false)
    setLuaSpriteScrollFactor('bg', 0.2, 0.2)
	
	makeLuaSprite('tree', 'Jeffy/JeffyBgTrees', -350, -190)
	addLuaSprite('tree',false)
    setLuaSpriteScrollFactor('tree', 0.2, 0.2)
	
	makeLuaSprite('stage', 'Jeffy/JeffyConcertBgB', -700, -300)
	addLuaSprite('stage',false)
    setLuaSpriteScrollFactor('stage', 1.0, 1.0)
		
	makeLuaSprite('lights', 'Jeffy/stagelights', 0, -200)
	addLuaSprite('lights',true)
    setLuaSpriteScrollFactor('lights', 1.0, 1.0)
	
	makeAnimatedLuaSprite('crowd', 'Jeffy/Crowd', -500, -100);
	addAnimationByPrefix('crowd', 'idle', 'Bouncy', 24, true)
	scaleObject('crowd',1.25,1.25)
	addLuaSprite('crowd',true)

	end
	
	
function onStepHit()

end