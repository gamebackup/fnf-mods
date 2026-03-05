import flixel.addons.display.FlxBackdrop;
import openfl.display.BlendMode;

var blackIntro:FlxSprite;
var manualCam:Bool = false;

var godraysShader = new CustomShader('godrays');

function create() {
    FlxG.cameras.add(camGodrays = new FlxCamera(), false).bgColor = 0;
    FlxG.cameras.add(camNoGodrays = new FlxCamera(), false).bgColor = 0;
}

function postCreate() {
    blackIntro = new FlxSprite(0, -1000).makeGraphic(FlxG.width * 4, FlxG.height * 4, FlxColor.BLACK);
    blackIntro.camera = FlxG.camera;
    add(blackIntro);

    FlxG.camera.zoom = defaultCamZoom = 1.0;
    FlxG.camera.followLerp = 0.025;
    camFollow.setPosition(1550, 0);
    FlxG.camera.snapToTarget();
    manualCam = true;
    camMove = false;
    camHUD.alpha = 0;

    for (godrayCams in [camNoGodrays, camGodrays]) {
        godrayCams.follow(camFollow, 1, 0.04);
        godrayCams.zoom = defaultCamZoom;
        godrayCams.visible = false;
    }

    healthBar.createFilledBar(FlxColor.fromRGB(255, 0, 0), FlxColor.fromRGB(0, 255, 0));
    healthBar.percent = health;

    mistHandler();

    remove(transition);
    insert(members.indexOf(scoreTxt) + 50, transition);
    
    transition.camera = camHUD;
    clouds2.blend = stars.blend = BlendMode.ADD;

    blurShader = new CustomShader('blur');
    blurShader.directions = 16;
    blurShader.quality = 4;
    blurShader.size = 0;

    strumLines.members[3].characters[0].alpha = 0.001;
    strumLines.members[3].characters[0].shader = blurShader;

    heatShader = new CustomShader("heatShader");

    if (Options.gameplayShaders) {
        for (clouds in [clouds2, clouds]) {
            clouds.shader = heatShader;
        }

        camGodrays.addShader(godraysShader);
        godraysShader.hset("_LightPos", [0.6, -0.2]);
        godraysShader.hset("Exposure", 0.75);
    }

    for (godrayChars in [strumLines.members[0].characters[0], strumLines.members[1].characters[0], strumLines.members[2].characters[0], strumLines.members[3].characters[0]]) {
        godrayChars.camera = camGodrays;
    }
    for (godrayItemsAct1 in [sky, city, windows, stage2, smokeBack, stage, smokeFront]) {
        godrayItemsAct1.camera = camGodrays;
    }
    for (godrayItemsAct2 in [stars, clouds2, clouds, city2, windows2]) {
        godrayItemsAct2.camera = camGodrays;
    }

    for (noGodrayItems in [fence, overlay, overlay2]) {
        noGodrayItems.camera = camNoGodrays;
    }
    sky.alpha = 0.75;

    gradient = new FlxBackdrop(Paths.image('stages/alley/gradient'), FlxAxes.X);
    gradient.color = 0xFF136109;
    gradient.y += 1000;
    gradient.camera = camGodrays;
    gradient.alpha = 0.001;
    insert(members.indexOf(windows) + 1, gradient);

    remove(comboGroup);
}

var mist1:FlxBackdrop;
var mist2:FlxBackdrop;
var mist3:FlxBackdrop;
var mist4:FlxBackdrop;
var mist5:FlxBackdrop;
var mist6:FlxBackdrop;

