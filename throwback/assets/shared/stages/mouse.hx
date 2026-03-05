import flixel.text.FlxTextAlign;
import flixel.math.FlxRect;
import flixel.addons.util.FlxSimplex;

var vhsShader:CustomShader = new CustomShader('vhs');
var vcrShader:CustomShader = new CustomShader('vcr');
var chromAbbShader:CustomShader = new CustomShader('chromAbb');
var blackNwhiteShader:CustomShader = new CustomShader('blackNwhite');
var bloomShader:CustomShader = new CustomShader('bloom');

var blackIntro:FlxSprite;
var manualCam:Bool = false;

var dontMiss:FlxText;

function create() {
    camMove = false;
    introSounds = ['mouse/intro3', 'mouse/intro2', 'mouse/intro1', 'mouse/introGo'];
    FlxG.camera.followLerp = 0.1;
    camZoomingStrength = 0;
    strumLines.members[0].characters[1].alpha = 0.001;

    if (Options.gameplayShaders) {
        FlxG.camera.addShader(vhsShader);
        FlxG.camera.addShader(bloomShader);
    }

    blackIntro = new FlxSprite().makeGraphic(FlxG.width * 4, FlxG.height * 4, FlxColor.BLACK);
    blackIntro.camera = FlxG.camera;
    FlxTween.tween(blackIntro, {alpha: 0.5}, 6, {ease: FlxEase.quadInOut});
    add(blackIntro);
}

function postCreate() {
    for (hudTxt in [scoreTxt, missesTxt, accuracyTxt]) {
        hudTxt.font = Paths.font('MilkyNice.ttf');
    }

    cinematicBars(true, 0.01, 3.35);
    makeMouseHud();

    dontMiss = new FlxText(0, 0, FlxG.width, "DON'T MISS.", 64);
    dontMiss.setFormat(Paths.font('MilkyNice.ttf'), 64, FlxColor.BLACK, FlxTextAlign.CENTER);
    dontMiss.screenCenter();
    dontMiss.y -= 80;
    dontMiss.antialiasing = Options.antialiasing;
    dontMiss.camera = camHUD;
    dontMiss.alpha = 0.001;
    add(dontMiss);

    FlxG.camera.zoom = defaultCamZoom = 1.2;
    comboGroup.x += 900;
    comboGroup.y += 750;
}

var songNameTxt:FlxText;

var ratings:Array<String> = ["Shit: 0", "Bad: 0", "Good: 0", "Sick: 0"];
var ratingTxtGroup:FlxTypedGroup<FlxSprite> = new FlxTypedGroup();

function makeMouseHud() {
    songNameTxt = new FlxText(25, FlxG.height - 50, FlxG.width, "Unknown Suffering", 18);
    songNameTxt.setFormat(Paths.font('MilkyNice.ttf'), 18, FlxColor.WHITE);
    songNameTxt.antialiasing = Options.antialiasing;
    songNameTxt.camera = camHUD;
    add(songNameTxt);

    for (i in 0...ratings.length) {
        var ratingTxt:FlxText = new FlxText(FlxG.width - 100, FlxG.height - (75 + (i * 25)), FlxG.width, ratings[i], 18);
        ratingTxt.ID = i;
        ratingTxt.setFormat(Paths.font('MilkyNice.ttf'), 18, FlxColor.WHITE);
        ratingTxt.antialiasing = Options.antialiasing;
        ratingTxt.camera = camHUD;
        ratingTxtGroup.add(ratingTxt);
    }
    add(ratingTxtGroup);

    var hudTxts:Array<FlxText> = [accuracyTxt, missesTxt, scoreTxt];
    for (i in 0...hudTxts.length) {
        var txt = hudTxts[i];
        txt.setPosition(25, FlxG.height - (100 + (i * 25)));
        txt.setFormat(Paths.font('MilkyNice.ttf'), 18, FlxColor.WHITE);
        txt.alignment = FlxTextAlign.LEFT;
    }
    timeBarCreate();
}

var timeBar:FlxSprite;
var timeTxt:FlxText;

