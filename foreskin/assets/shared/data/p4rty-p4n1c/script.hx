
var allowStart:Bool = false;
var isRestart:Bool = false;

function onCreate()
{
	isRestart = PlayState.seenCutscene;
}

function onStartCountdown()
{

	if (!isRestart && !allowStart)
	{
		allowStart = true;
		game.inCutscene = true;
		
		new FlxTimer().start(0.0, function(tmr)
		{
			game.startVideo('1218_1');
		});

		return Function_Stop;
	}
	else
	{
		return Function_Continue;
	}
}