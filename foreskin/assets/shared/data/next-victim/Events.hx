import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;

var checkerBG:FlxBackdrop;
var blackScreen:FlxSprite;
var stageBlack:FlxSprite;

function onCreate() {
    var bgData = FlxGridOverlay.createGrid(100, 100, 200, 200, true, "", 0xFF000000);
    
    checkerBG = new FlxBackdrop(bgData, 0x11); 
    checkerBG.velocity.set(100, 30); 
    checkerBG.alpha = 0.0001;

    var index = game.members.indexOf(game.dadGroup);
    if (index == -1) index = 10;
    game.insert(index, checkerBG);

    stageBlack = new FlxSprite(-1000, -1000).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
    stageBlack.scrollFactor.set(1, 1);
    stageBlack.alpha = 0;
    game.insert(index, stageBlack);

    blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackScreen.scrollFactor.set(0, 0);
    blackScreen.alpha = 0;
    blackScreen.cameras = [game.camHUD];
    game.add(blackScreen);
}

function onBeatHit() {
    if (curBeat == 132) {
        FlxTween.tween(checkerBG, {alpha: 0.3}, 1);
        game.boyfriend.cameraPosition[1] += 200;
        game.dad.cameraPosition[1] += 100;
    }
    if (curBeat == 260) {
        FlxTween.tween(checkerBG, {alpha: 0}, 1);
        game.boyfriend.cameraPosition[1] -= 200;
        game.dad.cameraPosition[1] -= 100;
    }

    if (curBeat == 386) {
        FlxTween.tween(blackScreen, {alpha: 1}, 0.5);
    }

    if (curBeat == 388) {
        stageBlack.alpha = 1;
        game.dad.setColorTransform(0, 0, 0, 1, 0, 255, 0, 0);
        
        FlxTween.tween(game.boyfriend, {alpha: 0}, 0.00001);
        
        FlxTween.tween(blackScreen, {alpha: 0}, 1);
    }

    if (curBeat == 400) {
        FlxTween.num(0, 1, 0.5, {onComplete: function(t) {
            game.boyfriend.setColorTransform(0, 0, 0, 1, 0, 255, 255, 0);
        }}, function(v) {
            game.boyfriend.setColorTransform(0, 0, 0, v, 0, 255, 255, 0);
        });
    }

    if (curBeat == 404) {
        FlxTween.tween(stageBlack, {alpha: 0}, 0.5);

        FlxTween.num(0, 1, 0.5, {onComplete: function(t) {
            game.dad.setColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
            game.boyfriend.setColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
        }}, function(v) {
            var inv = 1 - v;
            game.dad.setColorTransform(v, v, v, 1, 0, 255 * inv, 0, 0);
            game.boyfriend.setColorTransform(v, v, v, 1, 0, 255 * inv, 255 * inv, 0);
        });
    }
}