function timeBarCreate() {
    final blackBar = new FlxSprite(28, 697).makeGraphic(1220, 12, 0xFF000000);
    blackBar.antialiasing = Options.antialiasing;
    blackBar.cameras = [camHUD];
    insert(15, blackBar);

    timeBar = new FlxSprite(blackBar.x, blackBar.y).makeGraphic(blackBar.width, blackBar.height, 0xFFFFFFFF);
    timeBar.setPosition(blackBar.x, blackBar.y);
    timeBar.antialiasing = Options.antialiasing;
    timeBar.cameras = [camHUD];
    insert(17, timeBar);

    timeTxt = new FlxText(blackBar.width / 2 - 35, blackBar.y + (Options.downscroll ? 3 : -30), FlxG.width, '0:00 - 0:00', 22);
    timeTxt.setFormat(Paths.font('MilkyNice.ttf'), 22, FlxColor.WHITE);
    timeTxt.antialiasing = Options.antialiasing;
    timeTxt.cameras = [camHUD];
    timeTxt.alpha = 1;
    add(timeTxt);
}

function onCountdown(event) {
    event.scale = 1;
	event.spritePath = switch(event.swagCounter) {
		case 1: 'game/mouse/ready';
		case 2: 'game/mouse/set';
		case 3: 'game/mouse/go';
	};
}

var bloomIntensity:Float = 0;
var fakeTimer:Bool = true;
function postUpdate(elapsed) {
    updateRatingStuff();
    if (shakeCam && curBeat >= 68) {
        if (health >= 1.8) iconP2.x += FlxG.random.float(-7, 7);
        else iconP2.x += FlxG.random.float(-3, 3);
    }

    if (fakeTimer) {
        if (timeBar != null) timeBar.clipRect = new FlxRect(0, 0, (timeBar.frameWidth * 1) * (Conductor.songPosition / (inst.length - 58000)), timeBar.frameHeight);

        if (inst != null && timeTxt != null) {
            timeTxt.text = Std.int(inst.time / 60 / 1000) + ':' + CoolUtil.addZeros(Std.int(inst.time / 1000) % 60, 2) + " - 2:38";
        }
    } else {
        if (timeBar != null) timeBar.clipRect = new FlxRect(0, 0, (timeBar.frameWidth * 1) * (Conductor.songPosition / inst.length), timeBar.frameHeight);
        
        if (inst != null && timeTxt != null) {
            timeTxt.text = Std.int(inst.time / 60 / 1000) + ':' + CoolUtil.addZeros(Std.int(inst.time / 1000) % 60, 2) + " - 3:36";
        }
    }

    if (Options.gameplayShaders) {
        vhsShader.iTime = Conductor.songPosition / 1000;
        vcrShader.iTime = Conductor.songPosition / 1000;
        chromAbbShader.iTime = Conductor.songPosition / 1000;
        blackNwhiteShader.iTime = Conductor.songPosition / 1000;
        
        bloomShader.iTime = Conductor.songPosition / 1000;
        if (bloomIntensity <= 0) return;
        bloomIntensity -= 0.0225;
        bloomShader.hset("intensity", bloomIntensity);
    }
}

function updateRatingStuff() {
    scoreTxt.text = 'Score: ' + songScore;
    missesTxt.text = 'Misses: ' + misses;
    accuracyTxt.text = 'Accuracy: ' + (accuracy < 0 ? "0" : CoolUtil.quantize(accuracy * 100, 100));
}

