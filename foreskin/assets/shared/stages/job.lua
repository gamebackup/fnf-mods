
--How makeLuaSprite works:
--makeLuaSprite(<SPRITE VARIABLE>, <SPRITE IMAGE FILE NAME>, <X>, <Y>);
--"Sprite Variable" is how you refer to the sprite you just spawned in other methods like "setScrollFactor" and "scaleObject" for example

--so for example, i made the sprites "stagelight_left" and "stagelight_right", i can use "scaleObject('stagelight_left', 1.1, 1.1)"
--to adjust the scale of specifically the one stage light on left instead of both of them
function onCreate()
	-- background shit

	makeLuaSprite('BG', 'BG/job/wall', 50, 0);
	setScrollFactor('BG', 1.1,1.0);
	scaleObject('BG', 1.0, 1.0);

	addLuaSprite('BG', false);

	makeLuaSprite('Blue_Jim', 'BG/job/Blue_Jim', -1500, 400);
	scaleObject('Blue_Jim', 1.0, 1.0);

	addLuaSprite('Blue_Jim', false);
	--doTweenX('Blue_JimTween', 'Blue_Jim', 3000, 2, 'linear')
	scaleObject('Blue_Jim', 0.75, 0.75);

	makeLuaSprite('kevin', 'BG/job/ka', 3000, 350);
	scaleObject('kevin', 0.75, 0.75);
	addLuaSprite('kevin', false);
	--doTweenX('kevinTween', 'kevin', -1500, 20, 'linear')

	makeAnimatedLuaSprite('johndoe', 'BG/job/johndoe',-1500,400)
	addAnimationByPrefix('johndoe', 'walk', 'johndoe walk', 3, true);
	--doTweenX('johndoeTween', 'johndoe', 3000, 15, 'linear')
	scaleObject('johndoe', 0.85, 0.85);
	addLuaSprite('johndoe', false);

	makeAnimatedLuaSprite('guys', 'BG/job/guys',3000,375)
	addAnimationByPrefix('guys', 'idle', 'idle', 24, true);
	--doTweenX('guysTween', 'guys', -1500, 20, 'linear')
	scaleObject('guys', 0.9, 0.9);
	addLuaSprite('guys', false);

	makeLuaSprite('BG2', 'BG/job/wall2', 0, 0);
	--setScrollFactor('BG2', 1.5, 1.5);
	scaleObject('BG2', 1.0, 1.0);

	addLuaSprite('BG2', false);
	--setProperty('BG2.alpha', 0.5);
	playAnim('johndoe', 'walk', true);
end

function onBeatHit()
	if curBeat % 2 == 1 then
	playAnim('guys', 'idle', true);
	end
end

function onSectionHit()
		if curSection == 4 then
			doTweenX('kevinTween', 'kevin', -1500, 20, 'linear')
		end
		if curSection == 12 then
			doTweenX('johndoeTween', 'johndoe', 3000, 15, 'linear')
		end
		if curSection == 20 then
			doTweenX('Blue_JimTween', 'Blue_Jim', 3000, 2, 'linear')
		end
		if curSection == 24 then
			doTweenX('guysTween', 'guys', -1500, 20, 'linear')
		end
end