function mistHandler() {
    mist1 = new FlxBackdrop(Paths.image('stages/alley/mistMid'), FlxAxes.X);
    mist1.scrollFactor.set(1.2, 1);
    mist1.velocity.x = 72;

    mist2 = new FlxBackdrop(Paths.image('stages/alley/mistMid'), FlxAxes.X);
    mist2.scrollFactor.set(1.1, 1);
    mist2.velocity.x = 50;

    for (mistBackItems in [mist1, mist2]) {
        mistBackItems.color = 0xFF384F35;
        mistBackItems.y = 450;
        // mistBackItems.alpha = 0.6;
        mistBackItems.blend = BlendMode.ADD;
        insert(members.indexOf(windows) + 1, mistBackItems);
    }

    mist3 = new FlxBackdrop(Paths.image('stages/alley/mistBack'), FlxAxes.X);
    mist3.scrollFactor.set(1.2, 1);
    mist3.velocity.x = 50;

    mist4 = new FlxBackdrop(Paths.image('stages/alley/mistMid'), FlxAxes.X);
    mist4.scrollFactor.set(1.1, 1);
    mist4.velocity.x = -80;

    for (mistMidItems in [mist3, mist4]) {
        mistMidItems.color = 0xFF384F35;
        mistMidItems.y = 450;
        // mistMidItems.alpha = 0.45;
        mistMidItems.blend = BlendMode.ADD;
        insert(members.indexOf(stage2) + 1, mistMidItems);
    }

    mist5 = new FlxBackdrop(Paths.image('stages/alley/mistBack'), FlxAxes.X);
    mist5.scrollFactor.set(0.5, 1);
    mist5.velocity.x = 50;

    mist6 = new FlxBackdrop(Paths.image('stages/alley/mistMid'), FlxAxes.X);
    mist6.scrollFactor.set(1.1, 1);
    mist6.velocity.x = -80;

    for (mistFrontItems in [mist5, mist6]) {
        mistFrontItems.color = 0xFF384F35;
        mistFrontItems.y = 800;
        // mistFrontItems.alpha = 0.3;
        mistFrontItems.blend = BlendMode.ADD;
        insert(members.indexOf(fence) + 1, mistFrontItems);
    }

    for (mistItems in [mist1, mist2, mist3, mist4, mist5, mist6]) {
        mistItems.alpha = 0.001;
        mistItems.camera = camGodrays;
    }
}

function onSongStart() {
    FlxTween.tween(blackIntro, {alpha: 0}, 5, {ease: FlxEase.quadInOut});
    FlxTween.tween(camFollow, {y: 1200}, 10, {ease: FlxEase.quadInOut});

    FlxTween.tween(FlxG.camera, {zoom: 0.6}, 10, {ease: FlxEase.quadInOut, onComplete: function() {
        FlxG.camera.zoom = defaultCamZoom = 0.6;
    }});

    for(strums in strumLines) {
        strums.forEach(function(strum) {
            strum.alpha = 0.001;
        });
    }

    for (godrayCams in [camNoGodrays, camGodrays]) {
        godrayCams.visible = true;
    }
    blackIntro.camera = camNoGodrays;
}

var flashWindows:Bool = true;
var flashWindows2:Bool = false;

var flashGradient:Bool = false;
var flashGradient2:Bool = false;

var act2:Bool = false;

