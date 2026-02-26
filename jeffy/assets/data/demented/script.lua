local allowCountdown = false
function onEndSong()
if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
startVideo('cutscene_demented');
allowCountdown = true;
return Function_Stop;
end
return Function_Continue;
end


function onCreate()


		setPropertyFromClass('GameOverSubstate', 'characterName', 'marvin')
		setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'Dead')
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'marvindeath')
end