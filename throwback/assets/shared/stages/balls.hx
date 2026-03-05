// maybe try fix the intro if not remove it idk
// maybe some kind of invert color effect for glitch bit
// maybe transition to glitchy bit by zooming in to hex face then bsod and zooming back out to glitchy bit
// the window shit i forgot lol (maybe steal code from moy)
// missingno type shit

import openfl.system.Capabilities;
import funkin.backend.utils.ShaderResizeFix;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.addons.display.FlxBackdrop;

var manualCamera:Bool = false;

var codeBackdrop:FlxBackdrop;

function postCreate() {
    FlxG.camera.zoom = defaultCamZoom = 1.3;
    camFollow.setPosition(474, -150);
    FlxG.camera.snapToTarget();
    manualCamera = true;
    camMove = false;
    
    bg.setGraphicSize(Std.int(bg.width * 1.3));
    dad.setGraphicSize(Std.int(dad.width * 1.2));
    gf.setGraphicSize(Std.int(gf.width * 1.15));
    boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.541));

    for (introItems in [bg, dad, gf, boyfriend]) {
        introItems.alpha = 0.001;
    }

    strumLines.members[0].characters[1].alpha = 0.001;

    codeBackdrop = new FlxBackdrop(Paths.image('stages/balls/evilballs/code'), FlxAxes.X, 0, 0);
    codeBackdrop.setGraphicSize(Std.int(codeBackdrop.width * 1.8));
    codeBackdrop.y -= 50;
    codeBackdrop.scrollFactor.set(0, 0);
    codeBackdrop.color = FlxColor.RED;
    insert(members.indexOf(overlay) - 1, codeBackdrop);
    codeBackdrop.velocity.x = -25;

    for (evilStage in [codeBackdrop, overlay]) {
        evilStage.visible = false;
    }
}

function onSongStart()
{
    for (introItems in [bg, dad, gf, boyfriend]) {
        FlxTween.tween(introItems, {alpha: 1.0}, 1.25, {ease: FlxEase.quadOut, startDelay: 2});
    }

    FlxTween.tween(bg.scale, {x: 1.0, y: 1.0}, 3, {ease: FlxEase.quadOut, startDelay: 2});
    
    FlxTween.tween(dad.scale, {x: 0.9, y: 0.9}, 3, {ease: FlxEase.quadOut, startDelay: 2});
    FlxTween.tween(gf.scale, {x: 0.85, y: 0.85}, 3, {ease: FlxEase.quadOut, startDelay: 2});
    FlxTween.tween(boyfriend.scale, {x: 0.441, y: 0.441}, 3, {ease: FlxEase.quadOut, startDelay: 2});
    
    FlxTween.tween(camFollow, {y: 328.5}, 9, {ease: FlxEase.quadInOut});
    FlxTween.tween(FlxG.camera, {zoom: 0.95}, 4.5, {ease: FlxEase.quadIn, onComplete: function() {
        FlxG.camera.zoom = defaultCamZoom = 0.95;
        FlxTween.tween(FlxG.camera, {zoom: 0.75}, 4.5, {ease: FlxEase.quadOut, onComplete: function() {
            FlxG.camera.zoom = defaultCamZoom = 0.76;
            FlxTween.tween(FlxG.camera, {zoom: 0.7}, 2.2, {ease: FlxEase.quadInOut, startDelay: 1.5, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.7;
            }});
        }});
    }});
}

function update(elapsed:Float) {
    shakeyWindowShit(elapsed);
}

function beatHit(curBeat:Int) {
    switch (curBeat) {
        case 32:
            manualCamera = false;
            camMove = true;
        case 224:
            FlxG.autoPause = false;
            window.borderless = true;
        case 240:
            ballsdotexe();
    }
}