function beatHit(curBeat:Int) {
    if (curBeat % 4 == 0) {
        if (flashGradient) {
            gradient.alpha = 0.85;
            FlxTween.tween(gradient, {alpha: 0}, 2, {ease: FlxEase.cubeOut});
        }
        if (flashWindows) {
            windows.alpha = 1;
            FlxTween.tween(windows, {alpha: 0}, 2, {ease: FlxEase.cubeOut});
        }
        if (act2) {
            windows2.alpha = 1;
            FlxTween.tween(windows2, {alpha: 0}, 2, {ease: FlxEase.cubeOut});
        }
    }
    if (curBeat % 2 == 0) {
        if (flashGradient2) {
            gradient.alpha = 0.85;
            FlxTween.tween(gradient, {alpha: 0}, 1, {ease: FlxEase.cubeOut});
        }
        if (flashWindows2) {
            windows.alpha = 1;
            FlxTween.tween(windows, {alpha: 0}, 1, {ease: FlxEase.cubeOut});
        }
    }
    if (curBeat % 1 == 0 && act2) {
        stars.alpha = 1;
        FlxTween.tween(stars, {alpha: 0.4}, 1, {ease: FlxEase.cubeOut});
    }

    switch(curBeat) {
        case 16:
            FlxTween.tween(FlxG.camera, {zoom: 0.625}, 1.5, {ease: FlxEase.quadInOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.625;
            }});

            FlxTween.tween(camHUD, {alpha: 1}, 1.5, {ease: FlxEase.cubeOut});
            manualCam = false;

            for(strums in strumLines) {
                strums.forEach(function(strum) {
                    switch(strum.ID) {
                        case 0:
                            FlxTween.tween(strum, {alpha: 1}, 1.5, {ease: FlxEase.linear});
                        case 1:
                            FlxTween.tween(strum, {alpha: 1}, 1.5, {ease: FlxEase.linear, startDelay: 2.7});
                        case 2:
                            FlxTween.tween(strum, {alpha: 1}, 1.5, {ease: FlxEase.linear, startDelay: 5.4});
                        case 3:
                            FlxTween.tween(strum, {alpha: 1}, 1.5, {ease: FlxEase.linear, startDelay: 8.1});
                    }
                });
            }

            camZoomingStrength = 0;
        case 20:
            FlxTween.tween(FlxG.camera, {zoom: 0.65}, 1.5, {ease: FlxEase.quadInOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.65;
            }});
        case 24:
            FlxTween.tween(FlxG.camera, {zoom: 0.675}, 1.5, {ease: FlxEase.quadInOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.675;
            }});
        case 28:
            FlxTween.tween(FlxG.camera, {zoom: 0.7}, 1.5, {ease: FlxEase.quadInOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.7;
            }});
        case 32:
            FlxTween.tween(FlxG.camera, {zoom: 0.725}, 1.5, {ease: FlxEase.quadInOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.725;
            }});
            camZoomingStrength = 1;
        case 64:
            FlxTween.tween(FlxG.camera, {zoom: 0.65}, 1.5, {ease: FlxEase.quadInOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.65;
            }});
            camZoomingInterval = 2;
        case 103:
            FlxTween.tween(FlxG.camera, {zoom: 0.75}, 0.25, {ease: FlxEase.quadOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.75;
            }});
            FlxTween.tween(mist6, {alpha: 0.3}, 3, {ease: FlxEase.cubeInOut});
        case 104:
            FlxTween.tween(FlxG.camera, {zoom: 0.65}, 0.25, {ease: FlxEase.quadOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.65;
            }});
        case 127:
            FlxTween.tween(mist5, {alpha: 0.3}, 3, {ease: FlxEase.cubeInOut});
            flashGradient = true;
        case 128:
            camZoomingInterval = 4;
            FlxTween.tween(FlxG.camera, {zoom: 0.7}, 1.5, {ease: FlxEase.quadOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.7;
            }});
        case 143:
            FlxTween.tween(mist4, {alpha: 0.45}, 3, {ease: FlxEase.cubeInOut});
        case 155:
            FlxTween.tween(mist3, {alpha: 0.45}, 3, {ease: FlxEase.cubeInOut});
        case 157:
            FlxTween.tween(mist2, {alpha: 0.6}, 3, {ease: FlxEase.cubeInOut});
        case 160:
            FlxTween.tween(FlxG.camera, {zoom: 0.65}, 1.5, {ease: FlxEase.quadOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.65;
            }});
        case 175:
            FlxTween.tween(FlxG.camera, {zoom: 0.75}, 0.25, {ease: FlxEase.quadOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.75;
            }});
            FlxTween.tween(mist1, {alpha: 0.6}, 3, {ease: FlxEase.cubeInOut});
        case 176:
            FlxTween.tween(FlxG.camera, {zoom: 0.65}, 0.25, {ease: FlxEase.quadOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.65;
            }});
        case 191:
            flashGradient = flashWindows = false;
            camZoomingStrength = 0;
        case 192:
            FlxTween.tween(smokeBack, {alpha: 0.5}, 2, {ease: FlxEase.cubeOut});
            FlxTween.tween(smokeFront, {alpha: 0.5}, 2, {ease: FlxEase.cubeOut});

            FlxTween.tween(FlxG.camera, {zoom: 0.75}, 1.5, {ease: FlxEase.quadOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.75;
            }});
        case 199:
            flashGradient2 = flashWindows2 = true;
        case 200:
            camZoomingInterval = camZoomingStrength = 1;
            FlxTween.tween(FlxG.camera, {zoom: 0.65}, 1.5, {ease: FlxEase.quadOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.65;
            }});

            // add particle shit here
        case 231:
            FlxTween.tween(FlxG.camera, {zoom: 0.75}, 0.25, {ease: FlxEase.quadOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.75;
            }});
        case 232:
            FlxTween.tween(FlxG.camera, {zoom: 0.65}, 0.25, {ease: FlxEase.quadOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.65;
            }});
        case 255:
            camZoomingStrength = 0;
            camZoomingInterval = 4;
            
            flashWindows2 = flashGradient2 = false;
        case 256:
            FlxTween.tween(camHUD, {alpha: 0}, 1, {ease: FlxEase.linear});
            FlxTween.tween(FlxG.camera, {zoom: 0.7}, 1, {ease: FlxEase.quadOut, onComplete: function() {
                FlxG.camera.zoom = defaultCamZoom = 0.7;
            }});
        case 258:
            for (hudItems in [accuracyTxt, missesTxt, scoreTxt, healthBar, healthBarBG, iconP1, iconP2]) {
                hudItems.alpha = 0;
            }
            for(strums in strumLines) {
                strums.forEach(function(strum) {
                    strum.alpha = 0;
                });
            }
            camHUD.alpha = 1;
            transition.animation.play('smoke', true);
        case 259:
            act2 = true;
        case 260:
            godraysShader.hset("_LightPos", [0.15, 0.1]);
            godraysShader.hset("Exposure", 0.45);
            camZoomingStrength = 1;

            for (hudItems in [accuracyTxt, missesTxt, scoreTxt, healthBar, healthBarBG, iconP1, iconP2]) {
                hudItems.alpha = 1;
            }
            for (opponentStrum in strumLines.members[0].members) {
                opponentStrum.alpha = 0;
            }
            for (playerStrum in strumLines.members[1].members) {
                playerStrum.alpha = 1;
            }
            for (chars in [strumLines.members[0].characters[0], strumLines.members[2].characters[0]]) {
                chars.alpha = 0.001;
            }

            blurShader.size = 20;
            FlxTween.tween(blurShader, {size: 1}, 2, {ease: FlxEase.quadInOut});

            strumLines.members[3].characters[0].y += 100;
            FlxTween.tween(strumLines.members[3].characters[0], {y: strumLines.members[3].characters[0].y - 100, alpha: 0.6}, 2, {ease: FlxEase.quadOut});
            strumLines.members[1].characters[0].y += 200;

            for (stageItems in [sky, city, windows, gradient, stage2, smokeBack, stage, smokeFront, fence, mist1, mist2, mist3, mist4, mist5, mist6]) {
                stageItems.alpha = 0.001;
            }
            for (newStageItems in [sky2, clouds2, clouds, city2, overlay2]) {
                newStageItems.alpha = 1;
                newStageItems.x += 150;
                newStageItems.y += 400;
            }
            for (flashingItems in [stars, windows2]) {
                flashingItems.x += 150;
                flashingItems.y += 400;
            }
            FlxG.camera.zoom = defaultCamZoom = 0.9;
        case 328:
            FlxTween.tween(strumLines.members[3].characters[0], {alpha: 0}, 3, {ease: FlxEase.quadInOut});
            FlxTween.tween(blurShader, {size: 64}, 3, {ease: FlxEase.quadIn});
    }
}

