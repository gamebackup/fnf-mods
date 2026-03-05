function onCreate()


	makeAnimatedLuaSprite('floor', 'DJ/FloorSprites', -400, 455);
	addAnimationByPrefix('floor', 'floorMove', 'floorr', 24, true)
	addLuaSprite('floor',false)
	
	makeLuaSprite('bg', 'DJ/hallwalls', -350, -190)
	addLuaSprite('bg',false)
    setLuaSpriteScrollFactor('bg', 1.0, 1.0)
	
	makeAnimatedLuaSprite('door', 'DJ/DoorSprites', -760, -1490);
	addAnimationByPrefix('door', 'doorsmove', 'doors', 24, true)
	addLuaSprite('door',false)

	makeLuaSprite('shadows', 'DJ/shading', -350, -190)
	addLuaSprite('shadows',false)
    setLuaSpriteScrollFactor('shadows', 1.0, 1.0)
	
	


	end
	
