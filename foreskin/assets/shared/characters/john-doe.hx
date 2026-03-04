import flixel.text.FlxText;

var elapsedTime:Float = 0;

function onUpdate(elapsed)
{
	elapsedTime += elapsed;

	if (elapsedTime > 0.1)
	{
		for (i in 0...FlxG.random.int(2, 6))
		{
			var spr:FlxText = new FlxText(0, 0, 0, Std.string(FlxG.random.int(0, 1)), 48);
			spr.font = Paths.font('Bebas-Regular.ttf');
			spr.color = FlxColor.RED;
			spr.blend = 0;
			spr.x = FlxG.random.float(game.dad.x, game.dad.x + game.dad.width);
			spr.y = game.dad.y + game.dad.height + FlxG.random.float(-50, 100);
			FlxTween.tween(spr, {x: spr.x + FlxG.random.float(-50, 50)}, 1);
			FlxTween.tween(spr, {y: spr.y - 10 * FlxG.random.float(1, 2)}, 1);
			FlxTween.tween(spr, {alpha: 0}, 0.25 * FlxG.random.float(1, 2), {
				onComplete: function(_)
				{
					remove(spr);
					spr.destroy();
					spr = null;
				}
			});
			spr.scale.x = 4;
			spr.scale.y = 0.25;
			FlxTween.tween(spr.scale, {x: 0.9, y: 1.1}, 0.1, {
				onComplete: function(_)
				{
					FlxTween.tween(spr.scale, {x: 1, y: 1}, 0.15);
				}
			});
			insert(members.indexOf(game.dadGroup) + FlxG.random.int(0, 1), spr);
		}
		elapsedTime = 0;
	}
}