function stepHit(curStep:Int) {
    switch (curStep) {
        case 944:
            windowShake = [-30, 30, 0.4];

            FlxTween.num(windowShake[0], 0, windowShake[2], {ease: FlxEase.linear}, function(num) {
                windowShake[0] = num;
            });
            FlxTween.num(windowShake[1], 0, windowShake[2], {ease: FlxEase.linear}, function(num) {
                windowShake[1] = num;
            });

            FlxTween.tween(window, {
                x: window.x + FlxG.random.float(-500, -150),
                y: window.y + FlxG.random.float(-150, 150)
            }, 0.01);
        case 950:
            windowShake = [-20, 20, 0.3];

            FlxTween.num(windowShake[0], 0, windowShake[2], {ease: FlxEase.linear}, function(num) {
                windowShake[0] = num;
            });
            FlxTween.num(windowShake[1], 0, windowShake[2], {ease: FlxEase.linear}, function(num) {
                windowShake[1] = num;
            });
            
            FlxTween.tween(window, {
                x: window.x + FlxG.random.float(150, 500),
                y: window.y + FlxG.random.float(-150, 150)
            }, 0.01);
        case 956:
            windowShake = [-10, 10, 0.25];

            FlxTween.num(windowShake[0], 0, windowShake[2], {ease: FlxEase.linear}, function(num) {
                windowShake[0] = num;
            });
            FlxTween.num(windowShake[1], 0, windowShake[2], {ease: FlxEase.linear}, function(num) {
                windowShake[1] = num;
            });
            resizeWindow(Capabilities.screenResolutionX, Capabilities.screenResolutionY, false, 0.5);
    }
}

var windowShake:Array = [0, 0, 0]; // MIN, MAX, TIME
var centerWindow:Bool = false;

function shakeyWindowShit(elapsed:Float) {
    if (windowShake[2] <= 0) {
        if (window.x == (Capabilities.screenResolutionX - window.width) / 2 && window.y == (Capabilities.screenResolutionY - window.height) / 2) 
            return;

        if (centerWindow) {
            window.x = (Capabilities.screenResolutionX - window.width) / 2;
            window.y = (Capabilities.screenResolutionY - window.height) / 2;
        }

        return;
    }

    if (windowShake[2] > 0)
        windowShake[2] -= elapsed;

    if (centerWindow) {
        window.x = (Capabilities.screenResolutionX - window.width) / 2 + FlxG.random.float(windowShake[0], windowShake[1]);
        window.y = (Capabilities.screenResolutionY - window.height) / 2 + FlxG.random.float(windowShake[0], windowShake[1]);
    } else {
        window.x += FlxG.random.float(windowShake[0], windowShake[1]);
        window.y += FlxG.random.float(windowShake[0], windowShake[1]);
    }
}

function onCameraMove(e) {
    if (manualCamera) e.cancel();
}

var leftWindow:Window;
var rightWindow:Window;

function ballsdotexe() {
    FlxG.autoPause = true;

    for (bgItems in [sky, bushes, bg]) {
        bgItems.visible = false;
    }
    for (evilStage in [codeBackdrop, overlay]) {
        evilStage.visible = true;
    }

    strumLines.members[0].characters[1].alpha = 1;
    strumLines.members[0].characters[0].visible = false;
}

function resizeWindow(width:Int, height:Int, ?skip:Bool = false, ?time:Float = 0.5) {
	final winShit = [width * (1080 / Capabilities.screenResolutionY), height * (1080 / Capabilities.screenResolutionY)];
	FlxTween.cancelTweensOf(window);

	if (!skip) {
		FlxTween.tween(window, {
			width: winShit[0],
			height: winShit[1], 
			y: Math.floor((Capabilities.screenResolutionY / 2) - (winShit[1] / 2)), 
			x: Math.floor(((Capabilities.screenResolutionX) / 2) - (winShit[0] / 2)) + ((Capabilities.screenResolutionX) * Math.floor(window.x / (Capabilities.screenResolutionX)))
		}, time);
	} else {
		FlxG.resizeWindow(width, height);
		FlxG.width = winShit[0];
		FlxG.height = winShit[1];
		window.y = Math.floor((Capabilities.screenResolutionY / 2) - (winShit[1] / 2));
		window.x = Math.floor(((Capabilities.screenResolutionX) / 2) - (winShit[0] / 2)) + ((Capabilities.screenResolutionX) * Math.floor(window.x / (Capabilities.screenResolutionX)));
	}
	
	FlxG.scaleMode = new RatioScaleMode(true);
	window.resizable = width == 1280;
    ShaderResizeFix.doResizeFix = true;
    ShaderResizeFix.fixSpritesShadersSizes();
}

function destroy() {
    window.borderless = false;
    window.opacity = 1;
    FlxG.autoPause = true;
    resizeWindow(1280, 720, true);
}