function beatHit() {
    switch (curBeat) {
        case 14:
            FlxTween.tween(strumLines.members[0].characters[0], {alpha: 0.2}, 0.2, {ease: FlxEase.quadInOut});
            FlxTween.tween(strumLines.members[0].characters[1], {alpha: 0.8}, 0.2, {ease: FlxEase.quadInOut});

            iconP2.setIcon('mouse-suffer');
            if (Options.gameplayShaders) {
                iconP2.shader = strumLines.members[0].characters[0].shader = strumLines.members[0].characters[1].shader = blackNwhiteShader;
                FlxG.camera.addShader(vcrShader);
            }

            cinematicBars(true, 0.3, 5);
            shakeCam = true;
            defaultCamZoom = 0.95;
        case 15:
            FlxTween.tween(strumLines.members[0].characters[0], {alpha: 1}, 0.2, {ease: FlxEase.quadInOut, startDelay: 0.25});
            FlxTween.tween(strumLines.members[0].characters[1], {alpha: 0}, 0.2, {ease: FlxEase.quadInOut, startDelay: 0.25});
        case 16:
            iconP2.setIcon('mouse');
            if (Options.gameplayShaders) {
                FlxG.camera.removeShader(vcrShader);
                iconP2.shader = strumLines.members[0].characters[0].shader = strumLines.members[0].characters[1].shader = "remove";
            }
            shakeCam = false;
            defaultCamZoom = 0.85;
            cinematicBars(true, 0.7, 3.35);
        case 28:
            FlxTween.tween(strumLines.members[0].characters[0], {alpha: 0.4}, 1, {ease: FlxEase.quadInOut});
            FlxTween.tween(strumLines.members[0].characters[1], {alpha: 0.6}, 1, {ease: FlxEase.quadInOut});

            iconP2.setIcon('mouse-suffer');
            if (Options.gameplayShaders) {
                iconP2.shader = strumLines.members[0].characters[0].shader = strumLines.members[0].characters[1].shader = blackNwhiteShader;
                FlxG.camera.addShader(vcrShader);
            }

            shakeCam = true;
            FlxTween.tween(blackIntro, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
            defaultCamZoom = 0.95;
            camZoomingInterval = 8;
            camZoomingStrength = 3;
            cinematicBars(true, 0.3, 5);
        case 30:
            defaultCamZoom = 1.05;
            cinematicBars(true, 0.7, 2);
        case 32:
            cinematicBars(false, 0.4);
            if (Options.gameplayShaders) {
                bloomIntensity = 4;
                bloomShader.hset("intensity", bloomIntensity);
            }

            manualCam = true;
            FlxTween.tween(camFollow, {x: 1760, y: 1168.5}, 1, {ease: FlxEase.quadInOut, onComplete: (_) -> {
                manualCam = false;
                FlxTween.tween(strumLines.members[0].characters[0], {alpha: 1}, 0.2, {ease: FlxEase.quadInOut, startDelay: 0.25});
                FlxTween.tween(strumLines.members[0].characters[1], {alpha: 0}, 0.2, {ease: FlxEase.quadInOut, startDelay: 0.25, onComplete: (_) -> {
                    iconP2.setIcon('mouse');
                    if (Options.gameplayShaders) iconP2.shader = strumLines.members[0].characters[0].shader = strumLines.members[0].characters[1].shader = "remove";
                }});
            }});
        case 44:
            FlxG.camera.followLerp = 0.25;

            FlxTween.tween(strumLines.members[0].characters[0], {alpha: 0.6}, 0.2, {ease: FlxEase.quadInOut});
            FlxTween.tween(strumLines.members[0].characters[1], {alpha: 0.4}, 0.2, {ease: FlxEase.quadInOut});

            iconP2.setIcon('mouse-suffer');
            if (Options.gameplayShaders) {
                iconP2.shader = strumLines.members[0].characters[0].shader = strumLines.members[0].characters[1].shader = blackNwhiteShader;
                FlxG.camera.addShader(vcrShader);
            }
        case 47:
            FlxTween.tween(strumLines.members[0].characters[0], {alpha: 1}, 0.2, {ease: FlxEase.quadInOut, startDelay: 0.25});
            FlxTween.tween(strumLines.members[0].characters[1], {alpha: 0}, 0.2, {ease: FlxEase.quadInOut, startDelay: 0.25});
        case 48:
            FlxG.camera.followLerp = 0.1;
            defaultCamZoom = 1.1;

            iconP2.setIcon('mouse');
            if (Options.gameplayShaders) {
                FlxG.camera.removeShader(vcrShader);
                iconP2.shader = strumLines.members[0].characters[0].shader = strumLines.members[0].characters[1].shader = "remove";
            }
        case 56:
            camZoomingInterval = 4;
            cinematicBars(true, 1, 3.35);
            middleCam(true);

            FlxTween.tween(strumLines.members[0].characters[0], {alpha: 0.8}, 1, {ease: FlxEase.quadInOut});
            FlxTween.tween(strumLines.members[0].characters[1], {alpha: 0.2}, 1, {ease: FlxEase.quadInOut});

            iconP2.setIcon('mouse-suffer');
            if (Options.gameplayShaders) {
                iconP2.shader = strumLines.members[0].characters[0].shader = strumLines.members[0].characters[1].shader = blackNwhiteShader;
                FlxG.camera.addShader(vcrShader);
            }
        case 60:
            defaultCamZoom = 0.75;
        case 61:
            FlxTween.tween(strumLines.members[0].characters[0], {alpha: 1}, 0.2, {ease: FlxEase.quadInOut, startDelay: 0.25});
            FlxTween.tween(strumLines.members[0].characters[1], {alpha: 0}, 0.2, {ease: FlxEase.quadInOut, startDelay: 0.25});
        case 62:
            iconP2.setIcon('mouse');
            if (Options.gameplayShaders) {
                FlxG.camera.removeShader(vcrShader);
                iconP2.shader = strumLines.members[0].characters[0].shader = strumLines.members[0].characters[1].shader = "remove";
            }
        case 63:
            defaultCamZoom = 0.85;
            middleCam(false);
            cinematicBars(false, 1.5);
        case 64:
            FlxTween.tween(camHUD, {alpha: 0}, 0.7, {ease: FlxEase.linear, onComplete: (_) -> {
                iconP2.setIcon('mouse-suffer');
            }});
            camZoomingStrength = 0;
        case 68:
            camZoomingInterval = camZoomingStrength = 1;
            camMove = true;
            if (Options.gameplayShaders) {
                bloomIntensity = 4;
                bloomShader.hset("intensity", bloomIntensity);
            }
            camHUD.flash(0xffffff, 0.7);
            camHUD.alpha = 1;
            strumLines.members[0].characters[0].alpha = 0;
            strumLines.members[0].characters[1].alpha = 1;
            staticThingy.alpha = 0.1;
        case 73, 267:
            defaultCamZoom = 0.9;
        case 74, 268:
            defaultCamZoom = 1.0;
        case 76, 270:
            defaultCamZoom = 0.85;
        case 89, 283:
            defaultCamZoom = 1.05;
        case 90, 284:
            defaultCamZoom = 1.15;
        case 92, 286:
            defaultCamZoom = 1.0;
        case 108, 302:
            defaultCamZoom = 0.95;
            cinematicBars(true, 0.3, 5);
        case 110, 304:
            defaultCamZoom = 0.85;
            cinematicBars(false, 0.3);
        case 124, 318:
            defaultCamZoom = 1.15;
            cinematicBars(true, 0.3, 5);
        case 126, 320:
            defaultCamZoom = 1.0;
            cinematicBars(false, 0.3);
        case 128:
            camMove = false;
            manualCam = true;
            camZoomingStrength = 0;

            // this kinda still sucks but whatever
            FlxTween.tween(camFollow, {x: 1420, y: 1050}, 0.3, {ease: FlxEase.quadOut, onComplete: (_) -> {
                FlxTween.tween(camFollow, {x: 1233.75, y: 1003.5}, 0.3, {ease: FlxEase.cubeIn, startDelay: 0.5});
            }});
            FlxTween.tween(FlxG.camera, {zoom: 0.65}, 1.0, {ease: FlxEase.quadOut, onComplete: (_) -> {
                FlxTween.tween(FlxG.camera, {zoom: 0.85}, 0.2, {ease: FlxEase.cubeIn, onComplete: (_) -> {
                    camMove = true;
                    manualCam = false;
                }});
            }});
        case 132:
            camZoomingStrength = 1;
            camHUD.flash(0xffffff, 0.7);
            if (Options.gameplayShaders) {
                bloomIntensity = 4;
                bloomShader.hset("intensity", bloomIntensity);
            }
        case 133, 327:
            defaultCamZoom = 0.95;
        case 135, 329:
            defaultCamZoom = 0.85;
        case 139, 333:
            FlxTween.tween(FlxG.camera, {zoom: 0.85}, 0.3, {ease: FlxEase.quadOut, onComplete: (_) -> {
                defaultCamZoom = FlxG.camera.zoom;
            }});
        case 143, 337:
            FlxTween.tween(FlxG.camera, {zoom: 0.85}, 0.3, {ease: FlxEase.quadOut, onComplete: (_) -> {
                defaultCamZoom = FlxG.camera.zoom;
            }});
        case 145, 339:
            defaultCamZoom = 0.95;
        case 147, 341:
            defaultCamZoom = 0.85;
        case 149, 343:
            defaultCamZoom = 1.1;
        case 151, 345:
            defaultCamZoom = 1.0;
        case 155, 349:
            FlxTween.tween(FlxG.camera, {zoom: 1.0}, 0.3, {ease: FlxEase.quadOut, onComplete: (_) -> {
                defaultCamZoom = FlxG.camera.zoom;
            }});
        case 156, 350:
            middleCam(true);
            camMove = false;

            cinematicBars(true, 3, 4);
            defaultCamZoom = 1.05;
        case 157, 351:
            defaultCamZoom = 0.85;
        case 158, 352:
            defaultCamZoom = 0.95;
        case 159, 353:
            defaultCamZoom = 0.85;
        case 160, 354:
            defaultCamZoom = 1.05;
        case 161, 355:
            defaultCamZoom = 0.85;
        case 162, 356:
            defaultCamZoom = 0.95;
        case 163, 357:
            defaultCamZoom = 0.85;
        case 164, 358:
            middleCam(false);
            camMove = true;
            cinematicBars(false, 0.3);
            defaultCamZoom = 0.95;
        case 166, 360:
            defaultCamZoom = 0.85;
            camZoomingStrength = 0;
        case 168, 362:
            defaultCamZoom = 0.95;
            camZoomingStrength = 1;
        case 170, 364:
            defaultCamZoom = 0.85;
            camZoomingStrength = 0;
        case 172, 366:
            defaultCamZoom = 0.95;
            camZoomingStrength = 1;
        case 174, 368:
            defaultCamZoom = 1.05;
            camZoomingStrength = 0;
        case 176, 370:
            defaultCamZoom = 0.85;
            middleCam(true);
            camMove = false;
            camZoomingStrength = 1;
        case 180, 374:
            middleCam(false);
            camMove = true;
            defaultCamZoom = 1.1;
        case 182, 376:
            defaultCamZoom = 1.0;
            camZoomingStrength = 0;
        case 184, 378:
            defaultCamZoom = 1.1;
            camZoomingStrength = 1;
        case 186, 380:
            defaultCamZoom = 1.0;
            camZoomingStrength = 0;
        case 188, 382:
            defaultCamZoom = 1.1;
            camZoomingStrength = 1;
        case 190, 384:
            defaultCamZoom = 1.0;
            camZoomingStrength = 0;
        case 192:
            camZoomingStrength = 1;
            defaultCamZoom = 0.85;
            camMove = false;
            middleCam(true);
            cinematicBars(true, 1.2, 1);
        case 196:
            camZoomingStrength = 0;
        case 197:
            camZoomingStrength = 3;
        case 198:
            shakeCam = false;
            badApple(true);
            cinematicBars(false, 0.2);
            defaultCamZoom = 1;
            camZoomingStrength = 0;
            if (Options.gameplayShaders) {
                camGame.addShader(chromAbbShader);
                camHUD.addShader(chromAbbShader);
            }

            FlxTween.tween(FlxG.camera, {zoom: 0.3}, 0.01, {ease: FlxEase.quadOut, onComplete: (_) -> {
                FlxTween.tween(FlxG.camera, {zoom: 0.85}, 6, {ease: FlxEase.quadOut, onComplete: (_) -> {
                    defaultCamZoom = FlxG.camera.zoom;
                }});
            }});
            strumLines.members[1].characters[0].x -= 550;
            strumLines.members[1].characters[0].y -= 85;
        case 212:
            FlxTween.tween(boyfriend, {x: 900}, 1, {ease: FlxEase.quadInOut});

            strumLines.members[0].characters[1].x += 100;
            FlxTween.tween(strumLines.members[0].characters[1], {alpha: 1}, 1.5, {ease: FlxEase.quadInOut});
        case 230:
            middleCam(false);
        case 246:
            camMove = true;
        case 258:
            camMove = false;
            middleCam(true);
            cinematicBars(true, 1.2, 1);
        case 262:
            middleCam(false);
            badApple(false);
            cinematicBars(false, 0.2);
            camZoomingInterval = camZoomingStrength = 1;
            shakeCam = camMove = true;

            camHUD.flash(0xffffff, 0.7);
            if (Options.gameplayShaders) {
                camGame.removeShader(chromAbbShader);
                camHUD.removeShader(chromAbbShader);

                bloomIntensity = 4;
                bloomShader.hset("intensity", bloomIntensity);
            }

            strumLines.members[1].characters[0].x += 200;
            strumLines.members[1].characters[0].y += 85;
            strumLines.members[0].characters[1].x -= 100;

            staticThingy.alpha = 0.1;
        case 386:
            camZoomingStrength = 1;
            defaultCamZoom = 0.85;
            camMove = false;
            middleCam(true);
        case 390:
            camZoomingStrength = 0;
        case 396:
            camZoomingStrength = 2;
            camZoomingInterval = 4;
            camMove = true;
            middleCam(false);
        case 528:
            fakeTimer = false;
    }
}

function stepHit() {
    switch (curStep) {
        case 548, 1324:
            FlxTween.tween(FlxG.camera, {zoom: 0.95}, 0.1, {ease: FlxEase.quadOut, onComplete: (_) -> {
                defaultCamZoom = FlxG.camera.zoom;
            }});
        case 550, 1326:
            FlxTween.tween(FlxG.camera, {zoom: 1.05}, 0.1, {ease: FlxEase.quadOut, onComplete: (_) -> {
                defaultCamZoom = FlxG.camera.zoom;
            }});
        case 552, 1328:
            FlxTween.tween(FlxG.camera, {zoom: 1.15}, 0.1, {ease: FlxEase.quadOut, onComplete: (_) -> {
                defaultCamZoom = FlxG.camera.zoom;
            }});
        case 564, 1340:
            FlxTween.tween(FlxG.camera, {zoom: 0.95}, 0.1, {ease: FlxEase.quadOut, onComplete: (_) -> {
                defaultCamZoom = FlxG.camera.zoom;
            }});
        case 566, 1342:
            FlxTween.tween(FlxG.camera, {zoom: 1.05}, 0.1, {ease: FlxEase.quadOut, onComplete: (_) -> {
                defaultCamZoom = FlxG.camera.zoom;
            }});
        case 568, 1344:
            FlxTween.tween(FlxG.camera, {zoom: 1.15}, 0.1, {ease: FlxEase.quadOut, onComplete: (_) -> {
                defaultCamZoom = FlxG.camera.zoom;
            }});
        case 612, 1388:
            FlxTween.tween(FlxG.camera, {zoom: 1.1}, 0.1, {ease: FlxEase.quadOut, onComplete: (_) -> {
                defaultCamZoom = FlxG.camera.zoom;
            }});
        case 614, 1390:
            FlxTween.tween(FlxG.camera, {zoom: 1.2}, 0.1, {ease: FlxEase.quadOut, onComplete: (_) -> {
                defaultCamZoom = FlxG.camera.zoom;
            }});
        case 616, 1392:
            FlxTween.tween(FlxG.camera, {zoom: 1.3}, 0.1, {ease: FlxEase.quadOut, onComplete: (_) -> {
                defaultCamZoom = FlxG.camera.zoom;
            }});
    }
}

var badAppleEnabled = false;
function badApple(enabled:Bool = false) {
    if (enabled) {
        badAppleEnabled = true;
        staticThingy.alpha = 0;
        FlxG.camera.bgColor = FlxColor.WHITE;
        bg.visible = false;
        shadow.visible = false;
        
        strumLines.members[0].characters[1].alpha = 0.001;

        dontMiss.alpha = 0.6;
        FlxTween.tween(dontMiss, {alpha: 0, y: dontMiss.y - 70}, 1.7, {ease: FlxEase.quadOut});
        FlxTween.num(64, 100, 1.7, {ease: FlxEase.quadOut}, function(num) {
            dontMiss.setFormat(Paths.font('MilkyNice.ttf'), num, FlxColor.BLACK, FlxTextAlign.CENTER);
        });

        for (black in [iconP1, iconP2, boyfriend, strumLines.members[0].characters[1]]) {
            black.color = FlxColor.BLACK;
        }

        if (health > 0.02)
        {
            FlxTween.num(health, 0.02, 1, {ease: FlxEase.expoOut}, function(num) {
                health = num;
            });
        }
    } else {
        badAppleEnabled = false;
        FlxG.camera.bgColor = FlxColor.BLACK;
        bg.visible = true;
        shadow.visible = true;

        strumLines.members[0].characters[1].alpha = 1;
        strumLines.members[1].characters[0].alpha = 1;

        for (white in [iconP1, iconP2, boyfriend, strumLines.members[0].characters[1]]) {
            white.color = FlxColor.WHITE;
        }
    }
}

var shakeCam = false;

function onNoteHit(e) {
    if(health <= 0.2)
        if (strumLines.members[1].characters[0].animation.curAnim.name == 'idle') strumLines.members[1].characters[0].animation.play('scared', true);

    if (!e.note.isSustainNote) {
        switch(e.rating) {
            case "sick":
                e.rating = "mouse/sick";
            case "good":
                e.rating = "mouse/good";
            case "bad":
                e.rating = "mouse/bad";
            case "shit":
                e.rating = "mouse/shit";
        }
    }

    if (e.note.strumLine == playerStrums) return;
    if (shakeCam) {
        if(health > 0.2) health -= 0.02;

        FlxG.camera.shake(0.01, 0.035);
    }
}

var ratingCounts:Array<Int> = [0, 0, 0, 0];

function onPlayerHit(e) {
    if (badAppleEnabled) e.healthGain = 0;
    else e.healthGain = 0.02;
    
    if (e.note.isSustainNote) return;

    switch (e.rating) {
        case "shit":
            ratingCounts[0] += 1;
            ratingTxtGroup.members[0].text = "Shit: " + ratingCounts[0];
        case "bad":
            ratingCounts[1] += 1;
            ratingTxtGroup.members[1].text = "Bad: " + ratingCounts[1];
        case "good":
            ratingCounts[2] += 1;
            ratingTxtGroup.members[2].text = "Good: " + ratingCounts[2];
        case "sick":
            ratingCounts[3] += 1;
            ratingTxtGroup.members[3].text = "Sick: " + ratingCounts[3];
    }
}

function onEvent(e) {
    if (e.event.name != 'Camera Movement') return;
    new FlxTimer().start(0.01, (_) -> {
        if (curCameraTarget == 1) defaultCamZoom = 1.0;
        else defaultCamZoom = 0.85;
    });
}

function onCameraMove(e) {
    if (manualCam) e.cancel();
}

function middleCam(enabled:Bool = false) {
    manualCam = enabled;
    if (!enabled) return;

    camFollow.x = 1450;
    camFollow.y = 1100;
}

function onGameOver()
{
    FlxG.camera.bgColor = FlxColor.BLACK;

    if (Options.gameplayShaders) {
        FlxG.camera.removeShader(vhsShader);
        FlxG.camera.removeShader(vcrShader);
        FlxG.camera.removeShader(chromAbbShader);
        FlxG.camera.removeShader(blackNwhiteShader);
        FlxG.camera.removeShader(bloomShader);

        camHUD.removeShader(vhsShader);
        camHUD.removeShader(vcrShader);
        camHUD.removeShader(chromAbbShader);
        camHUD.removeShader(blackNwhiteShader);
        camHUD.removeShader(bloomShader);
    }
}

function destroy()
{
    if (Options.gameplayShaders) {
        FlxG.camera.removeShader(vhsShader);
        FlxG.camera.removeShader(vcrShader);
        FlxG.camera.removeShader(chromAbbShader);
        FlxG.camera.removeShader(blackNwhiteShader);
        FlxG.camera.removeShader(bloomShader);

        camHUD.removeShader(vhsShader);
        camHUD.removeShader(vcrShader);
        camHUD.removeShader(chromAbbShader);
        camHUD.removeShader(blackNwhiteShader);
        camHUD.removeShader(bloomShader);
    }
}