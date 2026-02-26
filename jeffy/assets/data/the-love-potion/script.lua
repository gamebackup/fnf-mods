
function onCreate()

		setPropertyFromClass('GameOverSubstate', 'characterName', 'juniorded')
		setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'Dead')
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'jrdeath')


end


function onStepHit()

	if curStep == 639 then
		setPropertyFromClass('GameOverSubstate', 'characterName', 'jeffy-confused-player')
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'jeffydeath')



	
	end

		if curStep == 1500 then
		setPropertyFromClass('GameOverSubstate', 'characterName', 'jeffyded')
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'dragonjeffydeath')


	end
	
end