var mistTimer:Float = 0;
var heatShaderTimer:Float = 0;

function update(elapsed:Float) {
    if (act2) return;
    mistTimer += elapsed;
	mist1.y = 400 + (Math.sin(mistTimer * 0.35) * 70);
	mist2.y = 500 + (Math.sin(mistTimer * 0.3) * 80);
	mist3.y = 450 + (Math.sin(mistTimer * 0.4) * 60);
	mist4.y = 550 + (Math.sin(mistTimer * 0.3) * 70);
	mist5.y = 850 + (Math.sin(mistTimer * 0.35) * 50);
	mist6.y = 900 + (Math.sin(mistTimer * 0.08) * 100);
}

function postUpdate(elapsed:Float) {
    if (Options.gameplayShaders)
        heatShader.hset("iTime", heatShaderTimer += elapsed);

    godraysHandler();
}

function godraysHandler() {
    for (godrayCams in [camNoGodrays, camGodrays]) {
        godrayCams.scroll.set(camGame.scroll.x, camGame.scroll.y);
        godrayCams.zoom = camGame.zoom;
        godrayCams.angle = camGame.angle;
    }
}

function onCameraMove(e) {
    if (manualCam) e.cancel();
}

function onEvent(e) {
    if (e.event.name != 'Camera Movement' || act2) return;

    new FlxTimer().start(0.01, (_) -> {
        switch (curCameraTarget) {
            case 0:
                FlxTween.num(godraysShader.hget("_LightPos")[0], 0.6, 1.5, {ease: FlxEase.quadOut}, function(num) {
                    godraysShader.hset("_LightPos", [num, -0.2]);
                });
            case 1:
                FlxTween.num(godraysShader.hget("_LightPos")[0], 0.5, 1.5, {ease: FlxEase.quadOut}, function(num) {
                    godraysShader.hset("_LightPos", [num, -0.2]);
                });
        }
    });
}

function onGameOver() {
    camGodrays.removeShader(godraysShader);
}